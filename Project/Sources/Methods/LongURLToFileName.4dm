//%attributes = {}
  // Projektmethode Long url to file name 


C_TEXT:C284($1;$0)
_O_C_INTEGER:C282($viLen;$viPos;$viChar;$viDirSymbol)

$viDirSymbol:=Character code:C91("/")
$viLen:=Length:C16($1)
$viPos:=0
For ($viChar;$viLen;1;-1)
	If (Character code:C91($1[[$viChar]])=$viDirSymbol)
		$viPos:=$viChar
		$viChar:=0
	End if 
End for 
If ($viPos>0)
	$0:=Substring:C12($1;$viPos+1)
Else 
	$0:=$1
End if 