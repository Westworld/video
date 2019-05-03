If (Form event:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	If (Length:C16($text)>2)
		$query:="@"+$text+"@"
		
		QUERY:C277([Filme:1];[Filme:1]DtTitel:9=$query;*)
		QUERY:C277([Filme:1]; | [Filme:1]EnTitel:2=$query)
		CREATE SET:C116([Filme:1];"s1")
		QUERY:C277([Personen:17];[Personen:17]Suchname:5=$query)
		RELATE MANY SELECTION:C340([Mitwirkende:3]PID:2)
		RELATE ONE SELECTION:C349([Mitwirkende:3];[Filme:1])
		CREATE SET:C116([Filme:1];"s2")
		UNION:C120("s1";"s2";"s1")
		USE SET:C118("s1")
	Else 
		ALL RECORDS:C47([Filme:1])
	End if 
	Filmanzeige_LoadListbox 
End if 