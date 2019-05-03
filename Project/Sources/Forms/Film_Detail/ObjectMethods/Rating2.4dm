If (Form event:C388=On Data Change:K2:15)
	$value:=Ratings_Set ("rating2";"get";"")
	Form:C1466.Movie.WertungA:=$value
	$savestatus:=Form:C1466.Movie.save(True:C214)
	If (Not:C34(Bool:C1537($savestatus.success)))
		ALERT:C41(JSON Stringify:C1217($savestatus))
		TRACE:C157
	End if 
End if 