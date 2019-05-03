$kodi_id:=kodi_Id{listbox1}

CREATE RECORD:C68([Filme:1])
ALL RECORDS:C47([Parameter:5])
If (Locked:C147([Parameter:5]))
	BEEP:C151
	ALERT:C41("Fehler, Parameter gesperrt")
	CANCEL:C270
	ABORT:C156
End if 
[Filme:1]FID:1:=[Parameter:5]FID:1
[Parameter:5]FID:1:=[Parameter:5]FID:1+1
SAVE RECORD:C53([Parameter:5])
[Filme:1]Kodi_ID:31:=$kodi_id
  //Progress QUIT (0)
KodiGetVideo ($kodi_id)
LISTBOX DELETE ROWS:C914(listbox1;listbox1)

