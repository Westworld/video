//%attributes = {"invisible":true}
  // lädt arrays für aktuelle Auswahl
  // teilt diese auf aktuelle Listbox auf

  // listbox format anpassen
$columns:=LISTBOX Get number of columns:C831(*;"Actoranzeige")
OBJECT GET COORDINATES:C663(*;"Actoranzeige";$left;$top;$right;$bottom)
$width:=$right-$left
$column_soll:=$width/<>ActorPictSize

If ($columns#$column_soll)
	LISTBOX DELETE COLUMN:C830(*;"Actoranzeige";2;$columns-1)
	
	For ($i;2;$column_soll)
		$ptr:=Get pointer:C304("header"+String:C10($i))
		$ptr->:=0
		LISTBOX INSERT COLUMN:C829(*;"Actoranzeige";$i;"arr"+String:C10($i);Get pointer:C304("arr"+String:C10($i))->;"Header"+String:C10($i);$ptr->)
	End for 
	
	LISTBOX SET COLUMN WIDTH:C833(*;"Actoranzeige";<>ActorPictSize)
	LISTBOX SET ROWS HEIGHT:C835(*;"Actoranzeige";<>ActorPictSize+10)
End if 

  // ende Listbox Format anpassen

ARRAY PICTURE:C279(Actor_Bilder;0)
ARRAY TEXT:C222(Actor_Titel;0)
ARRAY LONGINT:C221(Actor_ID;0)

SELECTION TO ARRAY:C260([Personen:17]Bild:2;Actor_Bilder;[Personen:17]Suchname:5;Actor_Titel;[Personen:17]PID:1;Actor_ID)

$columns:=LISTBOX Get number of columns:C831(*;"Actoranzeige")
$rows:=Size of array:C274(Actor_ID)\$columns+1

ARRAY TEXT:C222($arrColNames;$columns)
ARRAY TEXT:C222($arrHeaderNames;$columns)
ARRAY POINTER:C280($arrColVars;$columns)
ARRAY POINTER:C280($arrHeaderVars;$columns)
ARRAY BOOLEAN:C223($arrColsVisible;$columns)
ARRAY POINTER:C280($arrStyles;$columns)
LISTBOX GET ARRAYS:C832(*;"Actoranzeige";$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrColsVisible;$arrStyles)

For ($i;1;$columns)
	ARRAY PICTURE:C279($arrColVars{$i}->;0)
End for 

For ($i;1;$columns)
	ARRAY PICTURE:C279($arrColVars{$i}->;$rows)
	OBJECT SET FORMAT:C236(*;$arrColNames{$i};Char:C90(Scaled to fit proportional:K6:5))
End for 

$col:=0
$row:=1
For ($i;1;Size of array:C274(Actor_ID))
	$col:=$col+1
	If ($col>$columns)
		$col:=1
		$row:=$row+1
	End if 
	$svgRef:=SVG_New (<>ActorPictSize;<>ActorPictSize*1.5)
	PICTURE PROPERTIES:C457(Actor_Bilder{$i};$breit;$hoch)
	If ($breit><>ActorPictSize)
		$scale:=<>ActorPictSize/$Breit
		TRANSFORM PICTURE:C988(Actor_Bilder{$i};Scale:K61:2;$scale;$scale)
	End if 
	$objectRef:=SVG_New_embedded_image ($svgRef;Actor_Bilder{$i};1;20)
	$text:=SVG_New_text ($svgRef;Actor_Titel{$i};1;15;"{font-size:12px;fill:white;}")
	$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
	  //SVG_CLEAR($svgRef)
	$arrColVars{$col}->{$row}:=$MyPicture
End for 

