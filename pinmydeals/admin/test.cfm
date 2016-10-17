 <cfset restInitApplication("#APPLICATION.absolutePathCore#webservice","hh")>
<!----code starts---->
<cfhttp url="http://api.pinmydeals.loc:8500/rest/admin/student/1" method="get">
<cfoutput>#cfhttp.filecontent#</cfoutput>
<!----code ends----->