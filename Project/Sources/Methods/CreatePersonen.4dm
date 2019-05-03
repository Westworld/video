//%attributes = {}
$Name:=$1
If (Count parameters:C259=2)
	$id:=$2
Else 
	$Id:=""
End if 

If ($name#"")
	CREATE RECORD:C68([Personen:17])
	If ([Personen:17]PID:1=0)
		ALL RECORDS:C47([Parameter:5])
		[Personen:17]PID:1:=[Parameter:5]PID:2
		[Parameter:5]PID:2:=[Parameter:5]PID:2+1
		SAVE RECORD:C53([Parameter:5])
	End if 
	[Personen:17]Suchname:5:=$name
	[Personen:17]IMDB:3:=$ID
	If ([Personen:17]IMDB:3#"")
		schauspieler_suchebeiOFDB 
		  // bild holen
		CreatePersonen_Bild 
	End if 
	SAVE RECORD:C53([Personen:17])
End if 
