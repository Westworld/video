If (Form event:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	If (Length:C16($text)>2)
		$query:="@"+$text+"@"
		
		Form:C1466.Filme:=ds:C1482.Filme.query("DtTitel=:1 | EnTitel=:1 | Mitwirkende.Person.Suchname=:1";$query)
		
	Else 
		Form:C1466.Filme:=ds:C1482.Filme.all()
	End if 
	Film_anzeigen_listboxfill (True:C214)
End if 