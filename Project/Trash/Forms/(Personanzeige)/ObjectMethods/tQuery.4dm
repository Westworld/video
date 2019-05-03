If (Form event:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	If (Length:C16($text)>2)
		$query:="@"+$text+"@"
		
		QUERY:C277([Personen:17];[Personen:17]Suchname:5=$query)
	Else 
		ALL RECORDS:C47([Personen:17])
	End if 
	Actoranzeige_LoadListbox 
End if 