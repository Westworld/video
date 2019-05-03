//%attributes = {}
ALL RECORDS:C47([Parameter:5])
<>Kodi:=[Parameter:5]Kodi:10
<>KodiPort:=8080
$P:=Progress New   // Neuen Balken erstellen


If (False:C215)
	$id:=780
	CREATE RECORD:C68([Filme:1])
End if 

$id:=$1

ASSERT:C1129([Filme:1]Kodi_ID:31=$id;"Originaltitel muss bereits ausgewählt sein!")

  // create Kodi request
C_OBJECT:C1216($therequest;$params)
OB SET:C1220($therequest;"jsonrpc";"2.0";"method";"VideoLibrary.GetMovieDetails";"id";1)
ARRAY TEXT:C222($prop;0)
APPEND TO ARRAY:C911($prop;"title")
APPEND TO ARRAY:C911($prop;"imdbnumber")
APPEND TO ARRAY:C911($prop;"originaltitle")
APPEND TO ARRAY:C911($prop;"file")
APPEND TO ARRAY:C911($prop;"tag")
APPEND TO ARRAY:C911($prop;"votes")
APPEND TO ARRAY:C911($prop;"rating")
APPEND TO ARRAY:C911($prop;"genre")
  //APPEND TO ARRAY($prop;"director")
  //APPEND TO ARRAY($prop;"cast")
APPEND TO ARRAY:C911($prop;"country")
APPEND TO ARRAY:C911($prop;"runtime")
APPEND TO ARRAY:C911($prop;"dateadded")
APPEND TO ARRAY:C911($prop;"art")
APPEND TO ARRAY:C911($prop;"fanart")
APPEND TO ARRAY:C911($prop;"sorttitle")
APPEND TO ARRAY:C911($prop;"year")
APPEND TO ARRAY:C911($prop;"plot")
APPEND TO ARRAY:C911($prop;"streamdetails")
OB SET ARRAY:C1227($params;"properties";$prop)
OB SET:C1220($params;"movieid";$id)
OB SET:C1220($therequest;"params";$params)

$httprequest:="http://"+<>Kodi+":"+String:C10(<>KodiPort)+"/jsonrpc?VideoLibrary.GetMovieDetails"
C_OBJECT:C1216($answer)

If (True:C214)
	APPEND TO ARRAY:C911($HeaderNames_at;"Content-Type")
	APPEND TO ARRAY:C911($HeaderValues_at;"application/json")
	$result:=HTTP Request:C1158(HTTP POST method:K71:2;$httprequest;$therequest;$answer;$HeaderNames_at;$HeaderValues_at)
Else 
	$port:=9090
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
	$object_result:=OB Get:C1224($answer;"result")
	$newmovie:=OB Get:C1224($object_result;"moviedetails")
	
	$imdb:=OB Get:C1224($newmovie;"imdbnumber")
	If ($imdb#"")
		If ($imdb="tt@")
			$imdb:=Substring:C12($imdb;3)
		End if 
		If ([Filme:1]imdb:15="")
			[Filme:1]imdb:15:=$imdb
		Else 
			ASSERT:C1129($imdb=[Filme:1]imdb:15;"IMDB Unterschiedlich")
		End if 
	End if 
	
	If ([Filme:1]DtTitel:9="")
		[Filme:1]DtTitel:9:=OB Get:C1224($newmovie;"title")
	End if 
	If ([Filme:1]EnTitel:2="")
		[Filme:1]EnTitel:2:=OB Get:C1224($newmovie;"originaltitle")
	End if 
	[Filme:1]MKV_Pfad:22:=OB Get:C1224($newmovie;"file")
	[Filme:1]MKV_Pfad2:8:=""
	
	If ([Filme:1]Land:3="")
		$landstr:=OB Get:C1224($newmovie;"country";Is text:K8:3)
		  //$landstr:=JSON Stringify($land)
		[Filme:1]Land:3:=$landstr
	End if 
	If (([Filme:1]Länge:10<1) | ([Filme:1]Länge:10>1000))
		[Filme:1]Länge:10:=OB Get:C1224($newmovie;"runtime")/60
	End if 
	If ([Filme:1]purchasedate:20=!00-00-00!)
		  //$thedate:=
		[Filme:1]purchasedate:20:=OB Get:C1224($newmovie;"dateadded";Is date:K8:7)
	End if 
	If ([Filme:1]Titel_Sort:32="")
		[Filme:1]Titel_Sort:32:=OB Get:C1224($newmovie;"sorttitle")
		If ([Filme:1]Titel_Sort:32="")
			[Filme:1]Titel_Sort:32:=[Filme:1]DtTitel:9
		End if 
	End if 
	If ([Filme:1]Jahr:4="")
		[Filme:1]Jahr:4:=String:C10(OB Get:C1224($newmovie;"year"))
	End if 
	If ([Filme:1]Inhalt:7="")
		[Filme:1]Inhalt:7:=OB Get:C1224($newmovie;"plot")
	End if 
	
	  //streamdetails
	C_OBJECT:C1216($streamdetails)
	$streamdetails:=OB Get:C1224($newmovie;"streamdetails")
	C_REAL:C285($vwidth;$vheight)
	C_REAL:C285($achannel)
	C_TEXT:C284($acodec)
	
	ARRAY OBJECT:C1221($stream_audio;0)
	ARRAY OBJECT:C1221($stream_video;0)
	OB GET ARRAY:C1229($streamdetails;"audio";$stream_audio)
	OB GET ARRAY:C1229($streamdetails;"video";$stream_video)
	$stream:=""
	For ($i;1;Size of array:C274($stream_video))
		$vwidth:=OB Get:C1224($stream_video{$i};"width")
		$vheight:=OB Get:C1224($stream_video{$i};"height")
		$vcodec:=OB Get:C1224($stream_video{$i};"codec")
		$vaspect:=OB Get:C1224($stream_video{$i};"aspect")
		$video:=String:C10($vwidth)+"/"+String:C10($vheight)+" "+$vcodec+" "+String:C10(Round:C94($vaspect;2))+Char:C90(13)
		$stream:=$stream+$video
	End for 
	For ($i;1;Size of array:C274($stream_audio))
		$achannel:=OB Get:C1224($stream_audio{$i};"channels")
		$acodec:=OB Get:C1224($stream_audio{$i};"codec")
		$alanguage:=OB Get:C1224($stream_audio{$i};"language")
		$audio:=$alanguage+" "+$acodec+" Channels: "+String:C10($achannel)+Char:C90(13)
		$stream:=$stream+$audio
	End for 
	[Filme:1]streamdetails:35:=$stream
	
	$genreobject:=OB Get:C1224($newmovie;"genre";Is text:K8:3)
	ARRAY TEXT:C222($arr_genre;0)
	Tools_SplitTextTTR (->$arr_genre;$genreobject;Character code:C91(",");13)
	If (([Filme:1]Genre1:5="") & ([Filme:1]Genre2:6=""))
		If (Size of array:C274($arr_genre)>0)
			[Filme:1]Genre1:5:=$arr_genre{1}
			If (Size of array:C274($arr_genre)>1)
				[Filme:1]Genre2:6:=$arr_genre{2}
			End if 
		End if 
	End if 
	
	If (Picture size:C356([Filme:1]Bild:14)<5000)
		C_OBJECT:C1216($art)
		$art:=OB Get:C1224($newmovie;"art";Is object:K8:27)
		If (OB Is defined:C1231($art))
			$poster:=OB Get:C1224($art;"poster";Is text:K8:3)
		Else 
			$poster:=OB Get:C1224($newmovie;"art";Is text:K8:3)
		End if 
		$poster:=OB Get:C1224($art;"poster";Is text:K8:3)
		If ($poster#"")
			CLEAR VARIABLE:C89($bild)
			C_PICTURE:C286($bild)
			$bild:=KodiGetVideo_Poster ($poster)
			If (Picture size:C356($bild)#0)
				[Filme:1]Bild:14:=$bild
			End if 
		End if 
	End if 
	If (Picture size:C356([Filme:1]Fanart:26)<5000)
		C_OBJECT:C1216($art)
		$art:=OB Get:C1224($newmovie;"fanart";Is object:K8:27)
		If (OB Is defined:C1231($art))
			$poster:=OB Get:C1224($art;"poster";Is text:K8:3)
		Else 
			$poster:=OB Get:C1224($newmovie;"fanart";Is text:K8:3)
		End if 
		If ($poster#"")
			CLEAR VARIABLE:C89($bild)
			C_PICTURE:C286($bild)
			$bild:=KodiGetVideo_Poster ($poster)
			If (Picture size:C356($bild)#0)
				[Filme:1]Fanart:26:=$bild
			End if 
		End if 
	End if 
	
	SAVE RECORD:C53([Filme:1])
	MovieDBGetCastForMovie ([Filme:1]imdb:15;[Filme:1]FID:1)
	Movie_Internet_imdb_Bilder ([Filme:1]FID:1;[Filme:1]imdb:15)
	
Else 
	ALERT:C41("Http Error Get Movie: "+String:C10($result))
	TRACE:C157
	
End if 

Progress QUIT (0)
