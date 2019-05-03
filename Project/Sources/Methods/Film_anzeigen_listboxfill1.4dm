//%attributes = {}
  // von Film_neu

C_BOOLEAN:C305($1)
If (Count parameters:C259>0)
	$new:=$1
Else 
	$new:=False:C215
End if 

$CoverPictSize:=160

$columns:=LISTBOX Get number of columns:C831(*;"Filmanzeige")
OBJECT GET COORDINATES:C663(*;"Filmanzeige";$left;$top;$right;$bottom)
$width:=$right-$left
$column_soll:=$width\$CoverPictSize

If ($columns#$column_soll)
	LISTBOX DELETE COLUMN:C830(*;"Filmanzeige";2;$columns-1)
	
	C_POINTER:C301($nilptr)
	For ($i;2;$column_soll)
		  //LISTBOX INSERT COLUMN(*;"Filmanzeige";$i;"arr"+String($i);$nilptr;"Header"+String($i);$nilptr)
		LISTBOX INSERT COLUMN FORMULA:C970(*;"Filmanzeige";$i;"arr"+String:C10($i);"Listbox_Grid_ShowCover(This.Film"+String:C10($i)+")";Is picture:K8:10;"Header"+String:C10($i);$nilptr)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"arr"+String:C10($i);Align left:K42:2)
		  //LISTBOX SET COLUMN FORMULA(*;"arr"+String($i);"Listbox_Grid_ShowCover(This.Film"+String($i)+")";Is picture)
		OBJECT SET FORMAT:C236(*;"arr"+String:C10($i);Char:C90(Scaled to fit prop centered:K6:6))
	End for 
	LISTBOX SET COLUMN WIDTH:C833(*;"Filmanzeige";$CoverPictSize)
	LISTBOX SET ROWS HEIGHT:C835(*;"Filmanzeige";$CoverPictSize+10)
End if 

If (($columns#$column_soll) | ($new))
	
	$i:=0
	Form:C1466.Grid:=New collection:C1472
	C_OBJECT:C1216($element)
	While ($i<Form:C1466.Filme.length)
		$element:=New object:C1471("Film1";$i)
		$i:=$i+1
		
		$j:=2
		While ($j<=$column_soll)
			If ($i<Form:C1466.Filme.length)
				$element["Film"+String:C10($j)]:=$i
			Else 
				$element["Film"+String:C10($j)]:=Null:C1517
			End if 
			$i:=$i+1
			$j:=$j+1
		End while 
		
		Form:C1466.Grid.push($element)
		$i:=$i+1
	End while 
	
End if 

