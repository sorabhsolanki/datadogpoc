package com.poc.api.controller;

import com.timgroup.statsd.NonBlockingStatsDClient;
import com.timgroup.statsd.ServiceCheck;
import com.timgroup.statsd.StatsDClient;
import java.util.Random;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/document")
public class DocumentController {

  private static final Random random = new Random();

  private static final StatsDClient statsd = new NonBlockingStatsDClient(
      "my.prefix", /* prefix to any stats; may be null or empty string */
      "localhost", /* common case: localhost */
      8125, /* port */
      new String[] {"tag:sorabh"} /* Datadog extension: Constant tags, always applied */
  );

  @RequestMapping(value = "/v1/healthcheck", method = RequestMethod.GET)
  public ResponseEntity healthCheckup(@RequestParam(name = "type") String type)
      throws InterruptedException {

    if (type.equalsIgnoreCase("1")){

      long wait = waitRandomly();
      statsd.recordGaugeValue("latency", wait);
      statsd.incrementCounter("OK");
      dataDog();
      return ResponseEntity.ok("ok");
    }
    else {
      statsd.incrementCounter("ERROR");
      dataDog();
      return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  private long waitRandomly() throws InterruptedException {

    long in = System.currentTimeMillis();
    int val = random.nextInt(5);
    val *= 1000;
    Thread.sleep(val);
    long out = System.currentTimeMillis();

    return out - in;
  }

  private void dataDog(){

    ServiceCheck sc = ServiceCheck.builder().withName("my.check.name").withStatus(ServiceCheck.Status.OK).build();
    statsd.serviceCheck(sc); /* Datadog extension: send service check status */

/* Compatibility note: Unlike upstream statsd, DataDog expects execution times to be a
* floating-point value in seconds, not a millisecond value. This library
* does the conversion from ms to fractional seconds.
*/
    statsd.recordExecutionTime("bag", 25, "cluster:foo"); /* DataDog extension: cluster tag */

  }
}
