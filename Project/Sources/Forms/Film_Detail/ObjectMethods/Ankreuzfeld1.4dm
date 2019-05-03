$savestatus:=Form:C1466.Movie.save(True:C214)
If (Not:C34(Bool:C1537($savestatus.success)))
	ALERT:C41(JSON Stringify:C1217($savestatus))
	TRACE:C157
End if 