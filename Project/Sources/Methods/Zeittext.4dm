//%attributes = {}
If (($1#?00:00:00?) & ($1#?00:05:00?) & ($1#?00:02:00?))
	$0:=Substring:C12(String:C10($1;2);2)
Else 
	$0:=""
End if 