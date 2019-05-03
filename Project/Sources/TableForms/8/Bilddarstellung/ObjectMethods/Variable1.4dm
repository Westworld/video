If (Form event:C388=On Clicked:K2:4)
	NEXT RECORD:C51([Bilder:8])
	If (End selection:C36([Bilder:8]))
		FIRST RECORD:C50([Bilder:8])
	End if 
	
End if 