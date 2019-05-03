//%attributes = {}
  // sucht für US titel deutsche ID

ALERT:C41("debug: nicht für v13 angepaßt, sollte nicht mehr benutzt werden")

SET WINDOW TITLE:C213("Suche ID bei OFDB")
If ([Filme:1]OFDb:16="")
	If ([Filme:1]EnTitel:2#"")
		$titel:=Replace string:C233(_O_Mac to ISO:C519([Filme:1]EnTitel:2);" ";"%20")
		$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=OTitel&SText="+$titel
		  // $err:=Tools_HTTP_Download ("Text";->$result;$url)
		$status:=HTTP Get:C1157($url;$result)
	Else 
		$titel:=Replace string:C233(_O_Mac to ISO:C519([Filme:1]DtTitel:9);" ";"%20")
		$url:="http://www.ofdb.de/view.php?page=suchergebnis&Kat=DTitel&SText="+$titel
		  //$err:=Tools_HTTP_Download ("Text";->$result;$url)
		$status:=HTTP Get:C1157($url;$result)
	End if 
	$gefunden:="http://www.ofdb.de/view.php?page=film&fid="
	ALERT:C41("nicht unterstützt, HTTP_LastURL Erkennung fehlt")
	Case of 
		: (HTTP_LastURL=($gefunden+"@"))  // Film gefunden"
			
			[Filme:1]OFDb:16:=Substring:C12(HTTP_LastURL;Length:C16($gefunden)+1)
			
		: (HTTP_LastURL="http://www.ofdb.de/view.php?page=suchergebnis&Kat=OTitel&SText=@")  // Filmliste
			
			  // Mehrere gefunden, Array erstellen
			
			Movie_Internet_OFDB_ID_sub (->[Filme:1]EnTitel:2;$result)
			
		: (HTTP_LastURL="http://www.ofdb.de/view.php?page=suchergebnis&Kat=DTitel&SText=@")  // Filmliste
			
			  // Mehrere gefunden, Array erstellen
			
			Movie_Internet_OFDB_ID_sub (->[Filme:1]DtTitel:9;$result)
			
		Else 
			ALERT:C41("Fehler bei Auswertung bei ofdb "+HTTP_LastURL)
	End case 
	
End if 