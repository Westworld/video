//%attributes = {}
  // prüft ob es Personen ohne Filme gibt

$sel:=ds:C1482.Mitwirkende.query("Person = null")
$sel.drop()

$selactor:=ds:C1482.Personen.query("spieltinFilmen = null")
  // nicht löschen

$selactor:=ds:C1482.Personen.query("spieltinFilmen = null and Suchname = ''")
$selactor.drop()




$selactor:=ds:C1482.Personen.query("Suchname = ''")
For each ($person;$selactor)
	If ($person.MovieDB#0)
		$Actor:=MovieDBGetPersonDetails_Orda ($person.MovieDB;$person)
		  // save erfolgt im code
		DELAY PROCESS:C323(Current process:C322;60)
	Else 
		
	End if 
End for each 

$selactor:=ds:C1482.Personen.query("Suchname = ''")

