//%attributes = {}
SET WINDOW TITLE:C213("Hole Daten bei OFDB")

If (([Filme:1]OFDb:16#"") & ([Filme:1]OFDb:16#"???"))
	vOFDb_ID:=[Filme:1]OFDb:16
	vOFDB_IMDB:=[Filme:1]imdb:15
	vOFDB_OrigTItel:=[Filme:1]EnTitel:2
	vOFDB_DtTitel:=[Filme:1]DtTitel:9
	vOFDB_Erschienen:=[Filme:1]Jahr:4
	vOFDB_Land:=[Filme:1]Land:3
	vOFDB_Genre1:=[Filme:1]Genre1:5
	vOFDB_Genre2:=[Filme:1]Genre2:6
	vOFDB_Inhalt:=[Filme:1]Inhalt:7
	OFDBKleinBild:=[Filme:1]Bild:14
	
	Movie_Internet_OFDB_Daten_Sub 
	
	[Filme:1]OFDb:16:=vOFDb_ID
	[Filme:1]imdb:15:=vOFDB_IMDB
	[Filme:1]EnTitel:2:=vOFDB_OrigTItel
	[Filme:1]DtTitel:9:=vOFDB_DtTitel
	[Filme:1]Jahr:4:=vOFDB_Erschienen
	[Filme:1]Land:3:=vOFDB_Land
	[Filme:1]Genre1:5:=vOFDB_Genre1
	[Filme:1]Genre2:6:=vOFDB_Genre2
	[Filme:1]Inhalt:7:=vOFDB_Inhalt
	[Filme:1]Bild:14:=OFDBKleinBild
End if 
