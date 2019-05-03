//%attributes = {}
  // entfernt span 

$text:=$1
$pos:=Position:C15("<";$text)
If ($pos>0)
	$pos2:=Position:C15(">";$text)
	If ($pos2>0)
		$text2:=Substring:C12($text;1;$pos-1)+Substring:C12($text;$pos2+1)
		If ($text2#"")
			$text:=$text2
		End if 
	End if 
End if 

  // und nochmal

$pos:=Position:C15("<";$text)
If ($pos>0)
	$pos2:=Position:C15(">";$text)
	If ($pos2>0)
		$text2:=Substring:C12($text;1;$pos-1)+Substring:C12($text;$pos2+1)
		If ($text2#"")
			$text:=$text2
		End if 
	End if 
End if 

$0:=$text