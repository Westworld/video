Case of 
	: (Form event:C388=On Load:K2:1)
		If (Form:C1466.Personen=Null:C1517)
			Form:C1466.Personen:=ds:C1482.Personen.query("spieltinFilmen # null").orderBy(spieltinFilmen.length)
		End if 
		
		Actoranzeige_LoadListboxGrid (True:C214)
		
	: (Form event:C388=On Resize:K2:27)
		
		Actoranzeige_LoadListboxGrid 
		
		
End case 