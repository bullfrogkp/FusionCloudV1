 <cfset restInitApplication("C:\ColdFusion10\cfusion\wwwroot\cfcart\webservice","hh")>
<!----code starts---->
<cfhttp url="http://127.0.0.1:8500/rest/IIT/student/1" method="get">
<cfoutput>#cfhttp.filecontent#</cfoutput>
<!----code ends----->