<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<!---
<cfset cfctest = createobject("component","tictactoe")>


<cfset cevent = {   } >
<cfset cevent.data.message = "JOIN:ADE38A6F-265E-3838-F5D9B53C315C2232:C2B6984CBA654F1F92AB3E9101DF9C19">
<cfset cevent.destinationid = "200">

<cfset cfctest.onincomingmessage( cevent)>
--->

<cfif isdefined("url.reset")>
	<cfset structdelete(application.figleaf,"tictactoe")>
</cfif>



<cfdump var="#application#">
</body>
</html>