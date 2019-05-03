//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".gif";"")
READ ONLY:C145(*)


QUERY:C277([Personen:17];[Personen:17]PID:1=Num:C11($para))
If (Picture size:C356([Personen:17]Bild:2)>100)
	$blobgif:=GetPictureScaledBlob ([Personen:17]Bild:2;173)
	  // CREATE THUMBNAIL([Personen]Bild;$bild;173;173;Scaled to fit prop centered;24)
	  // $bild:=[Originaltitel]Bild
Else 
	GET PICTURE FROM LIBRARY:C565("KeinBild";$bild)
	PICTURE TO BLOB:C692($bild;$blobgif;".jpg")
End if 
  //PICTURE TO GIF($bild;$blobgif)
  // PICTURE TO BLOB($bild;$blobgif;".jpg")
  // PICTURE TO BLOB($bild;$blobgif)
WEB SEND BLOB:C654($blobgif;".jpg")

