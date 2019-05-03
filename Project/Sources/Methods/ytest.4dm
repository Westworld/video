//%attributes = {}
ALL RECORDS:C47([Personen:17])

ARRAY LONGINT:C221($arrval;0)
ARRAY LONGINT:C221($arrcount;0)
DISTINCT VALUES:C339([Personen:17]PID:1;$arrval;$arrcount)
$text:=""
For ($i;1;Size of array:C274($arrcount))
	If ($arrcount{$i}>1)
		$text:=$text+String:C10($arrval{$i})+Char:C90(13)
	End if 
End for 
If ($text#"")
	SET TEXT TO PASTEBOARD:C523($text)
Else 
	
	While (Not:C34(End selection:C36([Personen:17])))
		CREATE RECORD:C68([Personen:17])
		[Personen:17]Bild:2:=[Personen:17]Bild:2
		[Personen:17]Bild2:4:=[Personen:17]Bild2:4
		[Personen:17]Bild3:10:=[Personen:17]Bild3:10
		[Personen:17]Engl_Beschreibung:11:=[Personen:17]Engl_Beschreibung:11
		[Personen:17]Geboren:6:=[Personen:17]Geboren:6
		[Personen:17]Herkunft:7:=[Personen:17]Herkunft:7
		[Personen:17]IMDB:3:=[Personen:17]IMDB:3
		[Personen:17]Kommentar:8:=[Personen:17]Kommentar:8
		[Personen:17]MovieDB:12:=[Personen:17]MovieDB:12
		[Personen:17]OFDB:9:=[Personen:17]OFDB:9
		[Personen:17]PID:1:=[Personen:17]PID:1
		[Personen:17]Suchname:5:=[Personen:17]Suchname:5
		[Personen:17]Todestag:13:=[Personen:17]Todestag:13
		SAVE RECORD:C53([Personen:17])
		NEXT RECORD:C51([Personen:17])
	End while 
End if 
