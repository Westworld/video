Case of 
	: (Form event:C388=On Load:K2:1)
		TRACE:C157
		C_PICTURE:C286($fanart)
		$fanartorig:=Get external data path:C1133([Filme:1]Fanart:26)
		If ($fanartorig#"")
			$fanart:=GetPictureFanArt ($fanartorig)
		End if 
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"fanart")
		If (Picture size:C356($fanart)>100)
			$ptr->:=$fanart
		Else 
			OBJECT SET VISIBLE:C603(*;"Fanart";False:C215)
		End if 
		
		C_TEXT:C284($path)
		Ratings_Set ("Rating1";"draw";"5")
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12
		Ratings_Set ("Rating2";"star-on";$path+"star-blue.png")
		Ratings_Set ("Rating2";"draw";"5")
		Ratings_Set ("Rating1";"set";String:C10([Filme:1]WertungT:28))
		Ratings_Set ("Rating2";"set";String:C10([Filme:1]WertungA:27))
		
		
		
		RELATE ONE SELECTION:C349([Mitwirkende:3];)
		  // sortieren wie Schau_Sort???
		Actoranzeige_LoadListbox 
		
	: (Form event:C388=On Resize:K2:27)
		
		Actoranzeige_LoadListbox 
End case 
