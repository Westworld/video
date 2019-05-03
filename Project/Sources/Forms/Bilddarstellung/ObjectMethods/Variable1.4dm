If (Form event:C388=On Clicked:K2:4)
	Form:C1466.BildIndex:=Form:C1466.BildIndex+1
	If (Form:C1466.BildIndex>=Form:C1466.bilder.length)
		Form:C1466.BildIndex:=0
	End if 
	
End if 