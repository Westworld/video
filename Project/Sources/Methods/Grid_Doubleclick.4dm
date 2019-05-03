//%attributes = {}
C_TEXT:C284($1;$listboxname)
C_TEXT:C284($2;$formname)

$listboxname:=$1
$formname:=$2

C_LONGINT:C283($item)
C_OBJECT:C1216($movie;$actor;$form)
LISTBOX GET CELL POSITION:C971(*;$listboxname;$column;$row)
$columns:=LISTBOX Get number of columns:C831(*;$listboxname)
$item:=($columns*($row-1))+$column


Case of 
	: ($listboxname="Actoranzeige")
		If (Form:C1466.cast=Null:C1517)
			$actor:=Form:C1466.Personen[$item-1]
		Else 
			$actor:=Form:C1466.cast[$item-1].Person
		End if 
		$form:=New object:C1471("Actor";$actor)
		
	: ($listboxname="Filmanzeige")
		$movie:=Form:C1466.Filme[$item-1].Film
		If ($movie=Null:C1517)
			$movie:=Form:C1466.Filme[$item-1]
		End if 
		$form:=New object:C1471("Movie";$movie)
End case 


$win:=Open form window:C675($formname;*)
DIALOG:C40($formname;$form;*)
