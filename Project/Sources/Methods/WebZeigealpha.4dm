//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".html";"")

READ ONLY:C145(*)


$pos:=Position:C15("/";$para)
If ($pos>1)
	$media:=Substring:C12($para;1;$pos-1)
	$kat:=Substring:C12($para;$pos+1)
	If ($kat="0")
		QUERY:C277([Filme:1];[Filme:1]DtTitel:9<"A";*)
		QUERY:C277([Filme:1]; | [Filme:1]DtTitel:9>"ZZZZZ")
	Else 
		QUERY:C277([Filme:1];[Filme:1]DtTitel:9=($kat+"@"))
	End if 
	Web_SelectMedia ($media)
	
Else 
	REDUCE SELECTION:C351([Filme:1];0)
End if 
ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)

webkattyp:=$para

WEB SEND FILE:C619("Filmliste.html")
