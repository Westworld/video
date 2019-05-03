//%attributes = {}
  // wird von OFDB aufrufen, Original und deutscher titel gesetzt, sucht


C_LONGINT:C283($1;$2)
C_TEXT:C284($3;$4;$5)
C_PICTURE:C286($dummypict)
$RufenderProzess:=$1
$FID:=$2
vOFDB_Erschienen:=""
vOFDB_Land:=""
vOFDB_Genre1:=""
vOFDB_Genre2:=""
vOFDB_Inhalt:=""
vOFDB_KleinBild:=$dummypict
vOFDB_OrigTItel:=$3
vOFDB_DtTitel:=$4
vOFDB_IMDB:=$5

If (vOFDB_OrigTItel="")
	OFDBprozess:=0
	ALERT:C41("Orig Titel leer, suche bei OFDB übersprungen")
Else 
	If (vOFDB_OrigTItel#"")
		$titel:=Replace string:C233(_O_Mac to ISO:C519(vOFDB_OrigTItel);" ";"%20")
		$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=OTitel&SText="+$titel
		  // $blob:=HTTP_GetURL($url;True)
		$result:=""
		  //$err:=Tools_HTTP_Download ("Text";->$result;$url)
		$status:=HTTP Get:C1157($url;$result)
		
		$gefunden:="http://www.ofdb.de/view.php?page=film&fid="
		Case of 
			: (HTTP_LastURL=($gefunden+"@"))  // Film gefunden"
				
				TheOFDB:=Substring:C12(HTTP_LastURL;Length:C16($gefunden)+1)
				
			: (HTTP_LastURL="http://www.ofdb.de/view.php?page=suchergebnis&Kat=OTitel&SText=@")  // Filmliste
				
				  // Mehrere gefunden, Array erstellen
				
				ARRAY TEXT:C222(Release;0)
				ARRAY TEXT:C222(Product;0)
				$schau:=HTTP_Parse ($result;"ofdb_Filmliste";->Release;->Product)
				For ($i;1;Size of array:C274(product))
					product{$i}:=HTML2Mac (product{$i})
				End for 
				$pos:=Find in array:C230(Product;(vOFDB_OrigTItel+" (@"))
				If ($pos>0)
					$pos2:=Find in array:C230(Product;(vOFDB_OrigTItel+" (@");$pos+1)
					If ($pos2>0)
						$pos:=0
					End if 
				End if 
				
				If ($pos>0)
					Product:=$pos
					TheOFDB:=Release{Product}
				Else 
					If (Size of array:C274(Product)>0)
						BRING TO FRONT:C326(Current process:C322)
						SET WINDOW TITLE:C213(vOFDB_DtTitel+" - "+vOFDB_OrigTItel)
						Dialog_Content:="ofdb"
						DIALOG:C40("AmazonFilmauswahl")
						TheOFDB:=Release{Product}
					Else 
						ALERT:C41("Film nicht gefunden, Titel verkürzen!")
						TheOFDB:="???"
					End if 
				End if 
			Else 
				ALERT:C41("Fehler bei Auswertung bei ofdb "+HTTP_LastURL)
		End case 
		
		If ((TheOFDB#"") & (TheOFDB#"???"))
			vOFDb_ID:=TheOFDB
			vOFDB_Erschienen:=""
			vOFDB_Land:=""
			vOFDB_Genre1:=""
			vOFDB_Genre2:=""
			vOFDB_Inhalt:=""
			vOFDB_KleinBild:=$dummypict
			GET PROCESS VARIABLE:C371($RufenderProzess;vOFDB_Inhalt;vOFDB_Inhalt)
			GET PROCESS VARIABLE:C371($RufenderProzess;vOFDB_KleinBild;vOFDB_KleinBild)
			
			Movie_Internet_OFDB_Daten_Sub 
		Else 
			vOFDB_IMDB:=""
			vOFDB_OrigTItel:=""
			vOFDB_DtTitel:=""
			vOFDB_Erschienen:=""
			vOFDB_Land:=""
			vOFDB_Genre1:=""
			vOFDB_Genre2:=""
			vOFDB_Inhalt:=""
			vOFDB_KleinBild:=$dummypict
		End if 
		
		
		OFDBprozess:=0
		SET PROCESS VARIABLE:C370($RufenderProzess;OFDBprozess;OFDBprozess)
		SET PROCESS VARIABLE:C370($RufenderProzess;TheOFDB;TheOFDB)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_KleinBild;vOFDB_KleinBild)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_IMDB;vOFDB_IMDB)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_OrigTItel;vOFDB_OrigTItel)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_DtTitel;vOFDB_DtTitel)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_Erschienen;vOFDB_Erschienen)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_Land;vOFDB_Land)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_Genre1;vOFDB_Genre1)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_Genre2;vOFDB_Genre2)
		SET PROCESS VARIABLE:C370($RufenderProzess;vOFDB_Inhalt;vOFDB_Inhalt)
		<>Job:="OFDB"
		POST OUTSIDE CALL:C329($RufenderProzess)
	End if 
End if 