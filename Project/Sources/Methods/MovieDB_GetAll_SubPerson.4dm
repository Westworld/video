//%attributes = {}
$id:=$1
$rolle:=$2
$kennung:=$3


ARRAY TEXT:C222($HeaderNames_at;1)
ARRAY TEXT:C222($HeaderValues_at;1)
$imagesource:="http://cf2.imgobject.com/t/p/original"
$result:=""


DELAY PROCESS:C323(Current process:C322;50)
$url:="http://api.themoviedb.org/3/person/"+String:C10($id)+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
$HeaderNames_at{1}:="Accept"
$HeaderValues_at{1}:="application/json"
$status:=HTTP Get:C1157($url;$result;$HeaderNames_at;$HeaderValues_at)
If ($status=200)
	$person:=JSON Parse:C1218($result)
	$imdbid:=""
	$imdbid:=OB Get:C1224($person;"imdb_id";Is text:K8:3)
	If ($imdbid#"")
		QUERY:C277([Personen:17];[Personen:17]IMDB:3=$imdbid)
	Else 
		QUERY:C277([Personen:17];[Personen:17]MovieDB:12=$id)
	End if 
	If (Records in selection:C76([Personen:17])=0)
		CREATE RECORD:C68([Personen:17])
		[Personen:17]IMDB:3:=$imdbid
		[Personen:17]Suchname:5:=OB Get:C1224($person;"name";Is text:K8:3)
		READ WRITE:C146([Parameter:5])
		ALL RECORDS:C47([Parameter:5])
		[Personen:17]PID:1:=[Parameter:5]PID:2
		[Parameter:5]PID:2:=[Parameter:5]PID:2+1
		SAVE RECORD:C53([Parameter:5])
		CREATE RECORD:C68([Mitwirkende:3])
		[Mitwirkende:3]FID:1:=[Filme:1]FID:1
		[Mitwirkende:3]PID:2:=[Personen:17]PID:1
		[Mitwirkende:3]Rolle:4:=$rolle
		[Mitwirkende:3]Kennung:3:=$kennung
		SAVE RECORD:C53([Mitwirkende:3])
	End if 
	[Personen:17]MovieDB:12:=Num:C11($id)
	$beschreibung:=OB Get:C1224($person;"biography";Is text:K8:3)
	If ([Personen:17]Kommentar:8="")
		[Personen:17]Kommentar:8:=$beschreibung
	End if 
	If ([Personen:17]Engl_Beschreibung:11="")
		[Personen:17]Engl_Beschreibung:11:=$beschreibung
	End if 
	$birthday:=OB Get:C1224($person;"birthday";Is date:K8:7)
	If (([Personen:17]Geboren:6="") & ($birthday#!00-00-00!))
		[Personen:17]Geboren:6:=String:C10($birthday)
	End if 
	$gestorben:=OB Get:C1224($person;"deathday";Is date:K8:7)
	If (([Personen:17]Todestag:13="") & ($gestorben#!00-00-00!))
		[Personen:17]Todestag:13:=String:C10($gestorben)
	End if 
	$herkunft:=OB Get:C1224($person;"place_of_birth";Is text:K8:3)
	If ([Personen:17]Herkunft:7="")
		[Personen:17]Herkunft:7:=$herkunft
	End if 
	$poster:=OB Get:C1224($person;"profile_path";Is text:K8:3)
	If ($poster#"")
		$url:=$imagesource+$poster
		CLEAR VARIABLE:C89($bild)
		C_PICTURE:C286($bild)
		$status:=HTTP Get:C1157($url;$bild)
		If (Picture size:C356($bild)>Picture size:C356([Personen:17]Bild:2))
			[Personen:17]Bild:2:=$bild
		End if 
	End if 
	SAVE RECORD:C53([Personen:17])
	
	
End if   // status 200 für person get