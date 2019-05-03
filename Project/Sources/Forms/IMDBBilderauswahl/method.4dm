Case of 
	: (Form event:C388=On Load:K2:1)
		SET WINDOW TITLE:C213(String:C10(Size of array:C274(Bild_Image))+" Bilder")
		
		If (Size of array:C274(image)>0)
			ARRAY TEXT:C222(Bild_Url;Size of array:C274(Bild_Image))
			SET TIMER:C645(1)
		End if 
		
	: (Form event:C388=On Timer:K2:25)
		If (Size of array:C274(image1)>0)
			$i:=1
			SET WINDOW TITLE:C213("Hole Bild bei IMDb, noch offen "+String:C10(Size of array:C274(image1)))
			$url:=image1{$i}
			  //$pos:=Position("._V1._";$url)
			  //If ($pos>0)
			  //$url:=Substring($url;1;$pos)
			  //$url:=$url+"_V1_SX650_SY650_.jpg"
			  //End if 
			  // Movie_Internet_Download_Picture ($FID;$url)
			C_PICTURE:C286($dummy)
			  //Tools_HTTP_Download ("Picture";->$dummy;$url)
			$status:=HTTP Get:C1157($url;$dummy)
			APPEND TO ARRAY:C911(Bild_Image;$dummy)
			APPEND TO ARRAY:C911(Bild_Url;image1{$i})
		End if 
		
		DELETE FROM ARRAY:C228(image1;1)
		
		If (Size of array:C274(image1)=0)
			SET TIMER:C645(0)
			SET WINDOW TITLE:C213("Alle Bilder geladen")
			
		End if 
End case 