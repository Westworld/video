//%attributes = {}
  // holt Film von MovieDB
READ ONLY:C145([Parameter:5])
ALL RECORDS:C47([Parameter:5])

$imagesource:="http://cf2.imgobject.com/t/p/original"

If (Count parameters:C259>0)
	$id:=$1
Else 
	$id:="207703"
End if 

  // tt0137523?api_key=&language=DE
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
	
	If (OB Get:C1224($movie;"status_code";Is real:K8:4)=34)
		  // movie not found?
		$url:="http://api.themoviedb.org/3/movie/"+$1+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
		$status:=HTTP Get:C1157($url;$result;$HeaderNames_at;$HeaderValues_at)
		$movie:=JSON Parse:C1218($result)
		If ($status#200)
			ALERT:C41(String:C10($status)+" "+$result)
		End if 
		$id:=OB Get:C1224($movie;"imdb_id";Is text:K8:3)
		$id:=Substring:C12($id;3)
	End if 
	
	
	[Filme:1]imdb:15:=$id
	[Filme:1]MovieDB:24:=OB Get:C1224($movie;"id")
	If ([Filme:1]DtTitel:9="")
		[Filme:1]DtTitel:9:=OB Get:C1224($movie;"title";Is text:K8:3)
	End if 
	If ([Filme:1]EnTitel:2="")
		[Filme:1]EnTitel:2:=OB Get:C1224($movie;"original_title";Is text:K8:3)
	End if 
	If ([Filme:1]Land:3="")
		ARRAY OBJECT:C1221($myobjectarr;0)
		OB GET ARRAY:C1229($movie;"production_countries";$myobjectarr)
		If (Size of array:C274($myobjectarr)#0)
			[Filme:1]Land:3:=OB Get:C1224($myobjectarr{1};"name";Is text:K8:3)
		End if 
	End if 
	If (([Filme:1]Länge:10=0) & ([Filme:1]Länge:10>5000))
		[Filme:1]Länge:10:=OB Get:C1224($movie;"runtime";Is longint:K8:6)
	End if 
	If ([Filme:1]Inhalt:7="")
		[Filme:1]Inhalt:7:=OB Get:C1224($movie;"overview";Is text:K8:3)
	End if 
	  // genre
	If (([Filme:1]Genre1:5="") & ([Filme:1]Genre2:6=""))
		ARRAY OBJECT:C1221($myobjectarr;0)
		OB GET ARRAY:C1229($movie;"genres";$myobjectarr)
		If (Size of array:C274($myobjectarr)>0)
			[Filme:1]Genre1:5:=OB Get:C1224($myobjectarr{1};"name";Is text:K8:3)
		End if 
		If (Size of array:C274($myobjectarr)>1)
			[Filme:1]Genre2:6:=OB Get:C1224($myobjectarr{2};"name";Is text:K8:3)
		End if 
	End if 
	
	$collection:=""
	$collection:=OB Get:C1224($movie;"belongs_to_collection";Is text:K8:3)
	[Filme:1]MovieDB_Collection:25:=Num:C11($collection)
	$poster:=OB Get:C1224($movie;"poster_path")
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
	If ($fan#"")
		$url:=$imagesource+$fan
		$status:=HTTP Get:C1157($url;$bild)
		If (Picture size:C356($bild)>Picture size:C356([Filme:1]Fanart:26))
			[Filme:1]Fanart:26:=$bild
		End if 
	End if 
	SAVE RECORD:C53([Filme:1])
End if 



$url:="http://api.themoviedb.org/3/movie/"+String:C10([Filme:1]MovieDB:24)+"/casts?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
$result:=""
ARRAY TEXT:C222($HeaderNames_at;1)
ARRAY TEXT:C222($HeaderValues_at;1)
$HeaderNames_at{1}:="Accept"
$HeaderValues_at{1}:="application/json"
$status:=HTTP Get:C1157($url;$result;$HeaderNames_at;$HeaderValues_at)
If ($status=200)
	  //TEXT TO DOCUMENT("json_error";$result)
	$movie:=JSON Parse:C1218($result)
	$object:=OB Get:C1224($movie;"cast";39)
	
	For ($i;1;Size of array:C274($object))
		$id:=OB Get:C1224($object{$i};"id")
		QUERY:C277([Personen:17];[Personen:17]MovieDB:12=$id)
		If (Records in selection:C76([Personen:17])=0)
			$rolle:=OB Get:C1224($object{$i};"character";Is text:K8:3)
			MovieDB_GetAll_SubPerson ($id;$rolle;"")
		End if   // person noch nicht gefunden, also noch nicht eingetragen
		
		
		  // TODO, muss hier nicht eingetragen werden wenn es die Person schon gab, welche Rolle sie hat?
	End for 
	
	CLEAR VARIABLE:C89($object)
	  //$object:=OB Get($movie;"crew";39)
	ARRAY OBJECT:C1221($object;0)
	OB GET ARRAY:C1229($movie;"crew";$object)
	
	For ($i;1;Size of array:C274($object))
		$job:=OB Get:C1224($object{$i};"job")
		If ($job="Director")
			
			$id:=OB Get:C1224($object{$i};"id")
			QUERY:C277([Personen:17];[Personen:17]MovieDB:12=$id)
			If (Records in selection:C76([Personen:17])=0)
				$rolle:=OB Get:C1224($object{$i};"character";Is text:K8:3)
				MovieDB_GetAll_SubPerson ($id;$rolle;"R")
			End if   // person noch nicht gefunden, also noch nicht eingetragen
		End if 
	End for 
	
End if 




