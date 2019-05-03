If (Form event:C388=On Clicked:K2:4)
	  //OBJECT GET COORDINATES(*;"Genre";$left;$top;$right;$bottom)
	  //GET WINDOW RECT($winleft;$wintop;$Winright;$winbottom)
	  //$x:=$left+$winleft
	  //$y:=$bottom+$wintop
	
	
	GET MOUSE:C468($x;$y;$taste;*)
	
	C_OBJECT:C1216($formobject;$col)
	C_COLLECTION:C1488($genre;$genre1;$genre2)
	$col:=ds:C1482.Filme.all()
	$genre1:=$col.distinct("Genre1")
	$genre2:=$col.distinct("Genre2")
	$genre:=$genre1.combine($genre2)
	$formobject:=New object:C1471("list";$genre;"window";Frontmost window:C447;"merkmal";False:C215)
	$win:=Open form window:C675("PopupCollection";Pop up form window:K39:11;$x;$y)
	  //$win:=Open form window("PopupCollection";Plain window;$left+$winleft;$bottom+$wintop)
	DIALOG:C40("PopupCollection";$formobject;*)
	
End if 