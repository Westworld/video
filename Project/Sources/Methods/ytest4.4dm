//%attributes = {}
ALL RECORDS:C47([Bilder:8])
While (Not:C34(End selection:C36([Bilder:8])))
	$old:=Picture size:C356([Bilder:8]dasbild:6)
	CONVERT PICTURE:C1002([Bilder:8]dasbild:6;".jpg")
	If ($old#Picture size:C356([Bilder:8]dasbild:6))
		SAVE RECORD:C53([Bilder:8])
	End if 
	NEXT RECORD:C51([Bilder:8])
End while 

ALL RECORDS:C47([Filme:1])
While (Not:C34(End selection:C36([Filme:1])))
	$old:=Picture size:C356([Filme:1]Bild:14)
	CONVERT PICTURE:C1002([Filme:1]Bild:14;".jpg")
	If ($old#Picture size:C356([Filme:1]Bild:14))
		SAVE RECORD:C53([Filme:1])
	End if 
	NEXT RECORD:C51([Filme:1])
End while 

ALL RECORDS:C47([Personen:17])
While (Not:C34(End selection:C36([Personen:17])))
	$old:=Picture size:C356([Filme:1]Bild:14)
	CONVERT PICTURE:C1002([Personen:17]Bild:2;".jpg")
	CONVERT PICTURE:C1002([Personen:17]Bild2:4;".jpg")
	CONVERT PICTURE:C1002([Personen:17]Bild3:10;".jpg")
	
	SAVE RECORD:C53([Personen:17])
	
	NEXT RECORD:C51([Personen:17])
End while 