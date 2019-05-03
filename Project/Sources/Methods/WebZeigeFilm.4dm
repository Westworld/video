//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".html";"")

READ ONLY:C145(*)

QUERY:C277([Filme:1];[Filme:1]FID:1=Num:C11($para))
QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=Num:C11($para))
ORDER BY FORMULA:C300([Mitwirkende:3];Schau_Sort ;<)
SELECTION TO ARRAY:C260([Mitwirkende:3]PID:2;arrSchauPID;[Mitwirkende:3]Kennung:3;ArrSchauKenn;[Mitwirkende:3]Rolle:4;ArrSchauRolle;[Personen:17]Suchname:5;arrSchauName)
QUERY:C277([Bilder:8];[Bilder:8]FID:1=Num:C11($para))
ORDER BY:C49([Bilder:8];[Bilder:8]SubID:2;>)

WEB SEND FILE:C619("Film.html")