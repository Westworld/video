//%attributes = {}
C_LONGINT:C283($1)
QUERY:C277([Filme:1];[Filme:1]FID:1=$1)

$win:=Open form window:C675([Filme:1];"Film_Detail")
SET MENU BAR:C67("Editmodus")
FORM SET INPUT:C55([Filme:1];"Film_Detail")
MODIFY RECORD:C57([Filme:1];*)
CLOSE WINDOW:C154($win)

