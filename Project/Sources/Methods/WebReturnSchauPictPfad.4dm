//%attributes = {"publishedWeb":true}
C_TEXT:C284($0)
C_LONGINT:C283($1)

If (Count parameters:C259>0)
	$id:=arrSchauPID{$1}
	If ($id#0)
		If ($id#[Personen:17]PID:1)
			QUERY:C277([Personen:17];[Personen:17]PID:1=$id)
		End if 
	End if 
Else 
	$id:=[Personen:17]PID:1
End if 

$0:=""

If (Picture size:C356([Personen:17]Bild:2)>100)
	
	$0:=String:C10($id\1000)+"/"+String:C10($id)+"_1.jpg"
Else 
	If (Picture size:C356([Personen:17]Bild2:4)>100)
		
		$0:=String:C10($id\1000)+"/"+String:C10($id)+"_2.jpg"
	End if 
End if 
If ($0="")
	$0:="Empty.jpg"
End if 