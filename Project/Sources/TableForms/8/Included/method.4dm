If (Form event:C388=On Display Detail:K2:22)
	If ([Bilder:8]Kinoposter:7)
		OBJECT SET COLOR:C271(*;"bild";-(Yellow:K11:2+(256*Red:K11:4)))
	Else 
		OBJECT SET COLOR:C271(*;"bild";-(White:K11:1+(White:K11:1)))
	End if 
End if 