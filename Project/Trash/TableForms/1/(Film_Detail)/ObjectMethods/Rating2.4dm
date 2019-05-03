If (Form event:C388=On Data Change:K2:15)
	$value:=Ratings_Set ("rating2";"get";"")
	[Filme:1]WertungA:27:=$value
	SAVE RECORD:C53([Filme:1])
End if 