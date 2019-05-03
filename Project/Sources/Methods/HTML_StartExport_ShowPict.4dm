//%attributes = {}
  // Aufruf von HTML_StartExport für jedes Bild

  //$1= Bild
  // $2= ID
  // $3= Pointer auf Webpfadname

$bild:=$1

$SchaubildVollfolder:=$4
$Schaubildkleinfolder:=$5
PICTURE PROPERTIES:C457($bild;$breite;$hoehe)

If (Picture size:C356($bild)>100)
	$subpfad:=$SchaubildVollfolder+String:C10([Personen:17]PID:1\1000)
	If (Test path name:C476($subpfad)#Is a folder:K24:2)
		CREATE FOLDER:C475($subpfad)
	End if 
	
	$pfad:=$subpfad+Folder separator:K24:12+String:C10([Personen:17]PID:1)+"_"+String:C10($2)+".jpg"
	$3->:=String:C10([Personen:17]PID:1\1000)+"/"+String:C10([Personen:17]PID:1)+"_"+String:C10($2)+".jpg"
	WRITE PICTURE FILE:C680($pfad;$bild;".jpg")
	If (Popcorn_CollectJobs)
		APPEND TO ARRAY:C911(Popcorn_Copy;$pfad)
	End if 
	
	$subpfad:=$Schaubildkleinfolder+String:C10([Personen:17]PID:1\1000)
	If (Test path name:C476($subpfad)#Is a folder:K24:2)
		CREATE FOLDER:C475($subpfad)
	End if 
	$pfad:=$subpfad+Folder separator:K24:12+String:C10([Personen:17]PID:1)+"_"+String:C10($2)+".jpg"
	  //PICTURE PROPERTIES($bild;$breite;$hoehe)
	  //If (($breite>80) | ($hoehe>80))
	  //CREATE THUMBNAIL($bild;$bild;80;80;Scaled to fit prop centered;24)
	  //End if 
	  //WRITE PICTURE FILE($pfad;$bild)
	$blobgif:=GetPictureScaledBlob ($bild;80)
	BLOB TO DOCUMENT:C526($pfad;$blobgif)
	If (Popcorn_CollectJobs)
		APPEND TO ARRAY:C911(Popcorn_Copy;$pfad)
	End if 
Else 
	  // GET PICTURE FROM LIBRARY("KeinBild";$bild)
	  //$pfad:=$SchaubildVollfolder+"Empty.jpg"
	$3->:="Empty.jpg"
End if 