package com.paytm.dm.api.controller;

import datadog.trace.api.DDTags;
import io.opentracing.Scope;
import io.opentracing.Tracer;
import io.opentracing.util.GlobalTracer;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/document")
public class DocumentController {

  @RequestMapping(value = "/v1/healthcheck", method = RequestMethod.GET)
  public ResponseEntity healthCheckup() {
    Tracer tracer = GlobalTracer.get();
    Scope scope = tracer.buildSpan("health-check").startActive(true);
    try {
      scope.span().setTag(DDTags.SERVICE_NAME, "poctag");
    } finally {
      scope.close();
    }
    return ResponseEntity.ok("200");
  }
}
