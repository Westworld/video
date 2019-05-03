If (Form event:C388=On Load:K2:1)
	Form:C1466.Filme:=Form:C1466.Actor.spieltinFilmen.query("Film # null")
	  //Form.Cast:=$cast.orderBy("Person.spieltinFilmen.length")
	  //Form.cast:=$cast.sort("Schau_Sort_Col")
	  // sortieren wie Schau_Sort???
	Film_anzeigen_listboxfill (True:C214)
End if 