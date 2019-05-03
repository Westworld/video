Case of 
	: (Form event:C388=On End URL Loading:K2:47)
		$url:=WA Get current URL:C1025(*;"mybrowser")
		
		<>pageContent:=WA Get page content:C1038(*;"mybrowser")
		
		  // now we can get the data out of the browser
		Case of 
			: (vNextJob="Find Movie")
				  //  ab Jan 2008
				  //  http://www.ofdb.de/film/95475,Wer-früher-stirbt-ist-länger-tot
				  // $find:="page=film&fid="   ` alt
				$find:="http://www.ofdb.de/film/"
				$pos:=Position:C15($find;$url)
				If ($pos>0)
					  // we did our job now, page found!
					$pos:=$pos+Length:C16($find)
					$fid:=Substring:C12($url;$pos)
					$pos:=Position:C15(",";$fid)
					$fid:=Substring:C12($fid;1;$pos-1)  //   291108, added -1, treffer war "70210," statt "70210"
					If ($fid#"")
						<>ResultFilmID:=$fid
						  //  <>Job:="Find Movie"
						<>Job:="Load OFDB Movie"  //  Nov2007, warum auf einmal so?
						POST OUTSIDE CALL:C329(<>Main)
						vNextJob:=""
					Else 
						ALERT:C41("Internal Error in "+Current method name:C684+" ID=1")
					End if 
				End if 
				
			: (vNextJob="Load OFDB Movie")
				<>Job:="Load OFDB Movie"
				POST OUTSIDE CALL:C329(<>Main)
				vNextJob:=""
				
			: (vNextJob="Load IMDB Movie")
				<>Job:="Load IMDB Movie"
				POST OUTSIDE CALL:C329(<>Main)
				vNextJob:=""
				
			: (vNextJob="Load Beschreibung")
				<>Job:="Load Beschreibung"
				POST OUTSIDE CALL:C329(<>Main)
				vNextJob:=""
				
			: (vNextJob="Load IMDB Person")
				<>Job:="Load IMDB Person"
				POST OUTSIDE CALL:C329(<>Main)
				vNextJob:=""
				
			: (vNextJob="AutoFind IMDB Person")
				If ($url="http://www.imdb.de/name/nm@")  // bereits richtige Seite offen?
					<>Job:="Find IMDB Person"
					$lang:=Length:C16("http://www.imdb.de/name/nm")
					<>pageContent:=Substring:C12($url;$lang-1)
					If (<>pageContent="@/")
						<>pageContent:=Substring:C12(<>pageContent;1;Length:C16(<>pageContent)-1)
					End if 
					POST OUTSIDE CALL:C329(<>Main)
					vNextJob:=""
				Else 
					If (<>pageContent="@Meistgesuchte Namen@")  // gibt es meistgesuchte?
						<>Job:="AutoFind IMDB Person"
						POST OUTSIDE CALL:C329(<>Main)
						vNextJob:=""
					Else 
						<>Job:="Cancel AutoFind IMDB Person"
						POST OUTSIDE CALL:C329(<>Main)
						vNextJob:=""
					End if 
					
				End if 
				
				
			: (vNextJob="Find IMDB Person")
				If ($url="http://www.imdb.de/name/nm@")
					<>Job:="Find IMDB Person"
					$lang:=Length:C16("http://www.imdb.de/name/nm")
					<>pageContent:=Substring:C12($url;$lang-1)
					If (<>pageContent="@/")
						<>pageContent:=Substring:C12(<>pageContent;1;Length:C16(<>pageContent)-1)
					End if 
					POST OUTSIDE CALL:C329(<>Main)
					vNextJob:=""
				Else 
					
				End if 
				
				
				
			Else 
				If (vNextJob#"")
					ALERT:C41("error, unknown vNextJob="+vNextJob)
				End if 
		End case 
		
		
End case 