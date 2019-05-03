//%attributes = {}
  // findet Person nach MovieDB ID
  // $1 = MovieDB ID
  // $2 = Personen entity
  // $0 = Person

C_LONGINT:C283($1)
C_OBJECT:C1216($2;$0;$personcol)

$movieDBId:=$1
$person:=$2
$0:=Null:C1517

$imagesource:="http://cf2.imgobject.com/t/p/original"
ASSERT:C1129($movieDBId#0;"MovieDBId darf nicht null sein")

If ($person=Null:C1517)
	$personcol:=ds:C1482.Personen.query("MovieDB=:1";$movieDBId)
	If ($personcol.length=0)
		  // $person:=ds.Personen.new()  // erst später nach IMDB Prüfung
	Else 
		ASSERT:C1129($personcol.length=1;"Darf nicht mehr als 1 Person gefunden werden")
		$person:=$personcol.first()
	End if 
End if 




$url:="http://api.themoviedb.org/3/person/"+String:C10($movieDBId)+"?api_key="+ds:C1482.Parameter.all()[0].API_MovieDB+"&language=DE"

C_OBJECT:C1216($personcloud)
$status:=HTTP Get:C1157($url;$personcloud)  //;$HeaderNames_at;$HeaderValues_at)
If ($status=200)
	C_TEXT:C284($imdbid)
	$imdbid:=String:C10($personcloud.imdb_id)
	If (String:C10($person.IMDB)=$imdbid)
		  // perfect
	Else 
		If ($person=Null:C1517)
			$person:=ds:C1482.Personen.new()
			$person.PID:=Para_IncreaseNumber ("PID")
			$person.IMDB:=$imdbid
		Else 
			If ($person.IMDB="")
				$person.IMDB:=$imdbid
			Else 
				ASSERT:C1129((String:C10($person.IMDB)=$imdbid);"Den Schauspieler gibt es, aber IMDB stimmt nicht überein?")
				If (False:C215)
					$person.IMDB:=$imdbid
				End if 
			End if 
		End if 
	End if 
	$person.MovieDB:=$movieDBId
	
	For each ($element;$personcloud)
		If ($personcloud[$element]#Null:C1517)
			Case of 
				: ($element="name")
					$person.Suchname:=$personcloud[$element]
				: ($element="biography")
					If (Length:C16($person.Kommentar)<Length:C16($personcloud.biography))
						$person.Kommentar:=$personcloud[$element]
					End if 
				: ($element="birthday")
					$person.Geboren:=$personcloud[$element]
				: ($element="deathday")
					$person.Todestag:=$personcloud[$element]
				: ($element="place_of_birth")
					$person.Herkunft:=$personcloud[$element]
					
				: ($element="profile_path")
					$poster:=$personcloud.profile_path
					If (($poster#"") & (Picture size:C356($person.Bild)<10000))
						$url:=$imagesource+$poster
						C_PICTURE:C286($bild)
						$status:=HTTP Get:C1157($url;$bild)
						$person.Bild:=$bild
					End if 
					
			End case 
		End if 
	End for each 
	
	
	If (Length:C16($person.Kommentar)<20)
		$bio:=Movie_Internet_imdb_SchauBio ($person.IMDB)
		$bio:=EntferneAHref ($bio)
		$bio:=EntferneBlank ($bio)
		If (Length:C16($bio)>20)
			$person.Kommentar:=$bio
		End if 
	End if 
	
	C_OBJECT:C1216($savestatus)
	$savestatus:=$person.save(True:C214)
	If (Not:C34(Bool:C1537($savestatus.success)))
		ALERT:C41(JSON Stringify:C1217($savestatus))
		TRACE:C157
	End if 
	
	$0:=$person
	
End if 


