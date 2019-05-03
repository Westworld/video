//%attributes = {}
If (Picture size:C356([Personen:17]Bild:2)=0)
	If ([Personen:17]IMDB:3#"")
		$url:="http://www.imdb.com/name/"+[Personen:17]IMDB:3+"/"
		C_PICTURE:C286($bild)
		C_TEXT:C284($result)
		$status:=HTTP Get:C1157($url;$result)
		If ($result#"")
			$bildurl:=HTTP_Parse ($result;"IMBd_SchauPict")
			If ($bildurl#"")
				$status:=HTTP Get:C1157($bildurl;$bild)
				If (Picture size:C356($bild)>0)
					[Personen:17]Bild:2:=$bild
					SAVE RECORD:C53([Personen:17])
				End if 
			End if 
		End if 
	End if 
End if 