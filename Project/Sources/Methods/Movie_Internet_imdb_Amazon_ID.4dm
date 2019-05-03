//%attributes = {}
  // zuerst imdb Nummer suchen

SET WINDOW TITLE:C213("Suche imdb bei Amazon")
$url:="http://www.amazon.com/exec/obidos/tg/stores/detail/-/dvd/"+[Filme:1]:13+"/glance"
  //C_BLOB($blob)
  //$blob:=HTTP_GetURL ($url)
$result:=""
$status:=HTTP Get:C1157($url;$result)
  //Tools_HTTP_Download ("text";->$result;$url)
If ($result#"")
	
	$newurl:=HTTP_Parse ($result;"amazon_GetImdb_link")
	$pos:=Position:C15("?";$newurl)
	[Filme:1]imdb:15:=Substring:C12($newurl;$pos+1)
End if 