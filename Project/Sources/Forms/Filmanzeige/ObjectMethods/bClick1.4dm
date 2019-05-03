If (Form event:C388=On Clicked:K2:4)
	OBJECT GET COORDINATES:C663(*;"Merkmal";$left;$top;$right;$bottom)
	GET WINDOW RECT:C443($winleft;$wintop;$Winright;$winbottom)
	$win:=Open form window:C675("PopupMerkmal";Pop up form window:K39:11;$left+$winleft;$bottom+$wintop)
	  //$win:=Open form window("PopupBlack";Plain window;$left+$winleft;$bottom+$wintop)
	DIALOG:C40("PopupMerkmal";*)
	  //close window($win)
	
End if 