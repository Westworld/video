//%attributes = {}
SET WINDOW TITLE:C213("Hole Bildliste bei IMDb")

C_LONGINT:C283($1;$FID)
C_TEXT:C284($2;$IMDB_ID)

$FID:=$1
$IMDB_ID:=$2
If ($IMDB_ID="tt@")
	$IMDB_ID:=Substring:C12($IMDB_ID;3)
End if 

Film_IMDB_ID:=$FID
  // $url:="http://www.imdb.com/EGallery?source=ss&group="+$IMDB_ID

  // $url:="http://www.imdb.com/gallery/ss/"+$IMDB_ID
$url:="http://www.imdb.com/title/tt"+$IMDB_ID+"/mediaindex"  // ab 25.7.10
  // $blob:=HTTP_GetURL($url)
$result:=""
$status:=HTTP Get:C1157($url;$result)
  // $err:=Tools_HTTP_Download ("Text";->$result;$url)
If ($result#"")
	ARRAY TEXT:C222(Image;0)
	ARRAY TEXT:C222(Image1;0)
	ARRAY PICTURE:C279(Bild_Image;0)
	$schau:=HTTP_Parse ($result;"IMBD_Bilder";->Image;->Image1)
	If (Size of array:C274(Image)>0)
		
		$old:=Size of array:C274(Image)
		
		  // Seite 2
		$result:=""
		$url:=$url+"?page=2"
		$status:=HTTP Get:C1157($url;$result)
		  //$err:=Tools_HTTP_Download ("Text";->$result;$url)
		If ($result#"")
			ARRAY TEXT:C222($Image;0)
			ARRAY TEXT:C222($Image1;0)
			$schau:=HTTP_Parse ($result;"IMBD_Bilder";->$Image;->$Image1)
			For ($i;1;Size of array:C274($Image1))
				If (Find in array:C230(Image1;$image1{$i})<=0)
					APPEND TO ARRAY:C911(Image;$image{$i})
					APPEND TO ARRAY:C911(Image1;$image1{$i})
				End if 
			End for 
		End if 
		
		If ($old<Size of array:C274(Image))
			  // Seite 3
			$result:=""
			$url:=Replace string:C233($url;"?page=2";"?page=3")
			  //$err:=Tools_HTTP_Download ("Text";->$result;$url)
			$status:=HTTP Get:C1157($url;$result)
			If ($result#"")
				ARRAY TEXT:C222($Image;0)
				ARRAY TEXT:C222($Image1;0)
				$schau:=HTTP_Parse ($result;"IMBD_Bilder";->$Image;->$Image1)
				For ($i;1;Size of array:C274($Image1))
					If (Find in array:C230(Image1;$image1{$i})<=0)
						APPEND TO ARRAY:C911(Image;$image{$i})
						APPEND TO ARRAY:C911(Image1;$image1{$i})
					End if 
				End for 
			End if 
		End if 
		
		$win:=Open form window:C675("IMDBBilderauswahl")
		DIALOG:C40("IMDBBilderauswahl")
		CLOSE WINDOW:C154($win)
		
		
	End if 
End if 
