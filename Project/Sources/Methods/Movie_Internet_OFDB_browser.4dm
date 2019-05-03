//%attributes = {}
  // sucht für US titel deutsche ID

SET WINDOW TITLE:C213("Suche ID bei OFDB")
If ([Filme:1]OFDb:16="")
	If ([Filme:1]EnTitel:2#"")
		$titel:=Tools_URL_Encoder ([Filme:1]EnTitel:2;"UTF-8")
		$titel:=Replace string:C233($titel;"%20";" ")
		$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=OTitel&SText="+$titel
	Else 
		$titel:=Tools_URL_Encoder ([Filme:1]DtTitel:9;"UTF-8")
		$titel:=Replace string:C233($titel;"%20";" ")
		$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=DTitel&SText="+$titel
	End if 
	<>Job:="Find Movie"
	<>JobUrl:=$url
	<>Main:=Current process:C322
	Browser_LaunchWindow 
	POST OUTSIDE CALL:C329(<>browserWindow)
Else 
	$url:="http://www.ofdb.de/view.php?page=film&fid="+[Filme:1]OFDb:16
	<>Job:="Load OFDB Movie"
	<>JobUrl:=$url
	<>Main:=Current process:C322
	Browser_LaunchWindow 
	POST OUTSIDE CALL:C329(<>browserWindow)
End if 