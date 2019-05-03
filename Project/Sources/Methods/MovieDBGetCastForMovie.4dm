//%attributes = {}
  // Findet Crew for Movie
  // $1 = imdb
  // $2 = FID

If (True:C214)
	$imdb:=$1
	$fid:=$2
Else 
	$fid:=0
	$imdb:="tt0067756"
End if 

ALL RECORDS:C47([Parameter:5])
$lang:="de"
  //

If ($fid=0)
	QUERY:C277([Filme:1];[Filme:1]imdb:15=$imdb)
	ASSERT:C1129(Records in selection:C76([Filme:1])=1;"Fehler bei Film Identifizierung")
End if 

If ($imdb="tt@")
Else 
	$imdb:="tt"+$imdb
End if 

$url:="http://api.themoviedb.org/3/movie/"+$imdb+"/casts"
$url:=$url+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=de"

C_OBJECT:C1216($answer)
DELAY PROCESS:C323(Current process:C322;50)
$status:=HTTP Get:C1157($url;$answer)

If ($status#200)
	If ($status#404)
		ALERT:C41(String:C10($status)+" "+$result)
	End if 
End if 

If (OB Get:C1224($answer;"status_code";Is real:K8:4)=34)
	$url2:="http://api.themoviedb.org/3/movie/"+$1+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
	$result:=""
	DELAY PROCESS:C323(Current process:C322;50)
	$status:=HTTP Get:C1157($url2;$result)
	$movie:=JSON Parse:C1218($result)
	If ($status#200)
		ALERT:C41(String:C10($status)+" "+$result)
	End if 
	$id:=OB Get:C1224($movie;"imdb_id";Is text:K8:3)
	[Filme:1]imdb:15:=Substring:C12($id;3)
	[Filme:1]MovieDB:24:=OB Get:C1224($movie;"id";Is real:K8:4)
	
	If ([Filme:1]MovieDB:24#0)
		$url:="http://api.themoviedb.org/3/movie/"+String:C10([Filme:1]MovieDB:24)+"/casts"
		$url:=$url+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=de"
		C_OBJECT:C1216($answer)
		DELAY PROCESS:C323(Current process:C322;50)
		$status:=HTTP Get:C1157($url;$answer)
	End if 
End if 


ARRAY OBJECT:C1221($cast;0)
ARRAY OBJECT:C1221($crew;0)
OB GET ARRAY:C1229($answer;"cast";$cast)
OB GET ARRAY:C1229($answer;"crew";$crew)

C_OBJECT:C1216($crewfield)
OB SET:C1220($crewfield;"crew";$crewfield)
[Filme:1]Crew:36:=$crewfield
SAVE RECORD:C53([Filme:1])

$director:=0
For ($i;1;Size of array:C274($crew))
	$job:=OB Get:C1224($crew{$i};"job")
	If ($job="Director")
		$name:=OB Get:C1224($crew{$i};"name")
		$director:=OB Get:C1224($crew{$i};"id")
		$i:=Size of array:C274($crew)
	End if 
End for 

If (Size of array:C274($cast)>3)
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=$fid)
	START TRANSACTION:C239
	DELETE SELECTION:C66([Mitwirkende:3])
	
	If ($director#0)
		$pid:=MovieDBGetPersonDetails ($director;$name)
		If ($pid#0)
			CREATE RECORD:C68([Mitwirkende:3])
			[Mitwirkende:3]FID:1:=$fid
			[Mitwirkende:3]Kennung:3:="R"
			[Mitwirkende:3]PID:2:=$pid
			SAVE RECORD:C53([Mitwirkende:3])
		End if 
	End if 
	
	For ($i;1;Size of array:C274($cast))
		$name:=OB Get:C1224($cast{$i};"name")
		$id:=OB Get:C1224($cast{$i};"id")
		$pid:=MovieDBGetPersonDetails ($id;$name)
		If ($pid#0)
			CREATE RECORD:C68([Mitwirkende:3])
			[Mitwirkende:3]FID:1:=$fid
			[Mitwirkende:3]Kennung:3:="D"
			[Mitwirkende:3]PID:2:=$pid
			[Mitwirkende:3]Rolle:4:=OB Get:C1224($cast{$i};"character")
			SAVE RECORD:C53([Mitwirkende:3])
		End if 
		
	End for 
	
	VALIDATE TRANSACTION:C240
End if 

