//%attributes = {}
  // läuft durch alle Filme und aktualisiert Streamdetails

ALL RECORDS:C47([Parameter:5])
<>Kodi:=[Parameter:5]Kodi:10
<>KodiPort:=8080
Progress QUIT (0)

QUERY:C277([Filme:1];[Filme:1]Kodi_ID:31#0)
$P:=Progress New   // Neuen Balken erstellen
$ablauf:=0
$max:=Records in selection:C76([Filme:1])

While (Not:C34(End selection:C36([Filme:1])))
	$ablauf:=$ablauf+1
	$progress:=$ablauf/$max
	Progress SET TITLE ($P;"Kodi UpdateStream";$progress;[Filme:1]DtTitel:9;True:C214)
	
	  // create Kodi request
	CLEAR VARIABLE:C89($therequest)
	CLEAR VARIABLE:C89($params)
	C_OBJECT:C1216($therequest;$params)
	OB SET:C1220($therequest;"jsonrpc";"2.0";"method";"VideoLibrary.GetMovieDetails";"id";1)
	ARRAY TEXT:C222($prop;0)
	APPEND TO ARRAY:C911($prop;"title")
	APPEND TO ARRAY:C911($prop;"imdbnumber")
	APPEND TO ARRAY:C911($prop;"streamdetails")
	OB SET ARRAY:C1227($params;"properties";$prop)
	OB SET:C1220($params;"movieid";[Filme:1]Kodi_ID:31)
	OB SET:C1220($therequest;"params";$params)
	
	$httprequest:="http://"+<>Kodi+":"+String:C10(<>KodiPort)+"/jsonrpc?VideoLibrary.GetMovieDetails"
	CLEAR VARIABLE:C89($answer)
	C_OBJECT:C1216($answer)
	
	If (False:C215)
		APPEND TO ARRAY:C911($HeaderNames_at;"Content-Type")
		APPEND TO ARRAY:C911($HeaderValues_at;"application/json")
		$result:=HTTP Request:C1158(HTTP POST method:K71:2;$httprequest;$therequest;$answer;$HeaderNames_at;$HeaderValues_at)
	Else 
		$port:=<>KodiPort
		$errorcounter:=0
		$error:=TCP_Open (<>Kodi;$port;<>KodiRaw;0)
		If ($error=10064)
			While (($error=10064) & ($errorcounter<5))
				$errorcounter:=$errorcounter+1
				Progress SET TITLE ($P;"Kodi Fehler 10064";-1;"Versuch: "+String:C10($errorcounter);True:C214)
				  //Progress SET PROGRESS ($P;-1;"Kodi Fehler 10064, Versuch: "+String($errorcounter))
				
				DELAY PROCESS:C323(Current process:C322;180)
				$error:=TCP_Open (<>Kodi;$port;<>KodiRaw;0)
			End while 
		End if 
		
		If ($error#0)
			ARRAY TEXT:C222($HeaderNames_at;0)
			ARRAY TEXT:C222($HeaderValues_at;0)
			APPEND TO ARRAY:C911($HeaderNames_at;"Content-Type")
			APPEND TO ARRAY:C911($HeaderValues_at;"application/json")
			$result:=HTTP Request:C1158(HTTP POST method:K71:2;$httprequest;$therequest;$answer;$HeaderNames_at;$HeaderValues_at)
			If ($result=200)
				  // nichts
				<>KodiRaw:=0
			Else 
				ALERT:C41("Raw und HTTP failed")
				TRACE:C157
			End if 
			
		End if 
		
		If (<>KodiRaw#0)
			C_TEXT:C284($rawtext)
			$rawtext:=JSON Stringify:C1217($therequest)
			$err:=TCP_Send (<>KodiRaw;$rawtext)
			C_BLOB:C604($answerblob;$buffer)
			SET BLOB SIZE:C606($buffer;0)
			SET BLOB SIZE:C606($answerblob;0)
			Repeat 
				DELAY PROCESS:C323(Current process:C322;10)
				$err:=TCP_ReceiveBLOB (<>KodiRaw;$buffer)
				If (BLOB size:C605($buffer)#0)
					COPY BLOB:C558($buffer;$answerblob;0;BLOB size:C605($answerblob);BLOB size:C605($buffer))
				End if 
			Until (BLOB size:C605($buffer)=0)
			$error:=TCP_Close (<>KodiRaw)
			<>KodiRaw:=0
			$answertext:=Convert to text:C1012($answerblob;"UTF-8")
			If ($answertext#"")
				$answer:=JSON Parse:C1218($answertext)
				$result:=200
			Else 
				$result:=0
			End if 
		End if 
	End if 
	
	If ($result=200)
		$object_result:=OB Get:C1224($answer;"error";Is object:K8:27)
		If (Undefined:C82($object_result))
			TRACE:C157
		End if 
		
		$object_result:=OB Get:C1224($answer;"result")
		
		$newmovie:=OB Get:C1224($object_result;"moviedetails")
		
		$imdb:=OB Get:C1224($newmovie;"imdbnumber")
		If ($imdb#"")
			If ($imdb="tt@")
				$imdb:=Substring:C12($imdb;3)
			End if 
			ASSERT:C1129($imdb=[Filme:1]imdb:15;"IMDB Unterschiedlich")
		End if 
		
		KodiStreamDetails ($newmovie)
		  //streamdetails
		  //C_OBJECT($streamdetails)
		  //$streamdetails:=OB Get($newmovie;"streamdetails")
		  //ARRAY OBJECT($stream_audio;0)
		  //ARRAY OBJECT($stream_video;0)
		  //OB GET ARRAY($streamdetails;"audio";$stream_audio)
		  //OB GET ARRAY($streamdetails;"video";$stream_video)
		  //$stream:=""
		  //For ($i;1;Size of array($stream_video))
		  //$vwidth:=OB Get($stream_video{$i};"width")
		  //$vheight:=OB Get($stream_video{$i};"height")
		  //$vcodec:=OB Get($stream_video{$i};"codec")
		  //$vaspect:=OB Get($stream_video{$i};"aspect")
		  //$video:=String($vwidth)+"/"+String($vheight)+" "+$vcodec+" "+String(Round($vaspect;2))+Char(13)
		  //$stream:=$stream+$video
		  //End for 
		  //For ($i;1;Size of array($stream_audio))
		  //$achannel:=OB Get($stream_audio{$i};"channels")
		  //$acodec:=OB Get($stream_audio{$i};"codec")
		  //$alanguage:=OB Get($stream_audio{$i};"language")
		  //$audio:=$alanguage+" "+$vcodec+" Channels: "+String($achannel)+Char(13)
		  //$stream:=$stream+$audio
		  //End for 
		  //If (Length($stream)>5)
		  //If ([Originaltitel]streamdetails#$stream)
		  //[Originaltitel]streamdetails:=$stream
		  //SAVE RECORD([Originaltitel])
		  //End if 
		  //End if 
		
	End if 
	
	
	NEXT RECORD:C51([Filme:1])
End while 

Progress QUIT ($P)