//%attributes = {}
$ref:=Open document:C264("";"")
If (ok=1)
	CLOSE DOCUMENT:C267($ref)
	$pfad:=document
End if 
READ PICTURE FILE:C678($pfad;mypict)