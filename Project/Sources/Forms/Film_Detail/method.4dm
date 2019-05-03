Case of 
	: (Form event:C388=On Load:K2:1)
		Form:C1466.BildIndex:=0
		
		C_PICTURE:C286($fanart)
		$fanart:=Form:C1466.Movie.Fanart
		If (Picture size:C356($fanart)>100)
			PICTURE PROPERTIES:C457($fanart;$breit;$hoch)
			$svgRef:=SVG_New ($breit;$hoch)
			$objectRef:=SVG_New_embedded_image ($svgRef;$fanart;0;0)
			SVG_SET_BRIGHTNESS ($objectRef;0.3)
			$fanart:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
			
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"fanart")
			
			OBJECT SET VISIBLE:C603(*;"Fanart";True:C214)
			$ptr->:=$fanart
		Else 
			OBJECT SET VISIBLE:C603(*;"Fanart";False:C215)
		End if 
		
		
		C_TEXT:C284($path)
		Ratings_Set ("Rating1";"draw";"5")
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12
		Ratings_Set ("Rating2";"star-on";$path+"star-blue.png")
		Ratings_Set ("Rating2";"draw";"5")
		Ratings_Set ("Rating1";"set";String:C10(Form:C1466.Movie.WertungT))
		Ratings_Set ("Rating2";"set";String:C10(Form:C1466.Movie.WertungA))
		
		C_OBJECT:C1216($cast)
		$cast:=Form:C1466.Movie.Mitwirkende.query("Person # null")
		Form:C1466.cast:=$cast
		  //Form.Cast:=$cast.orderBy("Person.spieltinFilmen.length")
		  //Form.cast:=$cast.sort("Schau_Sort_Col")
		  // sortieren wie Schau_Sort???
		Actoranzeige_LoadListboxGrid 
		
	: (Form event:C388=On Resize:K2:27)
		
		Actoranzeige_LoadListboxGrid 
End case 
