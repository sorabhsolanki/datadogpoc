<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Doc-Manager- View</title>
	<link rel="stylesheet" 
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
		integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		
		<!-- Optional theme -->
	<link rel="stylesheet" 
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" 
		integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </head>
  <body>
  	<!-- navbar -->
	<#--Hello! Stranger!!-->
		<#--<#list documentList.contentMap.entrySet() as entry>-->
    <#--<input type="hidden" name="${entry.key}" value="${entry.value}" />-->
		<#--</#list>-->

		<#--<#list documentList as item>-->
			<#--<#assign myObjectKey = item.getKey()/>-->
			<#--<#assign myObjectValue = item.getValue()/>-->
		  <#--${myObjectKey} :: ${myObjectValue}-->
		<#--</#list>-->
		<#--${myObjectKey}-->
	<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">
	      	<!-- <img src="/assets/images/brand.png" width="30" height="30" class="d-inline-block align-top" alt=""> -->
	      	<span class="glyphicon glyphicon-briefcase"></span>
	      	Document-Management
		  </a>
	    </div>
	  </div>
	</nav>
	<div class="container">
		<#--<div class="row">-->
			<#--<div class="panel panel-default">-->
				<#--<div class="panel-heading">-->
				  <#--<h3 class="panel-title">View Documents</h3>-->
				<#--</div>-->
    <#--&lt;#&ndash;<#list envList as environment >&ndash;&gt;-->
			<#--&lt;#&ndash;<#assign val=environment.getValue()/>&ndash;&gt;-->
		<#--&lt;#&ndash;</#list>&ndash;&gt;-->
		  	<#--<div  class="panel-body">-->
					<#--<form class="col-md-5" action="${env}/document/v1/view/search" method="GET">-->
					    <#--<div class="input-group">-->
					      <#--<input name="docIds" type="text" class="form-control" id="inputTwitter" placeholder="docUUId-1, docUUId-2, ..." required>-->
				   	  	  <#--<span class="input-group-btn">-->
					             <#--<button class="btn btn-default" type="submit">-->
					                <#--<i class="glyphicon glyphicon-search"></i>-->
					             <#--</button>-->
					          <#--</span>-->
					    <#--</div>-->
					<#--</form>-->
				<#--</div>-->
			<#--</div>-->
		<#--</div>-->
		<#if documentList?? && documentList?size gt 0>
		<div class="row">
			<div class="panel panel-default" style="margin-top:3%;">
				<div class="panel-heading">
				  <h3 class="panel-title">Files</h3>
				</div>
				<div id="documents" class="panel-body">
				<#list documentList as document>
					<#--<#assign myObjectKey = document.getKey()/>-->
					<#--<#assign myObjectValue = document.getValue()/>-->
				  <#if (document?? && document.getValue().getStatusCode()??&& document.getValue().getStatusCode()== "500")>
				 	<div class="alert alert-danger">
					  <strong>Fetching Failed!!</strong> Some error occurred in fetching document with uuid : ${document.requestId}
					</div>
				 <#else>
					 <#assign myObjectKey = document.getKey()/>
					 <#assign myObjectValue = document.getValue()/>
					 <div id="document" class="">
						<h5>File Name : ${myObjectValue.getFileName()}</h5>
						 <#if myObjectValue.getMimeType() =="image/jpeg">
					    <img style="max-width: 100%" src="data:${myObjectValue.getMimeType()};base64,${myObjectValue.getFileStream()}">
						 <#else>
					     <iframe width="100%" height="700" style="overflow-x:hidden; overflow-y:scroll;" src="data:${myObjectValue.getMimeType()};base64,${myObjectValue.getFileStream()}"></iframe>
					    <#--<object data="data:${myObjectValue.getMimeType()};base64, ${myObjectValue.getFileStream()}" type="${myObjectValue.getMimeType()}" width="100%" height="100%" style="min-height:450px"></object>-->
						 </#if>
					 <div class="w-100" style="margin-top:4px"></div>
				  </div>
				   </#if>
				</#list>
				</div>
			</div>
		</div>
		</#if>
	</div>
  </body>
</html>
