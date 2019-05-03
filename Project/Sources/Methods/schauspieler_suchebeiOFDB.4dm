//%attributes = {}
  // suche für aktuellen Personen Informationen bei OFDB anhand IMDB
  // wenn gefunden, dann bei Personen abspeichern

SET WINDOW TITLE:C213("Suche "+[Personen:17]Suchname:5)

If ([Personen:17]IMDB:3#"")
	$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=IMDb&SText="+[Personen:17]IMDB:3
	$result:=""
	C_BLOB:C604($helpblob)
	  // $err:=Tools_HTTP_Download ("Text";->$result;$url)
	$status:=HTTP Get:C1157($url;$helpblob)
	$result:=Convert to text:C1012($helpblob;"UTF-8")
	If ($result="")
		$result:=Tools_UTF8To16 ($helpblob)
	End if 
	  //$result:=Convert to text($helpblob;"UTF-8")
	  //If ($result="")
	  //$result:=Convert to text($helpblob;"ISO-8859-1")
	  //End if 
	If (False:C215)
		BLOB TO DOCUMENT:C526("E:\\blob.txt";$helpblob)
	End if 
	
	If ($result#"")
		$schau:=HTTP_Parse ($result;"OFDB_Person_list")
		If ($schau#"")
			$pos:=Position:C15(Char:C90(34);$schau)
			If ($pos>0)
				[Personen:17]OFDB:9:=Substring:C12($schau;1;$pos-1)
				$pos:=Position:C15("\">";$schau)
				If ($pos>0)
					$schau:=Substring:C12($schau;$pos+1)
					$pos:=Position:C15("(";$schau)
					If ($pos>0)
						$schau:=Substring:C12($schau;$pos+1)
						$pos:=Position:C15(")";$schau)
						If ($pos>0)
							$schau:=Substring:C12($schau;1;$pos-1)
							[Personen:17]Geboren:6:=$schau
						End if 
					End if 
				End if 
			End if 
		End if 
		
		If ([Personen:17]OFDB:9#"")
			  //"view.php?page=person&id=1167"
			$url:="http://www.ofdb.de/view.php?page=person&id="+[Personen:17]OFDB:9
			$result:=""
			C_BLOB:C604($myblob)
			  // $err:=Tools_HTTP_Download ("blob";->$myblob;$url)
			$status:=HTTP Get:C1157($url;$myblob)
			If (False:C215)
				BLOB TO DOCUMENT:C526("E:\\blob.txt";$myblob)
			End if 
			$result:=Convert to text:C1012($myblob;"UTF-8")
			If ($result="")
				$result:=Tools_UTF8To16 ($myBlob)
			End if 
			[Personen:17]Herkunft:7:=HTTP_Parse ($result;"OFDB_Person_Ort")
			$bildurl:=HTTP_Parse ($result;"OFDB_Person_Bild2")
			C_PICTURE:C286($bild)
			If ($bildurl#"")
				$bildurl:="http://www.ofdb.de/images/"+$bildurl
				  // $err:=Tools_HTTP_Download ("Picture";->$bild;$bildurl)
				$status:=HTTP Get:C1157($bildurl;$bild)
			End if 
			If (Picture size:C356($bild)>0)
				[Personen:17]Bild2:4:=$bild
			End if 
			
			  // gibt es irgenwo weitere Infos?
			  // OFDB_WeitereInfos
			ARRAY TEXT:C222($weitereurl;0)
			$url:=HTTP_Parse ($result;"OFDB_WeitereInfos";->$weitereurl)
			  // $url:="http://www.film-zeit.de/Person/11564/Charles-Chaplin/Biographie/"
			$pos:=Find in array:C230($weitereurl;"@www.film-zeit.de@")
			If ($pos>0)
				$url:=$weitereurl{$pos}
				$result:=""
				  // $err:=Tools_HTTP_Download ("text";->$result;$url)  // ist ISO-8859-1
				$status:=HTTP Get:C1157($url;$result)
				If (False:C215)
					SET TEXT TO PASTEBOARD:C523($result)
				End if 
				
				$bildurl:=HTTP_Parse ($result;"Filmzeit_Bild")
				$bildurl:=Replace string:C233($bildurl;"&amp;";"&")
				C_PICTURE:C286($bild)
				If ($bildurl#"")
					  // http://www.film-zeit.de/xinclude/images.inc.php?size=detailBig&picpath=bilder_cnt/person/CHARLES-CHAPLIN-11564.jpeg
					$bildurl:="http://www.film-zeit.de/"+$bildurl
					  //$err:=Tools_HTTP_Download ("Picture";->$bild;$bildurl)
					$status:=HTTP Get:C1157($bildurl;$bild)
				End if 
				If (Picture size:C356($bild)>0)
					[Personen:17]Bild3:10:=$bild
				End if 
				
				$biotext:=HTTP_Parse ($result;"Filmzeit_Biographie")
				If ($biotext#"")
					$result:=web_removehtmltags ($biotext)
					
					[Personen:17]Kommentar:8:=$result
				End if 
			Else   // else if film-zeit
				$pos:=Find in array:C230($weitereurl;"@.movie-fan.@")
				If ($pos>0)
					$url:=$weitereurl{$pos}
					$result:=""
					  // $err:=Tools_HTTP_Download ("text";->$result;$url)  // ist utf-
					$status:=HTTP Get:C1157($url;$result)
					If (False:C215)
						SET TEXT TO PASTEBOARD:C523($result)
					End if 
					If ($result#"")
						$biotext:=HTTP_Parse ($result;"moviefan_Bio")
						[Personen:17]Kommentar:8:=web_removehtmltags ($biotext)
						
					End if 
				Else   // movie-fan
					$pos:=Find in array:C230($weitereurl;"@.wikipedia.@")
					If ($pos>0)
						$url:=$weitereurl{$pos}
						$result:=""
						  // $err:=Tools_HTTP_Download ("text";->$result;$url)  // ist utf-
						$status:=HTTP Get:C1157($url;$result)
						If (False:C215)
							SET TEXT TO PASTEBOARD:C523($result)
						End if 
						If ($result#"")
							$biotext:=HTTP_Parse ($result;"wikipedia_Bio")
							[Personen:17]Kommentar:8:=web_removehtmltags ($biotext)
							
						End if 
					End if   // test if url in array if wikpedia
				End if   // test if url in array if film-zeit
				
			End if   // ofdb
			
		End if   // if imdb
	End if 
End if 