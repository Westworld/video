//%attributes = {}
C_LONGINT:C283($1)

SET MENU BAR:C67(1)
Bildprozess:=0
Amazonprozess:=0
IMDBprozess:=0
OFDBprozess:=0
DEFAULT TABLE:C46([Filme:1])
FORM SET INPUT:C55([Filme:1];"Eingabe")
FORM SET OUTPUT:C54([Filme:1];"Ausgabe")
$ref:=Open form window:C675([Filme:1];"Eingabe")

If (Count parameters:C259>0)
	QUERY:C277([Filme:1];[Filme:1]FID:1=$1)
	MODIFY RECORD:C57([Filme:1];*)
Else 
	ALL RECORDS:C47([Filme:1])
	MODIFY SELECTION:C204([Filme:1];*)
	LOAD RECORD:C52([Filme:1])
End if 

CLOSE WINDOW:C154($ref)