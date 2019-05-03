If (Form event:C388=On Clicked:K2:4)
	
	GET MOUSE:C468($x;$y;$taste;*)
	
	C_OBJECT:C1216($formobject)
	C_COLLECTION:C1488($merkmal)
	$merkmal:=New collection:C1472
	ARRAY TEXT:C222($merkmalarray;0)
	LIST TO ARRAY:C288("Merkmal";$merkmalarray)
	ARRAY TO COLLECTION:C1563($merkmal;$merkmalarray)
	
	$formobject:=New object:C1471("list";$merkmal;"window";Frontmost window:C447;"merkmal";True:C214)
	$win:=Open form window:C675("PopupCollection";Pop up form window:K39:11;$x;$y)
	DIALOG:C40("PopupCollection";$formobject;*)
	
End if 