//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
$para:=Substring:C12($1;2)
$para:=Replace string:C233($para;".gif";"")
READ ONLY:C145(*)


QUERY:C277([Filme:1];[Filme:1]FID:1=Num:C11($para))

If (Picture size:C356([Filme:1]Bild:14)>100)
	$blobgif:=GetPictureScaledBlob ([Filme:1]Bild:14;173)
	
	  //CREATE THUMBNAIL([Originaltitel]Bild;$bild;173;173;Scaled to fit prop centered;24)
	
	  // $bild:=[Originaltitel]Bild
Else 
	GET PICTURE FROM LIBRARY:C565("KeinBild";$bild)
	PICTURE TO BLOB:C692($bild;$blobgif;".jpg")
End if 
  //PICTURE TO GIF($bild;$blobgif)
  // PICTURE TO BLOB($bild;$blobgif;".jpg")
  // PICTURE TO BLOB($bild;$blobgif)
WEB SEND BLOB:C654($blobgif;".jpg")

