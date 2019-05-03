//%attributes = {}
  // findet Person nach MovieDB ID
  // $1 = MovieDB ID
  //$0 = PID

$movieDBId:=$1
$name:=$2
$0:=0
$P:=Progress New   // Neuen Balken erstellen

$imagesource:="http://cf2.imgobject.com/t/p/original"

ASSERT:C1129($movieDBId#0;"MovieDBId darf nicht null sein")

QUERY:C277([Personen:17];[Personen:17]MovieDB:12=$movieDBId)
If (Records in selection:C76([Personen:17])>0)
	ASSERT:C1129(Records in selection:C76([Personen:17])=1;"Darf nicht mehr als 1 Person gefunden werden")
	$0:=[Personen:17]PID:1
Else 
	Progress SET TITLE ($P;"Hole von MovieDB";-1;$name+" für "+[Filme:1]DtTitel:9;True:C214)
	  //Progress SET PROGRESS ($P;-1;"Hole von MovieDB "+$name+" für "+[Originaltitel]DtTitel)
	ALL RECORDS:C47([Parameter:5])
	$url:="http://api.themoviedb.org/3/person/"+String:C10($movieDBId)+"?api_key="+[Parameter:5]API_MovieDB:8+"&language=DE"
	  //$HeaderNames_at{1}:="Accept"
	  //$HeaderValues_at{1}:="application/json"
	C_OBJECT:C1216($person)
	DELAY PROCESS:C323(Current process:C322;50)
	$status:=HTTP Get:C1157($url;$person)  //;$HeaderNames_at;$HeaderValues_at)
	If ($status=200)
		C_TEXT:C284($imdbid)
		$imdbid:=OB Get:C1224($person;"imdb_id";Is text:K8:3)
		If ($imdbid#"")
			QUERY:C277([Personen:17];[Personen:17]IMDB:3=$imdbid)
		Else 
			  // nichts gibt es nicht
		End if 
		
		ASSERT:C1129(Records in selection:C76([Personen:17])<=1);"Anzahl Personen darf nicht > 1 sein!")
		
		If (Records in selection:C76([Personen:17])=0)
			CREATE RECORD:C68([Personen:17])
			READ WRITE:C146([Parameter:5])
			ALL RECORDS:C47([Parameter:5])
			[Personen:17]PID:1:=[Parameter:5]PID:2
			[Parameter:5]PID:2:=[Parameter:5]PID:2+1
			SAVE RECORD:C53([Parameter:5])
		End if 
		[Personen:17]MovieDB:12:=$movieDBId
		[Personen:17]IMDB:3:=OB Get:C1224($person;"imdb_id";Is text:K8:3)
		[Personen:17]Suchname:5:=OB Get:C1224($person;"name";Is text:K8:3)
		If ([Personen:17]Kommentar:8#"")
			[Personen:17]Kommentar:8:=OB Get:C1224($person;"biography";Is text:K8:3)
		End if 
		[Personen:17]Geboren:6:=OB Get:C1224($person;"birthday";Is text:K8:3)
		[Personen:17]Todestag:13:=OB Get:C1224($person;"deathday";Is text:K8:3)
		[Personen:17]Herkunft:7:=OB Get:C1224($person;"place_of_birth";Is text:K8:3)
		$poster:=OB Get:C1224($person;"profile_path";Is text:K8:3)
		If (($poster#"") & (Picture size:C356([Personen:17]Bild:2)<1000))
			$url:=$imagesource+$poster
			CLEAR VARIABLE:C89($bild)
			C_PICTURE:C286($bild)
			$status:=HTTP Get:C1157($url;$bild)
			[Personen:17]Bild:2:=$bild
		End if 
		
		$0:=[Personen:17]PID:1
		SAVE RECORD:C53([Personen:17])
		
		
	End if 
	
End if 

Progress QUIT ($P)
