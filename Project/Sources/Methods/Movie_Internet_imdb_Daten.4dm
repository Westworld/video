//%attributes = {}
  // $1 (optional) kann schon blob enthalten
  // Movie_Internet_imdb_Daten
C_TEXT:C284($1)

If ([Filme:1]imdb:15#"")
	Bildprozess:=New process:C317("Thread_Internet_imdb_Bilder";128000;"Bilder Download";Current process:C322;[Filme:1]FID:1;[Filme:1]imdb:15)
End if 

SET WINDOW TITLE:C213("Hole Seite bei imdb")

If (Count parameters:C259>0)
	$result:=$1
Else 
	  //imdb hauptseite abholen, dort direktor, schauspieler und laufzeit holen
	$result:=""
	$url:="http://german.imdb.com/title/tt"+[Filme:1]imdb:15+"/"
	$status:=HTTP Get:C1157($url;$result)
	  // $err:=Tools_HTTP_Download ("text";->$result;$url)
End if 

If ($result#"")
	
	SET WINDOW TITLE:C213("Hole Direktor bei imdb")
	  // nun direktor prüfen
	
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="R")
	If (Records in selection:C76([Mitwirkende:3])=0)
		$regie:=HTML2Mac (HTTP_Parse ($result;"IMBd_Directed"))
		If ($regie#"")
			CREATE RECORD:C68([Mitwirkende:3])
			[Mitwirkende:3]FID:1:=[Filme:1]FID:1
			[Mitwirkende:3]Kennung:3:="R"
			QUERY:C277([Personen:17];[Personen:17]Suchname:5=$regie)
			If (Records in selection:C76([Personen:17])=0)
				CreatePersonen ($regie)
			End if 
			[Mitwirkende:3]PID:2:=[Personen:17]PID:1
			SAVE RECORD:C53([Mitwirkende:3])
		End if 
	End if 
	
	SET WINDOW TITLE:C213("Hole Orig Titel bei imdb")
	[Filme:1]EnTitel:2:=HTML2Mac (HTTP_Parse ($result;"IMBd_OrigTitel"))
	
	If (([Filme:1]imdb:15#"") & ([Filme:1]:13=""))
		Amazonprozess:=New process:C317("Thread_Internet_imdb_Amazon";128000;"Amazon Suche";Current process:C322;[Filme:1]FID:1;[Filme:1]imdb:15;[Filme:1]EnTitel:2)
	End if 
	
	SET WINDOW TITLE:C213("Hole Laufzeit bei imdb")
	  // nun laufzeit prüfen
	
	If ([Filme:1]Länge:10=0)
		[Filme:1]Länge:10:=Abs:C99(Num:C11(HTTP_Parse ($result;"IMBd_Runtime")))
	End if 
	
	SET WINDOW TITLE:C213("Hole Deutschen Titel bei imdb")
	ARRAY TEXT:C222(product;0)
	$schau:=HTTP_Parse ($result;"IMDB_Alternativtitel";->product)
	If (Size of array:C274(product)#0)
		For ($i;1;Size of array:C274(product))
			$titel:=EntferneKlammerGruppe (product{$i};"<")
			product{$i}:=HTML2Mac ($titel)
		End for 
		$pos:=Find in array:C230(product;"@Germany@")
		If ($pos>0)
			$titel:=EntferneKlammerGruppe (product{$pos};"(")
			$titel:=EntferneKlammerGruppe ($titel;"[")
			$titel:=EntferneBlank ($Titel)
			If ($titel#[Filme:1]DtTitel:9)
				CONFIRM:C162("Neuer dt. Titel = "+$titel+" - bisher :"+[Filme:1]DtTitel:9;"Übernehmen";"Alten verwenden")
				If (OK=1)
					[Filme:1]DtTitel:9:=$titel
				End if 
			End if 
		End if 
	End if 
	If ([Filme:1]OFDb:16="")
		TheOFDB:=""
		vOFDB_OrigTItel:=""  // setzen, damit get process variable funktioniert
		
		vOFDB_DtTitel:=""
		vOFDB_Erschienen:=""
		vOFDB_Land:=""
		vOFDB_Genre1:=""
		vOFDB_Genre2:=""
		vOFDB_IMDB:=[Filme:1]imdb:15
		vOFDB_Inhalt:=[Filme:1]Inhalt:7
		vOFDB_KleinBild:=[Filme:1]Bild:14
		OFDBprozess:=New process:C317("Thread_Internet_IMDB_OFDB";256000;"OFDB Suche";Current process:C322;[Filme:1]FID:1;[Filme:1]EnTitel:2;[Filme:1]EnTitel:2;[Filme:1]imdb:15)
	End if 
	
	SET WINDOW TITLE:C213("Hole Logo bei imdb")
	If (Picture size:C356([Filme:1]Bild:14)=0)
		$url:=HTTP_Parse ($result;"IMBD_KleinBild")
		If ($url#"")
			  // $err:=Tools_HTTP_Download ("Picture";->[Originaltitel]Bild;$url)
			C_PICTURE:C286($pic)
			$status:=HTTP Get:C1157($url;$pic)
			[Filme:1]Bild:14:=$pic
		End if 
	End if 
	
	SET WINDOW TITLE:C213("Hole Schauspieler bei imdb")
	  // nun schauspieler prüfen
	
	If (True:C214)
		Movie_Imdb_HandleSchauspieler ($result)
		
	Else 
		_O_ARRAY STRING:C218(80;castlist;0)
		_O_ARRAY STRING:C218(80;castRolle;0)
		$schau:=HTTP_Parse ($result;"IMBD_Cast";->castlist;->castrolle)
		_O_ARRAY STRING:C218(80;castRolle;Size of array:C274(castlist))  // manchmal haben die letzten keine rollenangabe
		
		For ($i;1;Size of array:C274(castlist))
			$schau:=HTML2Mac (castlist{$i})
			If ($schau#"")
				QUERY:C277([Personen:17];[Personen:17]Suchname:5=$schau)
				If (Records in selection:C76([Personen:17])=0)
					CreatePersonen ($schau)
				End if 
				QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
				QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1)
				If (Records in selection:C76([Mitwirkende:3])=0)
					CREATE RECORD:C68([Mitwirkende:3])
					[Mitwirkende:3]FID:1:=[Filme:1]FID:1
					[Mitwirkende:3]Kennung:3:="D"
					[Mitwirkende:3]PID:2:=[Personen:17]PID:1
					[Mitwirkende:3]Rolle:4:=HTML2Mac (castRolle{$i})
					SAVE RECORD:C53([Mitwirkende:3])
				Else 
					If ([Mitwirkende:3]Kennung:3="R")
						[Mitwirkende:3]Kennung:3:="RD"
						[Mitwirkende:3]Rolle:4:=HTML2Mac (castRolle{$i})
						SAVE RECORD:C53([Mitwirkende:3])
					Else 
						If (([Mitwirkende:3]Rolle:4="") & (castRolle{$i}#""))
							[Mitwirkende:3]Rolle:4:=HTML2Mac (castRolle{$i})
							SAVE RECORD:C53([Mitwirkende:3])
						End if 
					End if 
				End if 
			End if 
		End for 
	End if 
End if 