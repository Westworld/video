//%attributes = {}
$t:=$1
Case of 
	: (Substring:C12($t;Length:C16($t)-4)=", die")
		$t:="Die "+Substring:C12($t;1;Length:C16($t)-5)
	: (Substring:C12($t;Length:C16($t)-4)=", der")
		$t:="Der "+Substring:C12($t;1;Length:C16($t)-5)
	: (Substring:C12($t;Length:C16($t)-4)=", das")
		$t:="Das "+Substring:C12($t;1;Length:C16($t)-5)
	: (Substring:C12($t;Length:C16($t)-4)=", Ein")
		$t:="Ein "+Substring:C12($t;1;Length:C16($t)-5)
	: (Substring:C12($t;Length:C16($t)-5)=", Eine")
		$t:="Eine "+Substring:C12($t;1;Length:C16($t)-6)
		
	: (Substring:C12($t;Length:C16($t)-5)=", die ")
		$t:="Die "+Substring:C12($t;1;Length:C16($t)-6)
	: (Substring:C12($t;Length:C16($t)-5)=", der ")
		$t:="Der "+Substring:C12($t;1;Length:C16($t)-6)
	: (Substring:C12($t;Length:C16($t)-5)=", das ")
		$t:="Das "+Substring:C12($t;1;Length:C16($t)-6)
	: (Substring:C12($t;Length:C16($t)-5)=", Ein ")
		$t:="Ein "+Substring:C12($t;1;Length:C16($t)-6)
	: (Substring:C12($t;Length:C16($t)-6)=", Eine ")
		$t:="Eine "+Substring:C12($t;1;Length:C16($t)-7)
End case 
$0:=$t