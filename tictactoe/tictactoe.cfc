<cfcomponent hint="Return messages to html 5 tic tac toe game"> 
   
   
    <cfif not isdefined("application.figleaf.tictactoe")>
    	<cfset application.figleaf.tictactoe = structnew()>
    </cfif>

    <cffunction name="onIncomingMessage" output="no"> 
        <cfargument name="CFEvent" type="struct" required="yes"> 
        
        
        <cfset var stmsg = structnew()>
        <cfset var command = "">
        <cfset var params = "">
        <cfset var stdata = "">
        <cfset var gameid = "">
        <cfset var thisitem = "">
        <cfset var originator = "">
        <cfset var outputmessage = structnew()>
                
        <!--- Create a return structure that contains the message. ---> 
        
		<cfif listlen(arguments.cfevent.data.message,":") is not 3>
           		<cfset  stmsg = { 
					command='ECHO', 
					message = arguments.cfevent.data.message, 
					target= listgetat(arguments.cfevent.data.message,2,':')
					}
				>
        <cfelse>
         
         <cftry>
		   
        	<cflog file="websocket" text="#arguments.cfevent.data.message#">
            	
            <cfset command = listfirst(arguments.cfevent.data.message,":")>
        	<cfset params = listgetat(arguments.cfevent.data.message,2,":")>
        	<cfset originator = listgetat(arguments.cfevent.data.message,3,":")>
            
        	<cfswitch expression="#command#">
            	<cfcase value="NEW">
        
         	 		 <!--- init game --->
               		 <cfset stdata = {
						player1SocketID = arguments.CFEvent.OriginatorID,
						player1ID = originator,
						player2ID = 0,
						player2SocketID = "",
						label = params	 
					 }>
                     
        			 <!--- create id --->
                     <cfset gameid = createuuid()>
                     <cfset application.figleaf.tictactoe[gameid] = stdata>
                     
                     <cfset stmsg = {
						 	command='NEW', 
							gameid = '#gameid#', 
							target='#originator#'
					  }>
                </cfcase>
                
                
                <cfcase value="LIST,LISTREFRESH">

                    <cfset agames = arraynew(1)>

                	<cfloop collection="#application.figleaf.tictactoe#" item="thisitem">
                    	<cfif application.figleaf.tictactoe[thisitem].player2id is 0>
                        	<cfset agames[arraylen(agames) + 1] = { uuid = thisitem, label = application.figleaf.tictactoe[thisitem].label}>
                        </cfif>
                    </cfloop>
                    <cfif command is "LIST">
                   		 <cfset stmsg = {
								command='LIST', 
								gamelist = agames, 
								target= originator
					 	 }>
                    <cfelse>
                     	<cfset stmsg = {
								command='LIST', 
								gamelist = agames, 
								target= "ALL"
					 	 }>
                    </cfif>
                </cfcase>
                
                <cfcase value="JOIN">
                         <cfif application.figleaf.tictactoe[params].player2id is 0>
                          	<cfset application.figleaf.tictactoe[params].player2socketid = arguments.cfevent.originatorid>
                            <cfset application.figleaf.tictactoe[params].player2id = originator>
                         
                         	<cfset stmsg = {
								command='JOINED',
								target = originator & "," & application.figleaf.tictactoe[params].player1id,
								player1 = application.figleaf.tictactoe[params].player1id,
								player2 = originator
							}>
                         </cfif>
                </cfcase>
                <cfcase value="MARK">
                	<cfset gameid = listfirst(params,"|")>
                    <cfset pos = listlast(params,"|")>
                	
					<cfset stmsg = {
							command="MARK",
							target = application.figleaf.tictactoe[gameid].player1id & "," &  application.figleaf.tictactoe[gameid].player2id,
							position = pos,
							originator = originator
						}>                   
                </cfcase>
                <cfcase value="delete">
                
                </cfcase>
            
            </cfswitch>
        
           <cfcatch type="any">
           		 <cflog file="tictactoe" text="Error: #cfcatch.message# #cfcatch.Detail#">
           		 <cfset  stmsg = {
					 	command='ECHO', 
						message = cfcatch.message & ":" & cfcatch.Detail, 
						target= originator
				 }>
           </cfcatch>
           </cftry>
		 
        </cfif>
       
       

       
       <!--- Send the return message back. ---> 
		<cfset outputmessage.message = serializejson(stmsg)>
        <cfreturn outputmessage> 
    </cffunction> 
    
    
    <cffunction name="onClientOpen" output="no">
    	<cfargument name="CFEvent" type="struct" required="yes"> 
    
    </cffunction>
    
    
     
    <cffunction name="onClientClose" output="no">
    	<cfargument name="CFEvent" type="struct" required="yes"> 
    
    </cffunction>
    
</cfcomponent>