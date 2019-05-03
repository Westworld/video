//%attributes = {}
  // zeigt Cover für aktuelle Zelle

  //$id:=$1
  //If ($id<Form.Filme.length)
  //$0:=Form.Filme[$id].Bild
  //Else 
  //C_PICTURE($bild)
  //$0:=$bild
  //End if 

$CoverPictSize:=160

C_LONGINT:C283($2;$pos)
C_OBJECT:C1216($1;$movie)
C_PICTURE:C286($0)
$columns:=LISTBOX Get number of columns:C831(*;"Filmanzeige")
$pos:=$1.value*$columns+$2
If (Form:C1466.Actor#Null:C1517)
	$movie:=Form:C1466.Filme[$pos].Film  // Anzeige in Schauspieler, Collection ist Mitwirkende
Else 
	$movie:=Form:C1466.Filme[$pos]
End if 
If ($movie#Null:C1517)
	If (Picture size:C356($movie.Bild)#0)
		$MyPicture:=$movie.Bild
	Else 
		$svgRef:=SVG_New (160;160*1.5)
		$text:=SVG_New_textArea ($svgRef;$movie.DtTitel;1;15;160;160*1.5;"{font-size:24px;fill:yellow;}")
		$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
	End if 
	
	PICTURE PROPERTIES:C457($MyPicture;$x;$y)
	$scalex:=$CoverPictSize/$x
	$scaley:=$CoverPictSize/$y
	  //log event(Into 4D commands log;string($scalex)+"/"+string($scaley)
	If ($scalex>$scaley)
		TRANSFORM PICTURE:C988($MyPicture;Scale:K61:2;$scaley;$scaley)
	Else 
		TRANSFORM PICTURE:C988($MyPicture;Scale:K61:2;$scalex;$scalex)
	End if 
	
	$0:=$MyPicture
	
Else 
	C_PICTURE:C286($bild)
	$0:=$bild
End if 
