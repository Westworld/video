Case of 
	: (Form event:C388=On Load:K2:1)
		If ([Personen:17]PID:1=0)
			ALL RECORDS:C47([Parameter:5])
			[Personen:17]PID:1:=[Parameter:5]PID:2
			[Parameter:5]PID:2:=[Parameter:5]PID:2+1
			SAVE RECORD:C53([Parameter:5])
		End if 
		Person_DoAutoLoad:=False:C215  // false für manuell/einzeln
		RELATE ONE SELECTION:C349([Mitwirkende:3];[Filme:1])
		Filmanzeige_LoadListbox 
		
		  //: (Form event=On Close Detail)
		  //If (AktSchauspieler#0)
		  //GOTO SELECTED RECORD([Mitwirkende];AktSchauspieler)
		  //$p:=New process("ModOrig";128000;"Film";[Mitwirkende]FID)
		  //AktSchauspieler:=0
		  //End if 
		
		  //: (Form event=On Outside Call)
		  //Case of 
		  //: (<>Job="Find IMDB Person")
		  //  // now the browser should display all data from imdb
		  //  //get data there
		  //[Personen]IMDB:=<>pageContent
		  //<>Job:="Load IMDB Person"
		  //<>JobUrl:="http://www.imdb.de/name/"+[Personen]IMDB+"/"
		  //<>Main:=Current process
		  //Browser_LaunchWindow 
		  //CALL PROCESS(<>browserWindow)
		
		  //: (<>Job="AutoFind IMDB Person")
		  //  // now the browser should display all data from imdb
		  //  //get data there
		  //$id:=HTTP_Parse (<>pageContent;"IMDB_AutoFindPerson")
		  //If ($id#"")
		  //[Personen]IMDB:=$id
		  //<>Job:="Load IMDB Person"
		  //<>JobUrl:="http://www.imdb.de/name/"+[Personen]IMDB+"/"
		  //<>Main:=Current process
		  //Browser_LaunchWindow 
		  //CALL PROCESS(<>browserWindow)
		  //Else 
		  //BEEP
		  //OBJECT GET COORDINATES(*;"bNext1";$Links;$Oben;$Rechts;$Unten)
		  //POST CLICK($links+1;$oben+1;Current process)
		  //End if 
		
		  //: (<>Job="Load IMDB Person")
		  //  // now the browser should display all data from imdb
		  //  //get data there
		  //$err:=Person_Internet_IMDB_Browser_Ge 
		  //<>Job:=""
		  //If (Person_DoAutoLoad)
		  //OBJECT GET COORDINATES(*;"bNext1";$Links;$Oben;$Rechts;$Unten)
		  //POST CLICK($links+1;$oben+1;Current process)
		  //Else 
		  //BEEP  // beim nächsten Mal
		
		  //End if 
		
		  //: (<>Job="Cancel AutoFind IMDB Person")
		
		  //If (Person_DoAutoLoad)
		  //BEEP
		  //OBJECT GET COORDINATES(*;"bNext1";$Links;$Oben;$Rechts;$Unten)
		  //POST CLICK($links+1;$oben+1;Current process)
		  //End if 
		  //End case 
End case 