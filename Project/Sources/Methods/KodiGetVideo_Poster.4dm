//%attributes = {}
  // lädt bild von Kodi,
  // setzt voraus das SMB NAS schon gemountet ist
  // $1 = bildpfad, $0 = bild

C_PICTURE:C286($bild)
$pfad:=$1

$pfad:=Replace string:C233($pfad;"%20";" ")
$pfad:=Replace string:C233($pfad;"%3a";":")
$pfad:=Replace string:C233($pfad;"%2f";"/")


If ($pfad="image://smb@")
	$pfad:=Replace string:C233($pfad;"image://smb://nas/";"/Volumes/")
	If ($pfad="@/")
		$pfad:=Substring:C12($pfad;1;Length:C16($pfad)-1)
	End if 
	$pfad:=Convert path POSIX to system:C1107($pfad)
	READ PICTURE FILE:C678($pfad;$bild)
	If (OK=0)
		ALERT:C41("fehler, bild konnte nicht geladen werden")
	End if 
Else 
	If ($pfad="image://http:@")
		$pfad:=Substring:C12($pfad;9)
		C_PICTURE:C286($bild)
		If ($pfad="@/")
			$pfad:=Substring:C12($pfad;1;Length:C16($pfad)-1)
		End if 
		$status:=HTTP Get:C1157($pfad;$bild)
		
	Else 
		  // image://http://image.tmdb.org/t/p/original/11usohthIPT0g6pj9KhNVCgaQVi.jpg/
		ALERT:C41("falscher bildpfad?")
		TRACE:C157
	End if 
End if 

$0:=$bild

