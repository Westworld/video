//%attributes = {}
$imagepfad:="\\POP-PC\\XBMC_Images\\"
$imageactorpfad:="\\POP-PC\\XBMC_Images\\Actors\\"


$pfad:=[Filme:1]MKV_Pfad:22
Case of 
	: ($pfad="/Network_share/nas1@")
		$pfad:=Replace string:C233($pfad;"/Network_share/nas1";"//Sharespace/Public")
	: ($pfad="/Network_share/nas2@")
		$pfad:=Replace string:C233($pfad;"/Network_share/nas2";"//nas2")
	: ($pfad="/SATA_DISK_A1/@")
		$pfad:=Replace string:C233($pfad;"/SATA_DISK_A1";"//popcorn/sata2/Filme")
		
	Else 
		  //TRACE
End case 
$pfad:=Replace string:C233($pfad;"/";"\\")
$nurpfad:=Tools_LongNameToPathName ($pfad)
$dateiname:=Tools_LongNameToFileName ($pfad)
$pos:=Position:C15(".";$dateiname)
$nfopfad:=Replace string:C233($pfad;Substring:C12($dateiname;$pos);".nfo")

$ref:=Create document:C266($nfopfad)
SAX OPEN XML ELEMENT:C853($Ref;"movie")
sax_writeelement ($ref;"title";[Filme:1]DtTitel:9)
sax_writeelement ($ref;"originaltitle";[Filme:1]EnTitel:2)
sax_writeelement ($ref;"year";[Filme:1]Jahr:4)
sax_writeelement ($ref;"plot";[Filme:1]Inhalt:7)
sax_writeelement ($ref;"runtime";String:C10([Filme:1]Länge:10))
sax_writeelement ($ref;"id";[Filme:1]imdb:15)
sax_writeelement ($ref;"country";[Filme:1]Land:3)
If ([Filme:1]Genre1:5#"")
	sax_writeelement ($ref;"genre";[Filme:1]Genre1:5)
End if 
If ([Filme:1]Genre2:6#"")
	sax_writeelement ($ref;"genre";[Filme:1]Genre2:6)
End if 
sax_writeelement ($ref;"dateadded";String:C10([Filme:1]purchasedate:20))

$filmsubpfad:=String:C10([Filme:1]FID:1\1000)+"\\"+String:C10([Filme:1]FID:1)

If (Picture size:C356([Filme:1]Bild:14)>100)
	$filmbildpfad:=$imagepfad+$filmsubpfad+".jpg"
	CREATE FOLDER:C475(Tools_LongNameToPathName ($filmbildpfad);*)
	WRITE PICTURE FILE:C680($filmbildpfad;[Filme:1]Bild:14)
	sax_writeelement ($ref;"thumb";$filmbildpfad)
End if 
QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
If (Records in selection:C76([Bilder:8])>0)
	  //create folder(Tools_LongNameToPathName($filmbildpfad);*)
	While (Not:C34(End selection:C36([Bilder:8])))
		$filmbildpfad:=$imagepfad+$filmsubpfad+"_"+String:C10([Bilder:8]SubID:2)+".jpg"
		WRITE PICTURE FILE:C680($filmbildpfad;[Bilder:8]dasbild:6)
		sax_writeelement ($ref;"thumb";$filmbildpfad)
		NEXT RECORD:C51([Bilder:8])
	End while 
End if 


QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="R")
If (Records in selection:C76([Mitwirkende:3])>0)
	QUERY:C277([Personen:17];[Personen:17]PID:1=[Mitwirkende:3]PID:2)
	sax_writeelement ($ref;"director";[Personen:17]Suchname:5)
End if 

QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3#"R")
While (Not:C34(End selection:C36([Mitwirkende:3])))
	QUERY:C277([Personen:17];[Personen:17]PID:1=[Mitwirkende:3]PID:2)
	SAX OPEN XML ELEMENT:C853($Ref;"actor")
	$actorpath:=WebReturnSchauPictPfad 
	If ($actorpath#"empty.jpg")
		If ($actorpath="@_1.jpg")
			$bild:=[Personen:17]Bild:2
		Else 
			$bild:=[Personen:17]Bild2:4
		End if 
		$actorpath:=$imageactorpfad+Replace string:C233($actorpath;"/";"\\")
		CREATE FOLDER:C475(Tools_LongNameToPathName ($actorpath);*)
		WRITE PICTURE FILE:C680($actorpath;$bild)
	Else 
		$actorpath:=$imageactorpfad+$actorpath
	End if 
	sax_writeelement ($ref;"name";[Personen:17]Suchname:5)
	sax_writeelement ($ref;"role";[Mitwirkende:3]Rolle:4)
	sax_writeelement ($ref;"thumb";$actorpath)
	SAX CLOSE XML ELEMENT:C854($Ref)
	NEXT RECORD:C51([Mitwirkende:3])
End while 

SAX CLOSE XML ELEMENT:C854($Ref)
CLOSE DOCUMENT:C267($ref)