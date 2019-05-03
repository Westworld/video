Case of 
		
	: (Form event:C388=On Load:K2:1)
		
		If (Form:C1466.Filme=Null:C1517)
			Form:C1466.Filme:=ds:C1482.Filme.all().orderBy("purchasedate desc")
		End if 
		
		Film_anzeigen_listboxfill (True:C214)
		
	: (Form event:C388=On Resize:K2:27)
		Film_anzeigen_listboxfill 
		
End case 