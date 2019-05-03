//%attributes = {}
  // lädt arrays für aktuelle Auswahl
  // teilt diese auf aktuelle Listbox auf

  // listbox format anpassen

If (Count parameters:C259>0)
	$new:=$1
Else 
	$new:=False:C215
End if 

$ActorPictSize:=160
$columns:=LISTBOX Get number of columns:C831(*;"Actoranzeige")
OBJECT GET COORDINATES:C663(*;"Actoranzeige";$left;$top;$right;$bottom)
$width:=$right-$left
C_LONGINT:C283($column_soll)
$column_soll:=$width/$ActorPictSize

If ($columns#$column_soll)
	LISTBOX DELETE COLUMN:C830(*;"Actoranzeige";1;$columns)
	C_POINTER:C301($nilptr)
	For ($i;1;$column_soll)
		LISTBOX INSERT COLUMN FORMULA:C970(*;"Actoranzeige";$i;"arr"+String:C10($i);"Listbox_Grid_ShowActor(This;"+String:C10($i-1)+")";Is picture:K8:10;"Header"+String:C10($i);$nilptr)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"arr"+String:C10($i);Align left:K42:2)
		OBJECT SET FORMAT:C236(*;"arr"+String:C10($i);Char:C90(Truncated non centered:K6:4))  //Scaled to fit proportional))
		LISTBOX SET PROPERTY:C1440(*;"arr"+String:C10($i);lk resizing mode:K53:36;lk manual:K53:60)
	End for 
	
	LISTBOX SET COLUMN WIDTH:C833(*;"Actoranzeige";$ActorPictSize)
	LISTBOX SET ROWS HEIGHT:C835(*;"Actoranzeige";$ActorPictSize+10)
End if 

If (($columns#$column_soll) | $new)
	C_COLLECTION:C1488($col)
	C_LONGINT:C283($nbmovies;$nbrows;$i)
	
	If (Form:C1466.cast=Null:C1517)  // Personen anzeige über Menu
		$nbmovies:=Form:C1466.Personen.length
	Else   // Personen anzeige in Film
		$nbmovies:=Form:C1466.cast.length
	End if 
	$nbrows:=($nbmovies+($column_soll-1))\$column_soll
	Form:C1466.Grid:=New collection:C1472
	$col:=Form:C1466.Grid
	$col.resize($nbrows)
	For ($i;0;$nbrows-1)
		$col[$i]:=$i  // I put a number as the collection element, list box will automatically use it as This.value
	End for 
	
End if 


