//%attributes = {}
  //  konvertiert in html blob zeichen in iso

$text:=Convert to text:C1012($1;"iso-8859-1")
C_BLOB:C604($dummyblob)
SET BLOB SIZE:C606($dummyblob;1)

$pos:=Position:C15("&#";$text)
While ($pos>0)
	$sub:=Substring:C12($text;$pos)
	$pos2:=Position:C15(";";$sub)
	If (($pos2>8) | ($pos2<1))
		ALERT:C41("Fehler bei htmlblobtoisoblob "+$sub)
		$pos:=0
	Else 
		$zeichen:=Substring:C12($sub;3;$pos2-3)
		$suche:=Substring:C12($sub;1;$pos2)
		$isocode:=Num:C11($zeichen)
		$dummyblob{0}:=$isocode
		$newchar:=Convert to text:C1012($dummyblob;"Iso-8859-1")
		$text:=Replace string:C233($text;$suche;$newchar)
		
		$pos:=Position:C15("&#";$text)
	End if 
End while 

$0:=$text