//%attributes = {}
If (Count parameters:C259=0)
	C_LONGINT:C283(<>browserWindow)
	If (<>browserWindow=0)
		<>browserWindow:=New process:C317("Browser_LaunchWindow";256000;"New browser";"New";*)
	End if 
	SHOW PROCESS:C325(<>browserWindow)
	BRING TO FRONT:C326(<>browserWindow)
	DELAY PROCESS:C323(Current process:C322;60)
Else 
	$win:=Open form window:C675("Browser")
	DIALOG:C40("Browser")
	CLOSE WINDOW:C154($win)
	<>browserWindow:=0
End if 