//%attributes = {}
  // erzeugt HTML export
  // zuerst  quellordner = web copy
  //  dann Auswahl ziel
  // dann indexfile kopieren

C_TEXT:C284($process_in;$process_out)
USE CHARACTER SET:C205("UTF-8";1)
USE CHARACTER SET:C205("UTF-8";0)
Popcorn_CollectJobs:=False:C215
ARRAY TEXT:C222(Popcorn_Copy;0)

$dir:=Folder separator:K24:12
  // $quell:=Select folder("Quellordner auswählen, normal Webfolder")
html_quellordner:=Tools_LongNameToPathName (Structure file:C489)+"Webcopy"+$dir

<>HTML_Process:=True:C214

ALL RECORDS:C47([Filme:1])
ARRAY TEXT:C222(<>HTML_webart;0)
DISTINCT VALUES:C339([Filme:1]Genre1:5;<>HTML_webart)
DISTINCT VALUES:C339([Filme:1]Genre2:6;$art2)
For ($i;1;Size of array:C274($art2))
	$pos:=Find in array:C230(<>HTML_webart;$art2{$i})
	If ($pos<0)
		APPEND TO ARRAY:C911(<>HTML_webart;$art2{$i})
	End if 
End for 
SORT ARRAY:C229(<>HTML_webart)
If (<>HTML_webart{1}="")
	DELETE FROM ARRAY:C228(<>HTML_webart;1)
End if 

  //$ziel:=Select folder("Ziel auswählen")
ALL RECORDS:C47([Parameter:5])
$ziel:=[Parameter:5]Pfad_offlineHTML:4
OK:=1
If (OK=1)
	
	ON ERR CALL:C155("No_error")
	DELETE DOCUMENT:C159($ziel+"index.html")
	DELETE DOCUMENT:C159($ziel+"Schauspieler.html")
	
	ON ERR CALL:C155("Amz_error")
	<>errorNum:=0
	COPY DOCUMENT:C541(html_quellordner+"index.html";$ziel+"Index.html")
	COPY DOCUMENT:C541(html_quellordner+"DVD.jpg";$ziel+"DVD.jpg")
	COPY DOCUMENT:C541(html_quellordner+"SVHS.jpg";$ziel+"SVHS.jpg")
	COPY DOCUMENT:C541(html_quellordner+"BluRay.png";$ziel+"BluRay.png")
	COPY DOCUMENT:C541(html_quellordner+"MKV.png";$ziel+"MKV.png")
	COPY DOCUMENT:C541(html_quellordner+"Play.png";$ziel+"Play.png")
	COPY DOCUMENT:C541(html_quellordner+"play_selected.png";$ziel+"play_selected.png")
	COPY DOCUMENT:C541(html_quellordner+"Schauspieler.html";$ziel+"Schauspieler.html")
	COPY DOCUMENT:C541(html_quellordner+"Film.css";$ziel+"Film.css")
	
	  //DOCUMENT TO BLOB(html_quellordner+"Schauspieler.shtml";$blobin)
	  //PROCESS HTML TAGS($blobin;$blobout)
	  //BLOB TO DOCUMENT($ziel+"Schauspieler.html";$blobout)
	
	If (<>errorNum=0)
		html_mainfolder:=$ziel+"4DAction"
		CREATE FOLDER:C475(html_mainfolder)
		
		$katfolder:=html_mainfolder+$dir+"WebKat"
		CREATE FOLDER:C475($katfolder)
		
		$Filmfolder:=html_mainfolder+$dir+"WebZeigeFilm"+$dir
		CREATE FOLDER:C475($Filmfolder)
		
		$Personenfolder:=html_mainfolder+$dir+"WebZeigeSchau"+$dir
		CREATE FOLDER:C475($Personenfolder)
		
		$Personenlistefolder:=html_mainfolder+$dir+"WebZeigeSchauListe"+$dir
		CREATE FOLDER:C475($Personenlistefolder)
		
		$Filmbildkleinfolder:=html_mainfolder+$dir+"WebFilmbildklein"+$dir
		CREATE FOLDER:C475($Filmbildkleinfolder)
		$FilmbildVollfolder:=html_mainfolder+$dir+"WebFilmbildVoll"+$dir
		CREATE FOLDER:C475($FilmbildVollfolder)
		
		$SchaubildVollfolder:=html_mainfolder+$dir+"WebSchauPict"+$dir
		CREATE FOLDER:C475($SchaubildVollfolder)
		$Schaubildkleinfolder:=html_mainfolder+$dir+"WebSchauPictklein"+$dir
		CREATE FOLDER:C475($Schaubildkleinfolder)
		
		CREATE EMPTY SET:C140([Filme:1];"Filme")
		CREATE EMPTY SET:C140([Mitwirkende:3];"Mitwirkende")
		
		If (<>errorNum=0)
			$katfolder:=$katfolder+$dir
			
			MESSAGE:C88("Erzeuge Kategorienliste")
			
			HTML_StartExport_Kat ("Alle";$katfolder)
			If (<>errorNum=0)
				HTML_StartExport_Kat ("DVD";$katfolder)
			End if 
			If (<>errorNum=0)
				HTML_StartExport_Kat ("BluRay";$katfolder)
			End if 
			If (<>errorNum=0)
				HTML_StartExport_Kat ("SVHS";$katfolder)
			End if 
			If (<>errorNum=0)
				HTML_StartExport_Kat ("MKV";$katfolder)
			End if 
			If (<>errorNum=0)
				HTML_StartExport_Neue ("Neue";$katfolder)
			End if 
		End if 
		
		If (<>errorNum=0)
			  // für alle Filme  Kleinbild für Filmliste, einzelbilder + links
			USE SET:C118("Filme")
			$katfolder:=html_mainfolder+$dir+"WebFilmPict"
			CREATE FOLDER:C475($katfolder)
			$process_in:=g_ReadFileIn (html_quellordner+"Film.html")
			  // DOCUMENT TO BLOB(html_quellordner+"Film.html";$blobin)
			
			ALL RECORDS:C47([Filme:1])
			FIRST RECORD:C50([Filme:1])
			While (Not:C34(End selection:C36([Filme:1])))
				MESSAGE:C88("Schreibe Filme "+String:C10(Selected record number:C246([Filme:1]);"^^^^^^0")+" von "+String:C10(Records in selection:C76([Filme:1])))
				
				HTML_StartExport_Film ($katfolder;$process_in;$Filmfolder;$Filmbildvollfolder)
				
				If (<>errorNum#0)
					LAST RECORD:C200([Filme:1])
				End if 
				
				NEXT RECORD:C51([Filme:1])
			End while 
			
			If (<>errorNum=0)
				MESSAGE:C88("Schreibe Personen")
				  // für alle Filme Schauspieler zusammenstellen
				  // für alle Schauspieler...
				
				USE SET:C118("Filme")  // alle vorhandenen Filme
				RELATE MANY SELECTION:C340([Mitwirkende:3]FID:1)  // von Originaltitel
				RELATE ONE SELECTION:C349([Mitwirkende:3];[Personen:17])
				CREATE SET:C116([Personen:17];"Personen")
				$anz:=Records in set:C195("Personen")
				  //DOCUMENT TO BLOB(html_quellordner+"Schau.html";$blobin)
				$process_in:=g_ReadFileIn (html_quellordner+"Schau.html")
				
				GET PICTURE FROM LIBRARY:C565("KeinBild";$bild)
				$pfad:=$SchaubildVollfolder+"Empty.jpg"
				WRITE PICTURE FILE:C680($pfad;$bild;".jpg")
				$pfad:=$Schaubildkleinfolder+"Empty.jpg"
				WRITE PICTURE FILE:C680($pfad;$bild;".jpg")
				
				For ($i;1;$anz)
					USE SET:C118("Personen")
					GOTO SELECTED RECORD:C245([Personen:17];$i)
					MESSAGE:C88("Schreibe Personen "+String:C10(Selected record number:C246([Personen:17]);"^^^^^^0")+" von "+String:C10(Records in selection:C76([Personen:17])))
					
					QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1)
					CREATE SET:C116([Mitwirkende:3];"m")
					INTERSECTION:C121("m";"Mitwirkende";"m")  // nur für Filme die auch auf DVD/BluRay da sind
					USE SET:C118("m")
					ORDER BY:C49([Mitwirkende:3];[Filme:1]Jahr:4;>)
					
					  // $Personenfolder
					webcurrentshowpfad:=""
					webcurrentshowpfad2:=""
					webcurrentshowpfad3:=""
					HTML_StartExport_ShowPict ([Personen:17]Bild:2;1;->webcurrentshowpfad;$SchaubildVollfolder;$Schaubildkleinfolder)
					HTML_StartExport_ShowPict ([Personen:17]Bild2:4;2;->webcurrentshowpfad2;$SchaubildVollfolder;$Schaubildkleinfolder)
					HTML_StartExport_ShowPict ([Personen:17]Bild3:10;3;->webcurrentshowpfad3;$SchaubildVollfolder;$Schaubildkleinfolder)
					
					PROCESS 4D TAGS:C816($process_in;$process_out)
					  // BLOB TO DOCUMENT($Personenfolder+String([Personen]PID)+".html";$blobout)
					$subpfad:=$Personenfolder+String:C10([Personen:17]PID:1\1000)
					If (Test path name:C476($subpfad)#Is a folder:K24:2)
						CREATE FOLDER:C475($subpfad)
					End if 
					$pfad:=$subpfad+Folder separator:K24:12+String:C10([Personen:17]PID:1)+".html"
					g_WriteFileOut ($pfad;$process_out)
					
					  // PICTURE TO BLOB($bild;$blobgif;".jpg")
					  // PICTURE TO BLOB($bild;$blobgif)
					NEXT RECORD:C51([Personen:17])
				End for 
				
				MESSAGE:C88("Schreibe Personenliste")
				
				$process_in:=g_ReadFileIn (html_quellordner+"Schauliste.html")
				  //DOCUMENT TO BLOB(html_quellordner+"Schauliste.html";$blobin)
				For ($i;0;26)  // alphabet + 0
					USE SET:C118("Personen")
					If ($i=0)
						QUERY SELECTION:C341([Personen:17];[Personen:17]Suchname:5<"A";*)
						QUERY SELECTION:C341([Personen:17];[Personen:17]Suchname:5>"ZZZZZ")
						$pfad:=$Personenlistefolder+"0.html"
					Else 
						QUERY SELECTION:C341([Personen:17];[Personen:17]Suchname:5=(Char:C90($i+64)+"@"))
						$pfad:=$Personenlistefolder+Char:C90($i+64)+".html"
					End if 
					ORDER BY:C49([Personen:17];[Personen:17]Suchname:5;>)
					PROCESS 4D TAGS:C816($process_in;$process_out)
					  //BLOB TO DOCUMENT($katfolder+$kat+".html";$blobout)
					g_WriteFileOut ($pfad;$process_out)
					
				End for 
			End if 
		End if 
		
	End if 
End if 

<>HTML_Process:=False:C215

If (<>errorNum#0)
	ALERT:C41("Fehler: "+String:C10(<>errorNum))
End if 
ON ERR CALL:C155("")


