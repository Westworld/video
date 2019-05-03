//%attributes = {}
  // für alle (online) filme 

  // ordner für bilder anlegen

QUERY:C277([Filme:1];[Filme:1]MKV_Pfad:22#"")
ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)
While (Not:C34(End selection:C36([Filme:1])))
	MESSAGE:C88([Filme:1]DtTitel:9)
	
	nfo_writefilm 
	NEXT RECORD:C51([Filme:1])
End while 
