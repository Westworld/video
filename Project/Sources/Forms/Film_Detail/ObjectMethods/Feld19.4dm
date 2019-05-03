Case of 
	: (Form event:C388=On Clicked:K2:4)
		Form:C1466.BildIndex:=Form:C1466.BildIndex+1
		If (Form:C1466.BildIndex>=Form:C1466.Movie.Bilder.length)
			Form:C1466.BildIndex:=0
		End if 
		
	: (Form event:C388=On Double Clicked:K2:5)
		C_COLLECTION:C1488($col)
		$col:=Form:C1466.Movie.Bilder.toCollection("dasbild")
		$form:=New object:C1471("bilder";$col;"BildIndex";0)
		$win:=Open form window:C675("Bilddarstellung")
		DIALOG:C40("Bilddarstellung";$form)
		CLOSE WINDOW:C154($win)
End case 
