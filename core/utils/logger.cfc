<cfcomponent>

    <cfset VARIABLES.LEVEL_DEBUG.name = "DEBUG">
    <cfset VARIABLES.LEVEL_INFO.name = "INFO">
    <cfset VARIABLES.LEVEL_WARN.name = "WARN">
    <cfset VARIABLES.LEVEL_ERROR.name = "ERROR">
    <cfset VARIABLES.LEVEL_NONE.name = "NONE">

    <cfset VARIABLES.LEVEL_DEBUG.value = 0>
    <cfset VARIABLES.LEVEL_INFO.value = 1>
    <cfset VARIABLES.LEVEL_WARN.value = 2>
    <cfset VARIABLES.LEVEL_ERROR.value = 3>
    <cfset VARIABLES.LEVEL_NONE.value = 10>

    <cfset VARIABLES.LEVELS[VARIABLES.LEVEL_DEBUG.name] = VARIABLES.LEVEL_DEBUG.value>
    <cfset VARIABLES.LEVELS[VARIABLES.LEVEL_INFO.name] = VARIABLES.LEVEL_INFO.value>
    <cfset VARIABLES.LEVELS[VARIABLES.LEVEL_WARN.name] = VARIABLES.LEVEL_WARN.value>
    <cfset VARIABLES.LEVELS[VARIABLES.LEVEL_ERROR.name] = VARIABLES.LEVEL_ERROR.value>
    <cfset VARIABLES.LEVELS[VARIABLES.LEVEL_NONE.name] = VARIABLES.LEVEL_NONE.value>

    <!------------------------------------------------------------------------------->
    <cffunction name="init" access="public" returntype="any" output="false">
        <cfargument name="logFile" type="string" required="no" default="" hint="default logs to stdout as HTML">
        <cfargument name="level" type="string" required="no" default="#VARIABLES.LEVEL_INFO.name#">
        <cfargument name="log_session" type="boolean" required="no" default="false">
        <cfargument name="throw_on_write_error" type="boolean" required="no" default="true">

        <cfset setLevel(ARGUMENTS.level) />
        <cfset VARIABLES.logFile = ARGUMENTS.logFile />
        <cfset VARIABLES.logFileCreated = false />
        <cfset VARIABLES.logSession = ARGUMENTS.log_session />
        <cfset VARIABLES.throw_on_write_error = ARGUMENTS.throw_on_write_error />

        <cfreturn this />
    </cffunction>
    <!------------------------------------------------------------------------------->

    <!------------------------------------------------------------------------------->
    <cffunction name="getLogFileName" access="public" returntype="string" output="false">
        <cfreturn VARIABLES.logFile>
    </cffunction>
    <!------------------------------------------------------------------------------->

    <!------------------------------------------------------------------------------->
    <cffunction name="setLevel" access="public" returntype="void" output="false">
        <cfargument name="level" type="string" required="yes">

        <cfset var levelVal = "" />
        <cftry>
            <cfset levelVal = VARIABLES.LEVELS[ARGUMENTS.level]>
            <cfcatch>
                <cfthrow message="Invalid log level '#ARGUMENTS.level#'">
            </cfcatch>
        </cftry>

        <cfset VARIABLES.logLevelValue = levelVal>

    </cffunction>
    <!------------------------------------------------------------------------------->

    <!------------------------------------------------------------------------------->
    <cffunction name="addlog" access="public" returntype="void">
        <cfargument name="func" type="string" required="yes">
        <cfargument name="message" type="string" required="yes">
        <cfargument name="level" type="string" required="no" default="#VARIABLES.LEVEL_INFO.name#">

        <cfset var LOCAL = StructNew() />

        <cfif NOT StructKeyExists(VARIABLES, "logFile")>
            <cfthrow message="Logging not initialized">
        </cfif>

        <cftry>
            <cfset LOCAL.levelVal = VARIABLES.LEVELS[ARGUMENTS.level]>
            <cfcatch>
                <cfthrow message="Invalid log level '#ARGUMENTS.level#'">
            </cfcatch>
        </cftry>

        <cfif LOCAL.levelVal LT VARIABLES.logLevelValue OR LOCAL.levelVal EQ VARIABLES.LEVEL_NONE.value>
            <cfreturn>
        </cfif>

        <cfset LOCAL.curr_datetime = now()>

        <cfif VARIABLES.logSession EQ TRUE>
             <cfif StructKeyExists(SESSION, "SESSIONID")>
                 <cfset LOCAL.sessionString = " #SESSION.SESSIONID#:">
             <cfelse>
                 <cfset LOCAL.sessionString = " [no session]:">
             </cfif>
         <cfelse>
             <cfset LOCAL.sessionString = "">
         </cfif>

        <cfset LOCAL.logMessage = DateFormat(LOCAL.curr_datetime, 'yyyymmdd') & " " & TimeFormat(LOCAL.curr_datetime, 'HH:mm:ss.lll') &
                " (#ARGUMENTS.level#):#LOCAL.sessionString# #ARGUMENTS.func#(): #ARGUMENTS.message#">

        <cfif VARIABLES.logFile NEQ ''>

            <cftry>
                <cfif VARIABLES.logFileCreated EQ false AND NOT FileExists(VARIABLES.logFile)>
                    <cffile action="write" file="#VARIABLES.logFile#" output="File: #VARIABLES.logFile# on #CGI.SERVER_NAME#">
                    <cfset VARIABLES.logFileCreated = true>
                </cfif>

                <cffile action="append" file="#VARIABLES.logFile#" output="#LOCAL.logMessage#">
                <cfset VARIABLES.logFileCreated = true>

                <cfcatch type="any">
                    <cfif VARIABLES.throw_on_write_error EQ TRUE>
                        <cfrethrow>
                    </cfif>
                </cfcatch>
            </cftry>
        <cfelse>
            <!--- output to stdout as HTML --->
            <cfoutput><pre>#LOCAL.logMessage#</pre></cfoutput>
        </cfif>
    </cffunction>
    <!------------------------------------------------------------------------------->

    <!------------------------------------------------------------------------------->
    <cffunction name="addlogStart" access="public" returntype="void">
        <cfargument name="func" type="string" required="yes">
        <cfargument name="message" type="string" required="no" default="">
        <cfargument name="level" type="string" required="no" default="#VARIABLES.LEVEL_INFO.name#">

        <cfset var LOCAL = StructNew() />

        <cfif ARGUMENTS.message NEQ ''>
            <cfset LOCAL.spacer = ": ">
        <cfelse>
            <cfset LOCAL.spacer = "">
        </cfif>

        <cfset addlog(func = ARGUMENTS.func, message = "START" & LOCAL.spacer & ARGUMENTS.message, level = ARGUMENTS.level)>
    </cffunction>
    <!------------------------------------------------------------------------------->

    <!------------------------------------------------------------------------------->
    <cffunction name="addlogEnd" access="public" returntype="void">
        <cfargument name="func" type="string" required="yes">
        <cfargument name="message" type="string" required="no" default="">
        <cfargument name="level" type="string" required="no" default="#VARIABLES.LEVEL_INFO.name#">

        <cfset var LOCAL = StructNew() />

        <cfif ARGUMENTS.message NEQ ''>
            <cfset LOCAL.spacer = ": ">
        <cfelse>
            <cfset LOCAL.spacer = "">
        </cfif>

        <cfset addlog(func = ARGUMENTS.func, message = "END" & LOCAL.spacer & ARGUMENTS.message, level = ARGUMENTS.level)>

    </cffunction>
    <!------------------------------------------------------------------------------->

</cfcomponent>