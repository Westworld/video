//%attributes = {}
  // zeigt Cover für aktuelle Zelle

  //$id:=$1
  //If ($id<Form.Filme.length)
  //$0:=Form.Filme[$id].Bild
  //Else 
  //C_PICTURE($bild)
  //$0:=$bild
  //End if 

$ActorPictSize:=160

C_LONGINT:C283($2;$pos)
C_OBJECT:C1216($1;$movie)
C_PICTURE:C286($0)
$columns:=LISTBOX Get number of columns:C831(*;"Actoranzeige")
$pos:=$1.value*$columns+$2

If (Form:C1466.cast=Null:C1517)
	$movie:=Form:C1466.Personen[$pos]
	$rolle:=""
Else 
	$movie:=Form:C1466.cast[$pos].Person
	$rolle:=Form:C1466.cast[$pos].Rolle
	If (($rolle="") & (Form:C1466.cast[$pos].Kennung="R"))
		$rolle:="Regie"
	End if 
End if 

If ($movie#Null:C1517)
	If (Picture size:C356($movie.Bild)>100)
		$MyPicture2:=$movie.Bild
		
		PICTURE PROPERTIES:C457($MyPicture2;$x;$y)
		$scalex:=$ActorPictSize/$x
		$scaley:=$ActorPictSize/$y
		  //log event(Into 4D commands log;string($scalex)+"/"+string($scaley)
		If ($scalex>$scaley)
			TRANSFORM PICTURE:C988($MyPicture2;Scale:K61:2;$scaley;$scaley)
		Else 
			TRANSFORM PICTURE:C988($MyPicture2;Scale:K61:2;$scalex;$scalex)
		End if 
		
		$svgRef:=SVG_New ($ActorPictSize;$ActorPictSize*1.5)
		$objectRef:=SVG_New_embedded_image ($svgRef;$MyPicture2;1;20)
		$text:=SVG_New_text ($svgRef;$movie.Suchname;1;15;"{font-size:12px;fill:white;}")
		If ($rolle#"")
			$text2:=SVG_New_text ($svgRef;$rolle;1;$ActorPictSize-12;"{font-size:12px;fill:white;}")
		End if 
		$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
		
	Else 
		$svgRef:=SVG_New (160;160*1.5)
		$text:=SVG_New_textArea ($svgRef;$movie.Suchname;1;15;160;160*1.5;"{font-size:24px;fill:yellow;}")
		$text2:=SVG_New_text ($svgRef;$rolle;1;$ActorPictSize-12;"{font-size:12px;fill:white;}")
		$MyPicture:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
	End if 
	
	$0:=$MyPicture
	
Else 
	C_PICTURE:C286($bild)
	$0:=$bild
End if 
