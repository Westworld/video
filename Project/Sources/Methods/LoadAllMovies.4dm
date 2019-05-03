//%attributes = {}
If (Count parameters:C259>0)
	ALL RECORDS:C47([Filme:1])
End if 

If (Records in selection:C76([Filme:1])=Records in table:C83([Filme:1]))
	If (Size of array:C274(<>Filme_ID)#Records in table:C83([Filme:1]))
		
		If (Not:C34(Semaphore:C143("$LoadMovies")))
			
			SELECTION TO ARRAY:C260([Filme:1]Bild:14;<>Filme_Bilder;[Filme:1]DtTitel:9;<>Filme_Titel;[Filme:1]FID:1;<>Filme_ID)
			CLEAR SEMAPHORE:C144("$LoadMovies")
		End if 
	End if 
	COPY ARRAY:C226(<>Filme_Bilder;Filme_Bilder)
	COPY ARRAY:C226(<>Filme_Titel;Filme_Titel)
	COPY ARRAY:C226(<>Filme_ID;Filme_ID)
	
Else 
	SELECTION TO ARRAY:C260([Filme:1]Bild:14;Filme_Bilder;[Filme:1]DtTitel:9;Filme_Titel;[Filme:1]FID:1;Filme_ID)
	
End if 
UNLOAD RECORD:C212([Filme:1])