If (Form event:C388=On Load:K2:1)
	CLEAR VARIABLE:C89(mypict)
	If ([Bilder:8]FID:1=0)
		[Bilder:8]FID:1:=[Filme:1]FID:1
	End if 
End if 