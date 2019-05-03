Case of 
	: (Form event:C388=On Clicked:K2:4)
		NEXT RECORD:C51([Bilder:8])
		If (End selection:C36([Bilder:8]))
			FIRST RECORD:C50([Bilder:8])
		End if 
		
	: (Form event:C388=On Double Clicked:K2:5)
		$win:=Open form window:C675([Bilder:8];"Bilddarstellung")
		DIALOG:C40([Bilder:8];"Bilddarstellung")
		CLOSE WINDOW:C154($win)
End case 
