//%attributes = {}
  // sucht fehlende Bilder
QUERY BY FORMULA:C48([Filme:1];Picture size:C356([Filme:1]Bild:14)<100)

While (Not:C34(End selection:C36([Filme:1])))
	MESSAGE:C88([Filme:1]DtTitel:9)
	MovieDB_GetPoster ([Filme:1]imdb:15)
	DELAY PROCESS:C323(Current process:C322;120)
	NEXT RECORD:C51([Filme:1])
End while 

VALIDATE TRANSACTION:C240