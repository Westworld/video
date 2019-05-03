//%attributes = {}
  // HTTP Auswertung
  // $1 = HTTP Blob
  // $2 = Kennung für Query
  // $3 = Ptr auf Array, optional
  // $4 = Ptr auf Array für Zusatzwort, optional
  // $0 = rückgabe Text, bei Array letzter Treffer
  // as in [Originaltitel]Jahr:=HTTP_Parse ($pagecontent;"OFDb_jahr_Browser")

$ergebnis:=""
$ergebnis2:=""
C_BLOB:C604($1;$theBlob)
$theBlob:=$1

If (False:C215)
	BLOB TO DOCUMENT:C526("debug.txt";$theblob)
End if 

$fulltext:=Convert to text:C1012($theBlob;"iso-8859-1")
If ($fulltext="@charset=iso-8859-1@")
	$unicodeactiv:=Get database parameter:C643(Unicode mode:K37:40)
	If ($unicodeactiv=1)
		$fulltext:=HTMLBlobToIsoBlob ($theBlob)
	End if 
Else 
	If ($fulltext="@charset=UTF-8@")
		$fulltext2:=Convert to text:C1012($theBlob;"UTF-8")
		If ($fulltext2#"")
			$fulltext:=$fulltext2
		Else 
			  // könnte Fehler von OFDB sein, im Source falsche Codierung für Kommentar
			$loop:=0
			While ($loop<BLOB size:C605($theblob))
				If (($theBlob{$loop}=0x00FC) | ($theBlob{$loop}=0x00E4) | ($theBlob{$loop}=0x00F6))  // rechtsbündig   in ISO-8859-1 codiert
					$theBlob{$loop}:=0x0020
				End if 
				$loop:=$loop+1
			End while 
			$fulltext2:=Convert to text:C1012($theBlob;"UTF-8")
			If ($fulltext2#"")
				$fulltext:=$fulltext2
			Else 
				
			End if 
		End if 
		
	End if 
End if 

$0:=HTTP_Parse ($fulltext;$2;$3;$4)

