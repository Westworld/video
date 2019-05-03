$kodi_id:=kodi_Id{listbox1}
$fid:=db_FID{listbox2}

CONFIRM:C162(kodi_detitle{listbox1}+" in "+db_detitle{listbox2}+" übertragen?")
If (OK=1)
	QUERY:C277([Filme:1];[Filme:1]FID:1=$fid)
	[Filme:1]Kodi_ID:31:=$kodi_id
	Progress QUIT (0)
	KodiGetVideo ($kodi_id)
	LISTBOX DELETE ROWS:C914(listbox1;listbox1)
End if 
