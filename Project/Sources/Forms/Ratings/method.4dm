C_OBJECT:C1216($mydata)
C_TEXT:C284($path)
C_POINTER:C301($ptr)

If (Form event:C388=On Load:K2:1)
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12
	OB SET:C1220($mydata;"cancel-off";$path+"cancel-off.png")
	OB SET:C1220($mydata;"cancel-on";$path+"cancel-on.png")
	OB SET:C1220($mydata;"star-off";$path+"star-off.png")
	OB SET:C1220($mydata;"star-on";$path+"star-on.png")
	$ptr:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	
	$ptr->:=$mydata
End if 
