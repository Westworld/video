//%attributes = {}
  // holt Teil der nächsten Filme
  // $1 = Anfang
  // $2 = pointer auf object array

If (Count parameters:C259>0)
	$start:=$1
Else 
	$start:=0
End if 

ARRAY OBJECT:C1221($2->;0)

C_OBJECT:C1216($therequest)
OB SET:C1220($therequest;"jsonrpc";"2.0";"method";"VideoLibrary.GetMovies";"id";1)
C_OBJECT:C1216($params;$limits;$sort)
OB SET:C1220($limits;"start";$start)
OB SET:C1220($limits;"end";200+$start)
OB SET:C1220($params;"limits";$limits)
ARRAY TEXT:C222($prop;0)
APPEND TO ARRAY:C911($prop;"title")
APPEND TO ARRAY:C911($prop;"imdbnumber")
APPEND TO ARRAY:C911($prop;"originaltitle")
APPEND TO ARRAY:C911($prop;"year")
APPEND TO ARRAY:C911($prop;"streamdetails")
OB SET ARRAY:C1227($params;"properties";$prop)
OB SET:C1220($sort;"method";"sorttitle";"ignorearticle";True:C214)
OB SET:C1220($params;"sort";$sort)

OB SET:C1220($therequest;"params";$params)

$httprequest:="http://"+<>Kodi+":"+String:C10(<>KodiPort)+"/jsonrpc?VideoLibrary.GetMovies"
C_OBJECT:C1216($answer;$kodiresult)

If (True:C214)
	ARRAY TEXT:C222($HeaderNames_at;0)
	ARRAY TEXT:C222($HeaderValues_at;0)
	APPEND TO ARRAY:C911($HeaderNames_at;"Content-Type")
	APPEND TO ARRAY:C911($HeaderValues_at;"application/json")
	$result:=HTTP Request:C1158(HTTP POST method:K71:2;$httprequest;$therequest;$answer;$HeaderNames_at;$HeaderValues_at)
	If ($result=200)
		C_OBJECT:C1216($kodiresult)
		$kodiresult:=OB Get:C1224($answer;"result")
		OB GET ARRAY:C1229($kodiresult;"movies";$2->)
	End if 
Else 
	  // raw communication
	$port:=9090
	$errorcounter:=0
	$error:=TCP_Open (<>Kodi;$port;<>KodiRaw;0)
	If ($error=10064)
		While (($error=10064) & ($errorcounter<4))
			$errorcounter:=$errorcounter+1
			MESSAGE:C88("Kodi Fehler 10064, Versuch: "+String:C10($errorcounter))
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
			C_OBJECT:C1216($kodiresult)
			$kodiresult:=OB Get:C1224($answer;"result")
			OB GET ARRAY:C1229($kodiresult;"movies";$2->)
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
		Repeat 
			DELAY PROCESS:C323(Current process:C322;60)
			$err:=TCP_ReceiveBLOB (<>KodiRaw;$buffer)
			If (BLOB size:C605($buffer)#0)
				COPY BLOB:C558($buffer;$answerblob;0;BLOB size:C605($answerblob);BLOB size:C605($buffer))
			End if 
		Until (BLOB size:C605($buffer)=0)
		$error:=TCP_Close (<>KodiRaw)
		<>KodiRaw:=0
		$answertext:=Convert to text:C1012($answerblob;"UTF-8")
	End if 
	
	
	If ($answertext#"")
		$answer:=JSON Parse:C1218($answertext)
		$kodiresult:=OB Get:C1224($answer;"result")
		OB GET ARRAY:C1229($kodiresult;"movies";$2->)
	End if 
End if 



