//%attributes = {}
  // holt Informationen für schauspieler
  // bei denen Geburtstag/Ort fehlt
  // bei imdb

QUERY:C277([Personen:17];[Personen:17]IMDB:3#"";*)
QUERY:C277([Personen:17]; & [Personen:17]Geboren:6="";*)
QUERY:C277([Personen:17]; & [Personen:17]Kommentar:8#" ")

ORDER BY:C49([Personen:17];[Personen:17]Suchname:5;>)
While (Not:C34(End selection:C36([Personen:17])))
	MESSAGE:C88([Personen:17]Suchname:5)
	$url:="http://www.imdb.com/name/"+[Personen:17]IMDB:3+"/bio"
	$result:=""
	$status:=HTTP Get:C1157($url;$result)
	If ($result#"")
		
		If (False:C215)
			SET TEXT TO PASTEBOARD:C523($result)
		End if 
		
		If ([Personen:17]Geboren:6="")
			$birth:=HTTP_Parse ($result;"IMBD_Birth")
			If ($birth#"")
				[Personen:17]Geboren:6:=$birth
			End if 
		End if 
		If ([Personen:17]Herkunft:7="")
			$birth:=HTTP_Parse ($result;"IMBD_Birthplace")
			If ($birth#"")
				[Personen:17]Herkunft:7:=HTML2Mac ($birth)
			End if 
		End if 
		
		If ([Personen:17]Kommentar:8="")
			$bio:=HTTP_Parse ($result;"IMBD_MiniBio")
			If ($bio#"")
				$bio:=EntferneAHref ($bio)
				[Personen:17]Kommentar:8:=HTML2Mac ($bio)
			End if 
		End if 
		
		If (Picture size:C356([Personen:17]Bild:2)<100)
			$url:=HTTP_Parse ($result;"IMBD_headshot")
			If ($url#"")
				C_PICTURE:C286($bild;$bildleer)
				$bild:=$bildleer
				$status:=HTTP Get:C1157($url;$bild)
				If (Picture size:C356($bild)>0)
					[Personen:17]Bild:2:=$bild
				End if 
			End if 
		End if 
		
		If ([Personen:17]Kommentar:8="")
			[Personen:17]Kommentar:8:=" "
		End if 
		
		SAVE RECORD:C53([Personen:17])
		
	End if 
	
	NEXT RECORD:C51([Personen:17])
End while 