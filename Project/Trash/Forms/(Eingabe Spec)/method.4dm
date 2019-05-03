If (Before:C29)
	If (=0)
		ALL RECORDS:C47([Parameter:5])
		:=[Parameter:5]PID:2
		[Parameter:5]PID:2:=[Parameter:5]PID:2+1
		SAVE RECORD:C53([Parameter:5])
	End if 
End if 