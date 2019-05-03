//%attributes = {}
  // suche Bio für Schauspieler über IMDB

$imdb:=$1
$0:=""  // return Bio

  // http://www.imdb.com/name/nm0334689/bio?ref_=nm_ov_bio_sm
$url:="http://www.imdb.com/name/"+$imdb+"/bio?ref_=nm_ov_bio_sm"
$thetext:=""
$status:=HTTP Get:C1157($url;$thetext)
If (($status=200) & ($thetext#""))
	$0:=HTTP_Parse ($thetext;"IMDB_Person_Bio")
End if 