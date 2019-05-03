If (Form event:C388=On Clicked:K2:4)
	If (Right click:C712)
		$popup:=Pop up menu:C542("Poster laden;Alles laden;Alles überschreiben;Bilder holen;Cast update;-;Weitere Daten")
		Case of 
			: ($popup=1)
				If (Form:C1466.Movie.imdb="")
					ALERT:C41("IMDB fehlt")
				Else 
					QUERY:C277([Filme:1];[Filme:1]FID:1=Form:C1466.Movie.FID)
					MovieDB_GetPoster (Form:C1466.Movie.imdb)
					Form:C1466.Movie.reload()
				End if 
			: ($popup=2)  // alles laden
				If (Form:C1466.Movie.imdb="")
					ALERT:C41("IMDB fehlt")
				Else 
					QUERY:C277([Filme:1];[Filme:1]FID:1=Form:C1466.Movie.FID)
					MovieDB_GetMovie (Form:C1466.Movie.imdb)
					Form:C1466.Movie.reload()
				End if 
				
			: ($popup=3)  // alles laden
				If (Form:C1466.Movie.imdb="")
					ALERT:C41("IMDB fehlt")
				Else 
					  // alle alten daten löschen außer IMDB, auch genre, bild, actor, etc
					
					QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1)
					DELETE SELECTION:C66([Mitwirkende:3])
					QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
					DELETE SELECTION:C66([Bilder:8])
					$imdb:=[Filme:1]imdb:15
					$kodi:=[Filme:1]Kodi_ID:31
					$oldfid:=[Filme:1]FID:1
					DELETE RECORD:C58([Filme:1])
					CREATE RECORD:C68([Filme:1])
					[Filme:1]FID:1:=$oldfid
					[Filme:1]imdb:15:=$imdb
					[Filme:1]Kodi_ID:31:=$kodi
					MovieDB_GetMovie ([Filme:1]imdb:15)
					Form:C1466.Movie:=ds:C1482.Filme.query("FID=:1";$oldfid)
				End if 
				
			: ($popup=7)
				  //query([Bilder];[Bilder]FID=[Originaltitel]FID)
				FORM GOTO PAGE:C247(2)
				
			: ($popup=4)
				If (Form:C1466.Movie.imdb="")
					ALERT:C41("IMDB fehlt")
				Else 
					Movie_Internet_imdb_Bilder (Form:C1466.Movie.FID;Form:C1466.Movie.imdb)
					QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
				End if 
				
			: ($popup=5)
				If (Form:C1466.Movie.imdb="")
					ALERT:C41("IMDB fehlt")
				Else 
					QUERY:C277([Filme:1];[Filme:1]FID:1=Form:C1466.Movie.FID)
					MovieDBGetCastForMovie (Form:C1466.Movie.imdb;Form:C1466.Movie.FID)
					Form:C1466.Movie.reload()
					$cast:=Form:C1466.Movie.Mitwirkende.query("Person # null")
					Form:C1466.cast:=$cast
					Actoranzeige_LoadListboxGrid (True:C214)
				End if 
		End case 
		
	End if 
End if 