//%attributes = {}
  // $1 = imdb ID

$id:=$1
ALL RECORDS:C47([Parameter:5])
$imagesource:="http://cf2.imgobject.com/t/p/original"



If ($id#"tt@")
	$id:="tt"+$id
End if 
$url:="http://api.themoviedb.org/3/movie/"+$id+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
$result:=""
ARRAY TEXT:C222($HeaderNames_at;1)
ARRAY TEXT:C222($HeaderValues_at;1)
$HeaderNames_at{1}:="Accept"
$HeaderValues_at{1}:="application/json"
$status:=HTTP Get:C1157($url;$result;$HeaderNames_at;$HeaderValues_at)
If ($status#200)
	If ($status#404)
		ALERT:C41(String:C10($status)+" "+$result)
	End if 
Else 
	$movie:=JSON Parse:C1218($result)
	$imdbid:=""
	$imdbid:=OB Get:C1224($movie;"imdb_id";Is text:K8:3)
	If ($imdbid="tt@")
		$imdbid:=Substring:C12($imdbid;3)
	End if 
	ASSERT:C1129($imdbid=[Filme:1]imdb:15;"imdb ungleich")
	[Filme:1]MovieDB:24:=OB Get:C1224($movie;"id")
	C_TEXT:C284($collection)
	$collection:=OB Get:C1224($movie;"belongs_to_collection";Is text:K8:3)
	[Filme:1]MovieDB_Collection:25:=Num:C11($collection)
	$poster:=OB Get:C1224($movie;"poster_path";Is text:K8:3)
	$fan:=OB Get:C1224($movie;"backdrop_path";Is text:K8:3)
	$url:=$imagesource+$poster
	CLEAR VARIABLE:C89($bild)
	C_PICTURE:C286($bild)
	If ($poster#"")
		$status:=HTTP Get:C1157($url;$bild)
		If (Picture size:C356($bild)>Picture size:C356([Filme:1]Bild:14))
			[Filme:1]Bild:14:=$bild
		End if 
	End if 
	CLEAR VARIABLE:C89($bild)
	If (($fan#"") & (Picture size:C356([Filme:1]Fanart:26)<100))
		$url:=$imagesource+$fan
		$status:=HTTP Get:C1157($url;$bild)
		If (Picture size:C356($bild)>Picture size:C356([Filme:1]Fanart:26))
			[Filme:1]Fanart:26:=$bild
		End if 
	End if 
	
	SAVE RECORD:C53([Filme:1])
	
End if 