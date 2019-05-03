If (Form event:C388=On Display Detail:K2:22)
	If ([Mitwirkende:3]Kennung:3="R")
		OBJECT SET FONT STYLE:C166(*;"Feld_Titel";Bold:K14:2)
	Else 
		OBJECT SET FONT STYLE:C166(*;"Feld_Titel";Plain:K14:1)
	End if 
End if 
