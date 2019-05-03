//%attributes = {}
$0:=0

  // browser already displays correct page, now fetch the data

  //mybrowser:=0
  //GET PROCESS VARIABLE(<>browserWindow;mybrowser;mybrowser)

$pagecontent:=<>pageContent

  // IMDB only to retrieve via direct search
$ID:=HTTP_Parse ($pagecontent;"OFDb_FindImdb")
If ([Filme:1]imdb:15="")
	[Filme:1]imdb:15:=$id
End if 

  // [Originaltitel]Dt Titel:=HTML2Mac (HTTP_Parse ($blob;"OFDb_Titel_Browser"))
[Filme:1]DtTitel:9:=(HTTP_Parse ($pagecontent;"OFDb_Titel_Browser"))
$titel:=(HTTP_Parse ($pagecontent;"OFDb_OTitel_Browser"))
If ($titel#"")
	[Filme:1]EnTitel:2:=$titel
End if 

[Filme:1]Jahr:4:=HTTP_Parse ($pagecontent;"OFDb_jahr_Browser")
  // [Originaltitel]Land:=HTML2Mac (HTTP_Parse ($blob;"OFDb_land_Browser"))
[Filme:1]Land:3:=(HTTP_Parse ($pagecontent;"OFDb_land_Browser"))

_O_ARRAY STRING:C218(80;castlist;0)
$schau:=HTTP_Parse ($pagecontent;"OFDB_Genre_Browser";->castlist)
If (Size of array:C274(castlist)>0)
	  // [Originaltitel]Genre 1:=castlist{1}
	[Filme:1]Genre1:5:=(castlist{1})
End if 
If (Size of array:C274(castlist)>1)
	[Filme:1]Genre2:6:=(castlist{2})
	  // [Originaltitel]Genre 2:=castlist{2}
	
End if 

<>pageContentURL:=""
If ([Filme:1]Inhalt:7="")
	$url:=HTTP_Parse ($pagecontent;"OFDB_Inhalt_ID")
	If ($url#"")
		$url:=Replace string:C233($url;"&amp;";"&")
		If ($url#"http://www.ofdb.de/@")
			$url:="http://www.ofdb.de/"+$url
		End if 
		$result2:=""
		<>pageContentURL:=$url
		  // $err:=Tools_HTTP_Download ("Text";->$result2;$url)
		  // [Originaltitel]Inhalt:=HTML2Mac (HTTP_Parse ($result2;"OFDB_Inhalt"))
	End if 
End if 

If (Picture size:C356([Filme:1]Bild:14)=0)
	$url:=HTTP_Parse ($pagecontent;"OFDB_Bild")
	If (($url#"") & ($url#"@na.gif"))
		If ($url#"http://@")
			$url:="http://www.ofdb.de/"+$url
		End if 
		  // [Originaltitel]Bild:=HTTP_Get_Picture ($url)
		
		  //$result:=Tools_HTTP_Download ("Picture";->[Originaltitel]Bild;$url)
		C_PICTURE:C286($pic)
		$status:=HTTP Get:C1157($url;$pic)
		[Filme:1]Bild:14:=$pic
	End if 
End if 

