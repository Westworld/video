If (Form event:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	If (Length:C16($text)>2)
		$query:="@"+$text+"@"
		
		Form:C1466.Personen:=ds:C1482.Personen.query("Suchname=:1";$query)
	Else 
		Form:C1466.Personen:=ds:C1482.Personen.query("spieltinFilmen # null")
	End if 
	Actoranzeige_LoadListboxGrid (True:C214)
End if 