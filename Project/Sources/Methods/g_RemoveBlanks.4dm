//%attributes = {}
  // entfernt Blanks am Anfang oder Ende


$text:=$1

While ($text=" @")
	$text:=Substring:C12($text;2)
End while 

While ($text="@ ")
	$text:=Substring:C12($text;1;Length:C16($text)-1)
End while 

$0:=$text
