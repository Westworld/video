//%attributes = {}
  // sucht in imdb

  // if $1 = true (optional), dann auch gleich Daten suchen


If (Count parameters:C259>0)
	$DoDate:=$1
Else 
	$DoDate:=False:C215
End if 


SET WINDOW TITLE:C213("Suche ID bei OFDB")
If ([Filme:1]imdb:15="")
	If ([Filme:1]EnTitel:2#"")
		$titel:=Replace string:C233(_O_Mac to ISO:C519([Filme:1]EnTitel:2);" ";"%20")
		$url:="http://german.imdb.com/Tsearch?title="+$titel+"&restrict=Movies+and+TV&GO.x=13&GO.y=6"
		$result:=""
		$status:=HTTP Get:C1157($url;$result)
		  // $err:=Tools_HTTP_Download ("Text";->$result;$url)
	End if 
	$gefunden:="http://german.imdb.com/title?"
	
	  //  wenn url = gefunden, dann exakt 1 Treffer
	
	  // wenn blob enthält "Sorry there were no matches for the titel" -> nicht gefunden
	
	  // wenn The following titles matched   -> liste gefunden
	
	ALERT:C41("geht nicht, HTTP_LastURL fehlt noch")
	
	If (HTTP_LastURL=($gefunden+"@"))  // Film gefunden"
		
		[Filme:1]imdb:15:=Substring:C12(HTTP_LastURL;Length:C16($gefunden)+1)
		Movie_Internet_imdb_Daten ($result)
	Else 
		If (Position:C15("Es wurden keine entsprechenden Titel gefunden";$result)>0)
			  //nicht gefunden
			
			ALERT:C41("Film bei imdb nicht gefunden. Titel kürzen...")
			[Filme:1]imdb:15:="???"
		Else   // liste der Treffer auswerten
			
			ARRAY TEXT:C222(product;0)
			ARRAY TEXT:C222(product_ID;0)
			$schau:=HTTP_Parse ($result;"IMDB_Movie_list";->product_ID;->product)
			  // prüfen ob exakt 1 richtiger Treffer
			
			
			For ($i;1;Size of array:C274(product))
				product{$i}:=HTML2Mac (product{$i})
			End for 
			$pos:=Find in array:C230(Product;([Filme:1]EnTitel:2+" (@"))
			If ($pos>0)
				$pos2:=Find in array:C230(Product;([Filme:1]EnTitel:2+" (@");$pos+1)
				If ($pos2>0)
					$pos:=0
				End if 
			End if 
			
			Case of 
				: (Size of array:C274(product_ID)=0)  // keiner gefunden?
					
					ALERT:C41("Fehler, kein Film gefunden?")
					TRACE:C157
					BLOB TO DOCUMENT:C526("Debugblob.txt";$blob)
				: ($pos>0)  // exakt einer, Hit
					
					If (Size of array:C274(product_ID)>=$pos)  // else fehler beim Auslesen
						
						[Filme:1]imdb:15:=Product_ID{$pos}
						Movie_Internet_imdb_Daten 
					End if 
				Else   // mehrere
					
					$ref:=Open form window:C675("AmazonFilmauswahl")
					SET WINDOW TITLE:C213([Filme:1]EnTitel:2+" - "+[Filme:1]Jahr:4)
					Dialog_Content:="imdb"
					DIALOG:C40("AmazonFilmauswahl")
					Dialog_Content:=""
					CLOSE WINDOW:C154($ref)
					If (Product#0)
						[Filme:1]imdb:15:=Product_ID{Product}
						Movie_Internet_imdb_Daten 
					End if 
					
			End case 
		End if 
	End if 
End if 