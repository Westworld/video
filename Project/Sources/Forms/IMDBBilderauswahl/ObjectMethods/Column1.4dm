Case of 
	: (Form event:C388=On Clicked:K2:4)
		$indexpos:=Find in array:C230(mylistbox;True:C214)
		If ($indexpos>0)
			$FID:=Film_IMDB_ID
			QUERY:C277([Bilder:8];[Bilder:8]FID:1=$FID)
			ORDER BY:C49([Bilder:8];[Bilder:8]SubID:2;<)
			$SubID:=[Bilder:8]SubID:2+1
			  //If ($SubID<200)   // verstehe ich nicht, 160710
			  //$SubID:=200
			  //End if 
			
			CREATE RECORD:C68([Bilder:8])
			[Bilder:8]FID:1:=$FID
			[Bilder:8]SubID:2:=$subID
			
			$url:=Bild_Url{$indexpos}
			$pos:=Position:C15("._V1._";$url)
			If ($pos=0)
				$pos:=Position:C15("._V1_";$url)
			End if 
			If ($pos>0)
				$url:=Substring:C12($url;1;$pos)
				$url:=$url+"_V1_SX650_SY650_.jpg"
			End if 
			C_PICTURE:C286($dummy)
			  //Tools_HTTP_Download ("Picture";->$dummy;$url)
			$status:=HTTP Get:C1157($url;$dummy)
			
			If (Picture size:C356($dummy)>0)
				[Bilder:8]dasbild:6:=$dummy
				SAVE RECORD:C53([Bilder:8])
			Else 
				ALERT:C41("Fehler beim Bildladen: "+$Bildpfad)
			End if 
			DELETE FROM ARRAY:C228(Bild_Image;$indexpos)
			DELETE FROM ARRAY:C228(Bild_Url;$indexpos)
			
		End if 
		
End case 