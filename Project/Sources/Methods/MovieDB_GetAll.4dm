//%attributes = {}
  // holt alle Daten von MovieDB
READ ONLY:C145([Parameter:5])
ALL RECORDS:C47([Parameter:5])

$imagesource:="http://cf2.imgobject.com/t/p/original"

  //ALL RECORDS([Originaltitel])
QUERY:C277([Filme:1];[Filme:1]MovieDB:24=0;*)
QUERY:C277([Filme:1];[Filme:1]imdb:15#"")
ORDER BY:C49([Filme:1];[Filme:1]EnTitel:2;>)
While (Not:C34(End selection:C36([Filme:1])))
	MESSAGE:C88([Filme:1]EnTitel:2)
	If ([Filme:1]imdb:15#"???")
		  // tt0137523?api_key=&language=DE
		$id:=[Filme:1]imdb:15
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
			If ($imdbid#[Filme:1]imdb:15)
				
				[Filme:1]MovieDB:24:=OB Get:C1224($movie;"id")
				$collection:=""
				$collection:=OB Get:C1224($movie;"belongs_to_collection";Is text:K8:3)
				[Filme:1]MovieDB_Collection:25:=Num:C11($collection)
				$poster:=OB Get:C1224($movie;"poster_path")
				$fan:=OB Get:C1224($movie;"backdrop_path")
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
		End if 
		DELAY PROCESS:C323(Current process:C322;15)
	End if 
	NEXT RECORD:C51([Filme:1])
End while 

QUERY:C277([Filme:1];[Filme:1]MovieDB:24#0;*)
QUERY:C277([Filme:1];[Filme:1]EnTitel:2>"O")

ORDER BY:C49([Filme:1];[Filme:1]EnTitel:2;>)
While (Not:C34(End selection:C36([Filme:1])))
	MESSAGE:C88([Filme:1]EnTitel:2)
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
	DELAY PROCESS:C323(Current process:C322;15)
	NEXT RECORD:C51([Filme:1])
End while 




