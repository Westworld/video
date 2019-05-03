//%attributes = {}
  // exportiert einen Film (current record)

$katfolder:=$1
$process_in:=$2
$Filmfolder:=$3
$Filmbildvollfolder:=$4

$dir:=Folder separator:K24:12

QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1;*)
QUERY:C277([Bilder:8];[Bilder:8]Kinoposter:7=True:C214)
WebDisplayPoster:=Records in selection:C76([Bilder:8])
If (WebDisplayPoster#0)
	$bild:=[Bilder:8]dasbild:6
Else 
	If (Picture size:C356([Filme:1]Bild:14)>100)
		$bild:=[Filme:1]Bild:14
	Else 
		GET PICTURE FROM LIBRARY:C565("KeinBild";$bild)
	End if 
End if 

$blobgif:=GetPictureScaledBlob ($bild;150)

  //PICTURE PROPERTIES($bild;$breite;$hoehe)
  //If (($breite>150) | ($hoehe>150))
  //CREATE THUMBNAIL($bild;$bild;150;150;Scaled to fit prop centered;24)
  //End if 
  //PICTURE TO BLOB($bild;$blobgif;".jpg")
  //PICTURE TO GIF($bild;$blobgif)
BLOB TO DOCUMENT:C526($katfolder+$dir+String:C10([Filme:1]FID:1)+".jpg";$blobgif)
If (Popcorn_CollectJobs)
	APPEND TO ARRAY:C911(Popcorn_Copy;$katfolder+$dir+String:C10([Filme:1]FID:1)+".jpg")
End if 

  // nun den eigentlichen Film
QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1)
CREATE SET:C116([Mitwirkende:3];"m")
UNION:C120("Mitwirkende";"M";"Mitwirkende")  // für spätere teilsuche
CUT NAMED SELECTION:C334([Filme:1];"merken")  // Order by formula verändert auswahl für Originaltitel...
ORDER BY FORMULA:C300([Mitwirkende:3];Schau_Sort ;<)
SELECTION TO ARRAY:C260([Mitwirkende:3]PID:2;arrSchauPID;[Mitwirkende:3]Kennung:3;ArrSchauKenn;[Mitwirkende:3]Rolle:4;ArrSchauRolle;[Personen:17]Suchname:5;arrSchauName)
USE NAMED SELECTION:C332("merken")

QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
ORDER BY:C49([Bilder:8];[Bilder:8]SubID:2;>)

Web_FilmBildCounter:=1
PROCESS 4D TAGS:C816($process_in;$process_out)
g_WriteFileOut ($Filmfolder+String:C10([Filme:1]FID:1)+".html";$process_out)
If (Popcorn_CollectJobs)
	APPEND TO ARRAY:C911(Popcorn_Copy;$Filmfolder+String:C10([Filme:1]FID:1)+".html")
End if 

If (True:C214)
	  // nun Bilder
	FIRST RECORD:C50([Bilder:8])
	While (Not:C34(End selection:C36([Bilder:8])))
		$subpfad:=$Filmbildvollfolder+String:C10([Bilder:8]FID:1\1000)
		If (Test path name:C476($subpfad)#Is a folder:K24:2)
			CREATE FOLDER:C475($subpfad)
		End if 
		$neupfad:=$subpfad+Folder separator:K24:12+String:C10([Bilder:8]FID:1)+"_"+String:C10([Bilder:8]SubID:2)+".jpg"
		$blobgif:=GetPictureScaledBlob ([Bilder:8]dasbild:6;250)
		BLOB TO DOCUMENT:C526($neupfad;$blobgif)
		If (Popcorn_CollectJobs)
			APPEND TO ARRAY:C911(Popcorn_Copy;$neupfad)
		End if 
		  //PICTURE PROPERTIES([Bilder]dasbild;$breite;$hoehe)
		  //If (($breite>250) | ($hoehe>250))
		  //CREATE THUMBNAIL([Bilder]dasbild;$bild;250;250;Scaled to fit prop centered;24)
		  //Else 
		  //$bild:=[Bilder]dasbild
		  //End if 
		  //WRITE PICTURE FILE($neupfad;$bild)
		
		NEXT RECORD:C51([Bilder:8])
	End while 
End if 