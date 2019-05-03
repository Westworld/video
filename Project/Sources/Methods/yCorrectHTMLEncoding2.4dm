//%attributes = {}
$text:=$1
$pos:=Position:C15("&#";$text)
While ($pos>0)
	$sub:=Substring:C12($text;$pos)
	$pos2:=Position:C15(";";$sub)
	If (($pos2>8) | ($pos2<1))
		ALERT:C41("Fehler bei HTML2Mac "+$sub)
		$pos:=0
	Else 
		$zeichen:=Substring:C12($sub;3;$pos2-3)
		$suche:=Substring:C12($sub;1;$pos2)
		If ($zeichen="x@")
			$char:=Tools_HexToDez ($zeichen)
			  // $char ist iso-8859-1 muß in UTF16 gewandelt werden
			C_BLOB:C604($dummyblob)
			SET BLOB SIZE:C606($dummyblob;1)
			$dummyblob{0}:=$char
			$zeichen:=String:C10(Character code:C91(Convert to text:C1012($dummyblob;"Iso-8859-1")))
		End if 
		
		$text:=Replace string:C233($text;$suche;Char:C90(Num:C11($zeichen)))
		$pos:=Position:C15("&#";$text)
	End if 
	
End while 
$0:=$text