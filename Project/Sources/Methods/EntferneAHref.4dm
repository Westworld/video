//%attributes = {}
  // entfernt ahref und ähnliches

$text:=$1
$KlammerAuf:="<a"
$klammerzu:=">"
Repeat 
	$continue:=True:C214
	$pos:=Position:C15($KlammerAuf;$text)
	If ($pos>0)
		$such:=Substring:C12($text;$pos)
		$pos2:=Position:C15($KlammerZu;$such)
		If ($pos2>0)
			$such:=Substring:C12($such;1;$pos2)
			$text:=Replace string:C233($text;$Such;"")
		End if 
	Else 
		$continue:=False:C215
	End if 
Until ($Continue=False:C215)

$text:=Replace string:C233($text;"</a>";"")
$text:=Replace string:C233($text;"</p>";"")
$text:=Replace string:C233($text;"<p>";"")
$text:=Replace string:C233($text;"</b>";"")
$text:=Replace string:C233($text;"<b>";"")
$text:=Replace string:C233($text;"<br />";"\n")
$0:=$text