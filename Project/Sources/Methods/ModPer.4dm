//%attributes = {}
SET MENU BAR:C67(1)

READ ONLY:C145([Filme:1])
READ WRITE:C146([Personen:17])
$ref:=Open form window:C675([Personen:17];"Eingabe")

FORM SET INPUT:C55([Personen:17];"Eingabe")
FORM SET OUTPUT:C54([Personen:17];"ausgabe")
ALL RECORDS:C47([Personen:17])
MODIFY SELECTION:C204([Personen:17];*)
CLOSE WINDOW:C154($ref)