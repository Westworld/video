//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".html";"")

READ ONLY:C145([Personen:17])
QUERY:C277([Personen:17];[Personen:17]PID:1=Num:C11($para))

WEB SEND FILE:C619("Schau.html")
