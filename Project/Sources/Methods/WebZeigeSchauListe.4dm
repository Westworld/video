//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
READ ONLY:C145(*)

$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".html";"")

If ($para="0")
	QUERY:C277([Personen:17];[Personen:17]Suchname:5<"A";*)
	QUERY:C277([Personen:17]; | [Personen:17]Suchname:5>"ZZZZZ")
Else 
	QUERY:C277([Personen:17];[Personen:17]Suchname:5=($para+"@"))
End if 

CREATE SET:C116([Personen:17];"alle")
Web_CheckPersonen 
INTERSECTION:C121("Alle";"<>Vorhanden";"Alle")
USE SET:C118("Alle")

ORDER BY:C49([Personen:17];[Personen:17]Suchname:5;>)
WEB SEND FILE:C619("Schauliste.html")
