If (Form event:C388=On Clicked:K2:4)
	If (Right click:C712)
		$popup:=Pop up menu:C542("Poster laden;Alles laden;Alles überschreiben;Bilder holen;Cast update;-;Weitere Daten")
		Case of 
			: ($popup=1)
				If ([Filme:1]imdb:15="")
					ALERT:C41("IMDB fehlt")
				Else 
					MovieDB_GetPoster ([Filme:1]imdb:15)
				End if 
			: ($popup=2)  // alles laden
				If ([Filme:1]imdb:15="")
					ALERT:C41("IMDB fehlt")
				Else 
					MovieDB_GetMovie ([Filme:1]imdb:15)
				End if 
				
			: ($popup=3)  // alles laden
				If ([Filme:1]imdb:15="")
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
				End if 
				
			: ($popup=7)
				  //query([Bilder];[Bilder]FID=[Originaltitel]FID)
				FORM GOTO PAGE:C247(2)
				
			: ($popup=4)
				Movie_Internet_imdb_Bilder ([Filme:1]FID:1;[Filme:1]imdb:15)
				QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
				
			: ($popup=5)
				MovieDBGetCastForMovie ([Filme:1]imdb:15;[Filme:1]FID:1)
				QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1)
				RELATE ONE SELECTION:C349([Mitwirkende:3];[Personen:17])
				Actoranzeige_LoadListbox 
		End case 
		
	End if 
End if 