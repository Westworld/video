//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".gif";"")
READ ONLY:C145(*)


$pos:=Position:C15("_";$para)
GET PICTURE FROM LIBRARY:C565("KeinBild";$bild)
If ($pos>1)
	$FID:=Substring:C12($para;1;$pos-1)
	$SubID:=Substring:C12($para;$pos+1)
	QUERY:C277([Bilder:8];[Bilder:8]FID:1=$FID;*)
	QUERY:C277([Bilder:8];[Bilder:8]SubID:2=$SubID)
	If (Records in selection:C76([Bilder:8])#0)
		$bild:=[Bilder:8]dasbild:6
	End if 
End if 
_O_PICTURE TO GIF:C671($bild;$blobgif)
WEB SEND BLOB:C654($blobgif;".GIF")
