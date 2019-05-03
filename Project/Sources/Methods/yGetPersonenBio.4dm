//%attributes = {}
  // holt Biographie für alle Personen

ALL RECORDS:C47([Personen:17])
While (Not:C34(End selection:C36([Personen:17])))
	If ([Personen:17]IMDB:3#"")
		If ([Personen:17]Kommentar:8="")
			If ([Personen:17]OFDB:9="")
				schauspieler_suchebeiOFDB 
				SAVE RECORD:C53([Personen:17])
				MESSAGE:C88([Personen:17]Suchname:5+" "+[Personen:17]Geboren:6+" "+[Personen:17]Kommentar:8)
			End if 
		End if 
	End if 
	NEXT RECORD:C51([Personen:17])
End while 