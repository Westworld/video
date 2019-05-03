//%attributes = {}
If (Length:C16($1)>4)
	If ($1[[Length:C16($1)-4]]=",")
		$0:=Substring:C12($1;Length:C16($1)-2)+" "+Substring:C12($1;1;Length:C16($1)-5)
	Else 
		$0:=$1
	End if 
Else 
	$0:=$1
End if 