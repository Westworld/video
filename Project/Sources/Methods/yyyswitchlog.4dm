//%attributes = {}
$value:=Get database parameter:C643(34)
If ($value#0)
	SET DATABASE PARAMETER:C642(34;0)
Else 
	SET DATABASE PARAMETER:C642(34;3)
End if 
