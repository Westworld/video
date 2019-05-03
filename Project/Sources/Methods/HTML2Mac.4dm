//%attributes = {}
  // wandelt HTML in Mac ASCII um


$text:=$1

$text:=Replace string:C233($text;Char:C90(10);"")
$text:=Replace string:C233($text;"&amp;>";"&")
$text:=Replace string:C233($text;"<BR>";"")
$text:=Replace string:C233($text;"</BR>";"")
$text:=Replace string:C233($text;"<BR/>";"")
$text:=Replace string:C233($text;"<BR />";"")

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
$text:=Replace string:C233($text;"&auml;";"ä")
$text:=Replace string:C233($text;"&ouml;";"ö")
$text:=Replace string:C233($text;"&uuml;";"ü")
$text:=Replace string:C233($text;"&Auml;";"Ä")
$text:=Replace string:C233($text;"&Ouml;";"Ö")
$text:=Replace string:C233($text;"&Uuml;";"Ü")
$text:=Replace string:C233($text;"&szlig;";"ß")

  //$text:=Replace string($text;"&Agrave;";"À")
  //$text:=Replace string($text;"&Aacute;";"Á")
  //$text:=Replace string($text;"&Acirc;";"Â")
  //$text:=Replace string($text;"&Atilde;";"Ã")
  //$text:=Replace string($text;"&Aring;";"Å")
  //$text:=Replace string($text;"&AElig;";"Æ")
  //$text:=Replace string($text;"&Ccedil;";"Ç")
  //$text:=Replace string($text;"&Egrave;";"È")
  //$text:=Replace string($text;"&Eacute;";"É")
  //$text:=Replace string($text;"&Ecirc;";"Ê")
  //$text:=Replace string($text;"&Euml;";"Ë")
  //$text:=Replace string($text;"&Igrave;";"Ì")
  //$text:=Replace string($text;"&Iacute;";"Í")
  //$text:=Replace string($text;"&Icirc;";"Î")
  //$text:=Replace string($text;"&Iuml;";"Ï")

  // web_removehtmltags enthält vollständige dekodierunG!

  //$text:=Replace string($text;"&szlig;";"ß")

$0:=$text
