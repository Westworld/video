If (Form event:C388=On Load:K2:1)
	If (Form:C1466.movies=Null:C1517)
		Form:C1466.movies:=ds:C1482.Originaltitel.all().orderBy("Titel_EN")
	End if 
End if 