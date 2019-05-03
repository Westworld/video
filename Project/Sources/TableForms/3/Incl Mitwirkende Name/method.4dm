If (Form event:C388=On Display Detail:K2:22)
	If ([Mitwirkende:3]Kennung:3="@R@")
		OBJECT SET FONT STYLE:C166([Personen:17]Suchname:5;Bold:K14:2)
	Else 
		OBJECT SET FONT STYLE:C166([Personen:17]Suchname:5;Plain:K14:1)
	End if 
End if 
