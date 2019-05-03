If (Form event:C388=On Data Change:K2:15)
	$value:=Ratings_Set ("rating1";"get";"")
	[Filme:1]WertungT:28:=$value
	SAVE RECORD:C53([Filme:1])
End if 