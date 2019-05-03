If (Form event:C388=On Selection Change:K2:29)
	C_COLLECTION:C1488($sel)
	$sel:=Form:C1466.result
	If ($sel.length>0)
		If (Form:C1466.merkmal)
			CALL FORM:C1391(Form:C1466.window;"Film_anzeigen_listboxfill";True:C214;Null:C1517;$sel)
		Else 
			CALL FORM:C1391(Form:C1466.window;"Film_anzeigen_listboxfill";True:C214;$sel)
		End if 
	End if 
	
	
End if 