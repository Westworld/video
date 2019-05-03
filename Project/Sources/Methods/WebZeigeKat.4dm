//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)

READ ONLY:C145(*)
$para:=Replace string:C233($para;".html";"")
$pos:=Position:C15("/";$para)
If ($pos>1)
	$media:=Substring:C12($para;1;$pos-1)
	$katid:=Num:C11(Substring:C12($para;$pos+1))
	
	If (($katid>0) & ($katid<=Size of array:C274(<>HTML_webart)))
		$kat:=<>HTML_webart{$katid}
	Else 
		  //TRACE
		$kat:=Substring:C12($para;$pos+1)  // noch irgendwo ein alter link wie früher verwendet?
	End if 
	
	QUERY:C277([Filme:1];[Filme:1]Genre1:5=$kat;*)
	QUERY:C277([Filme:1]; | [Filme:1]Genre2:6=$kat)
	
	Web_SelectMedia ($media)
Else 
	REDUCE SELECTION:C351([Filme:1];0)
End if 
ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)

webkattyp:=$kat

WEB SEND FILE:C619("Filmliste.html")
