//%attributes = {"invisible":true}
C_LONGINT:C283($1)
QUERY:C277([Personen:17];[Personen:17]PID:1=$1)

$win:=Open form window:C675([Personen:17];"Eingabe")
SET MENU BAR:C67("Editmodus")
FORM SET INPUT:C55([Personen:17];"Eingabe")
MODIFY RECORD:C57([Personen:17];*)
CLOSE WINDOW:C154($win)

