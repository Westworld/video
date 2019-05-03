//%attributes = {}
  // gibt neue ID zurück
C_LONGINT:C283($0)

C_OBJECT:C1216($para)
$para:=ds:C1482.Parameter.all().first()
Repeat 
	Case of 
		: ($1="FID")
			$para.FID:=$para.FID+1
			$0:=$para.FID
		: ($1="PID")
			$para.PID:=$para.PID+1
			$0:=$para.PID
		Else 
			TRACE:C157
	End case 
	C_OBJECT:C1216($status)
	$status:=$para.save(True:C214)
	If (Not:C34($status.success))
		ALERT:C41(JSON Stringify:C1217($status))
		$para.reload()
	End if 
Until ($status.success)