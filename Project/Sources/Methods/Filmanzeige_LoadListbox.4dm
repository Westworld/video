//%attributes = {}
  // lädt arrays für aktuelle Auswahl
  // teilt diese auf aktuelle Listbox auf

  //$1 = job
If (Count parameters:C259>0)
	$job:=$1
Else 
	$job:=""
End if 

  //SET DATABASE PARAMETER(34;3)

  // listbox format anpassen
$columns:=LISTBOX Get number of columns:C831(*;"Filmanzeige")
OBJECT GET COORDINATES:C663(*;"Filmanzeige";$left;$top;$right;$bottom)
$width:=$right-$left
$column_soll:=$width\<>CoverPictSize

  // ende Listbox Format anpassen

If ($job#"resize")
	LoadAllMovies 
End if 

If ($columns#$column_soll)
	LISTBOX DELETE COLUMN:C830(*;"Filmanzeige";2;$columns-1)
	
	For ($i;2;$column_soll)
		$ptr:=Get pointer:C304("header"+String:C10($i))
		$ptr->:=0
		LISTBOX INSERT COLUMN:C829(*;"Filmanzeige";$i;"arr"+String:C10($i);Get pointer:C304("arr"+String:C10($i))->;"Header"+String:C10($i);$ptr->)
	End for 
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"arr"+String:C10($i);Align left:K42:2)
	LISTBOX SET COLUMN WIDTH:C833(*;"Filmanzeige";<>CoverPictSize)
	LISTBOX SET ROWS HEIGHT:C835(*;"Filmanzeige";<>CoverPictSize+10)
	If ($job="resize")
		$job:=""  // do all new!
	End if 
End if 

If (Not:C34($job="resize"))
	$columns:=LISTBOX Get number of columns:C831(*;"Filmanzeige")
	$rows:=Size of array:C274(Filme_ID)\$columns+1
	
	ARRAY TEXT:C222($arrColNames;$columns)
	ARRAY TEXT:C222($arrHeaderNames;$columns)
	ARRAY POINTER:C280($arrColVars;$columns)
	ARRAY POINTER:C280($arrHeaderVars;$columns)
	ARRAY BOOLEAN:C223($arrColsVisible;$columns)
	ARRAY POINTER:C280($arrStyles;$columns)
	LISTBOX GET ARRAYS:C832(*;"Filmanzeige";$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrColsVisible;$arrStyles)
	
	For ($i;1;$columns)
		ARRAY PICTURE:C279($arrColVars{$i}->;0)
	End for 
	
	For ($i;1;$columns)
		ARRAY PICTURE:C279($arrColVars{$i}->;$rows)
		OBJECT SET FORMAT:C236(*;$arrColNames{$i};Char:C90(Truncated non centered:K6:4))
		
	End for 
	
	$col:=0
	$row:=1
	For ($i;1;Size of array:C274(Filme_ID))
		$col:=$col+1
		If ($col>$columns)
			$col:=1
			$row:=$row+1
		End if 
		If (Picture size:C356(Filme_Bilder{$i})>100)
			
			PICTURE PROPERTIES:C457(Filme_Bilder{$i};$breit;$hoch)
			If ($breit>(<>CoverPictSize-50))
				$scale:=(<>CoverPictSize-50)/$Breit
				TRANSFORM PICTURE:C988(Filme_Bilder{$i};Scale:K61:2;$scale;$scale)
			End if 
			  // $svgRef:=SVG_New (<>CoverPictSize;<>CoverPictSize*1.5)
			  //$objectRef:=SVG_New_embedded_image ($svgRef;Filme_Bilder{$i};1;20)
			  //$text:=SVG_New_text ($svgRef;Filme_Titel{$i};1;15;"{font-size:12px;fill:white;}")
			  //$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source)
			  //SVG_CLEAR($svgRef)
			  //$arrColVars{$col}->{$row}:=$MyPicture
			$arrColVars{$col}->{$row}:=Filme_Bilder{$i}
			
		Else 
			$svgRef:=SVG_New (<>CoverPictSize;<>CoverPictSize*1.5)
			$text:=SVG_New_textArea ($svgRef;Filme_Titel{$i};1;15;<>CoverPictSize;<>CoverPictSize*1.5;"{font-size:24px;fill:yellow;}")
			$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
			$arrColVars{$col}->{$row}:=$MyPicture
		End if 
	End for 
End if 

  //SET DATABASE PARAMETER(34;0)