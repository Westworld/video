C_TEXT:C284($name)
C_POINTER:C301($ptr)
C_LONGINT:C283($val)

If (Form event:C388=On Clicked:K2:4)
	$name:=OBJECT Get name:C1087(Object current:K67:2)
	
	$ptr:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	If ($name="CancelPict")
		Ratings_Set ("Rating1";"setdraw";"0";$ptr->)
	Else 
		$val:=Num:C11(Substring:C12($name;5))
		Ratings_Set ("Rating1";"setdraw";String:C10($val);$ptr->)
	End if 
End if 
