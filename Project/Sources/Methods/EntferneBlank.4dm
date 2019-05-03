//%attributes = {}

$text:=$1
While ($Text=" @")
	$text:=Substring:C12($text;2)
End while 
While ($Text="@ ")
	$text:=Substring:C12($text;1;Length:C16($text)-1)
End while 
$pos:=Position:C15("  ";$text)
While ($pos>0)
	$text:=Replace string:C233($text;"  ";" ")
	$pos:=Position:C15("  ";$text)
End while 
$0:=$text