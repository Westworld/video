  // holt Infos über Schauspieler

If ([Personen:17]IMDB:3#"")
	<>Job:="Load IMDB Person"
	$url:="http://www.imdb.de/name/"+[Personen:17]IMDB:3+"/"
Else 
	If (Person_DoAutoLoad)
		<>Job:="AutoFind IMDB Person"
	Else 
		<>Job:="Find IMDB Person"
	End if 
	$titel:=Tools_URL_Encoder ([Personen:17]Suchname:5;"UTF-8")
	$url:="http://www.imdb.de/find?s=nm&q="+$titel  //jean+reno
	
End if 

<>JobUrl:=$url
<>Main:=Current process:C322
Browser_LaunchWindow 
POST OUTSIDE CALL:C329(<>browserWindow)