//%attributes = {}
$url:=$1
$i:=1
$j:=1
$shift:=0
While ($i<=Length:C16($url))
	$char:=Substring:C12($url;Length:C16($url)-$i+1;1)
	Case of 
		: ($char="a")
			$shift:=$shift+((16^($j-1))*10)
		: ($char="b")
			$shift:=$shift+((16^($j-1))*11)
		: ($char="c")
			$shift:=$shift+((16^($j-1))*12)
		: ($char="d")
			$shift:=$shift+((16^($j-1))*13)
		: ($char="e")
			$shift:=$shift+((16^($j-1))*14)
		: ($char="f")
			$shift:=$shift+((16^($j-1))*15)
		: (($char>="0") & ($char<="9"))
			$shift:=$shift+((16^($j-1))*Num:C11($char))
		Else 
			$j:=$j-1
	End case 
	$i:=$i+1
	$j:=$j+1
End while 
$0:=$shift