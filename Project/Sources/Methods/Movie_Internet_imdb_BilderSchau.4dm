//%attributes = {}
  // holt für alle Filme fehlende Schauspieler ID's
  // und US Beschreibung
  // einmaliger Aufruf, nicht benutzt

ALL RECORDS:C47([Filme:1])
ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)
While (Not:C34(End selection:C36([Filme:1])))
	MESSAGE:C88([Filme:1]DtTitel:9)
	
	$result:=""
	$url:="http://german.imdb.com/title/tt"+[Filme:1]imdb:15+"/"
	$status:=HTTP Get:C1157($url;$result)
	
	If ($result#"")
		  //If ([Originaltitel]Engl_Beschreibung="")
		  //[Originaltitel]Engl_Beschreibung:=HTML2Mac (HTTP_Parse ($result;"IMBd_EnglBesch"))
		  //SAVE RECORD([Originaltitel])
		  //End if 
		
		Movie_Imdb_HandleSchauspieler ($result)
		
	End if 
	NEXT RECORD:C51([Filme:1])
End while 