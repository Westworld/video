//%attributes = {}
  // sucht alle fehlenden schauspieler infos bei OFDB, und von dort bei IMDB

QUERY:C277([Personen:17];[Personen:17]OFDB:9="")
While (Not:C34(End selection:C36([Personen:17])))
	If ([Personen:17]IMDB:3#"")
		schauspieler_suchebeiOFDB ([Personen:17]IMDB:3)
	End if 
	MESSAGE:C88([Personen:17]Suchname:5)
	NEXT RECORD:C51([Personen:17])
End while 