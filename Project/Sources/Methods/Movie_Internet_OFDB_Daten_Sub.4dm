//%attributes = {}
$url:="http://www.ofdb.de/view.php?page=film&fid="+vOFDb_ID
$result:=""
  // $err:=Tools_HTTP_Download ("Text";->$result;$url)
$status:=HTTP Get:C1157($url;$result)
  // $blob:=HTTP_GetURL ($url)
If ($result#"")
	
	$ID:=HTTP_Parse ($result;"OFDb_FindImdb")
	If (vOFDB_IMDB="")
		vOFDB_IMDB:=$id
	Else 
		If (vOFDB_IMDB#$id)
			ALERT:C41("Unterschiedliche IMDB ID's für "+vOFDB_DtTitel+"bisher="+vOFDB_IMDB+" bei ofdb = "+$id)
		End if 
	End if 
	
	If ((vOFDB_DtTitel="") | (vOFDB_OrigTItel=""))  // bei Ersterfassung Name neu übernehmen
		
		vOFDB_DtTitel:=HTML2Mac (HTTP_Parse ($result;"OFDb_titel"))
	End if 
	If (vOFDB_Erschienen="")
		vOFDB_Erschienen:=HTTP_Parse ($result;"OFDb_jahr")
	End if 
	If (vOFDB_Land="")
		vOFDB_Land:=HTML2Mac (HTTP_Parse ($result;"OFDb_land"))
	End if 
	
	If (vOFDB_Genre1="")
		_O_ARRAY STRING:C218(80;castlist;0)
		$schau:=HTTP_Parse ($result;"OFDB_Genre";->castlist)
		If (Size of array:C274(castlist)>0)
			vOFDB_Genre1:=HTML2Mac (castlist{1})
		End if 
		If (Size of array:C274(castlist)>1)
			vOFDB_Genre2:=HTML2Mac (castlist{2})
		End if 
	End if 
	
	If (vOFDB_Inhalt="")
		SET WINDOW TITLE:C213("Hole Beschreibung bei OFDB")
		$url:=HTTP_Parse ($result;"OFDB_Inhalt_ID")
		If ($url#"")
			If ($url#"http://www.ofdb.de/@")
				$url:="http://www.ofdb.de/"+$url
			End if 
			$result2:=""
			  //$err:=Tools_HTTP_Download ("Text";->$result2;$url)
			$status:=HTTP Get:C1157($url;$result2)
			  //$blob2:=HTTP_GetURL ($url)
			vOFDB_Inhalt:=HTML2Mac (HTTP_Parse ($result2;"OFDB_Inhalt"))
		End if 
	End if 
	
	If (Picture size:C356(OFDBKleinBild)=0)
		$url:=HTTP_Parse ($result;"OFDB_Bild")
		If (($url#"") & ($url#"@na.gif"))
			If ($url#"http://www.ofdb.de/@")
				$url:="http://www.ofdb.de/"+$url
			End if 
			  //$err:=Tools_HTTP_Download ("Picture";->OFDBKleinBild;$url)
			$status:=HTTP Get:C1157($url;OFDBKleinBild)
		End if 
	End if 
End if 

