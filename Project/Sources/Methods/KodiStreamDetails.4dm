//%attributes = {}
  //streamdetails

$newmovie:=$1

C_OBJECT:C1216($streamdetails)
$streamdetails:=OB Get:C1224($newmovie;"streamdetails")
ARRAY OBJECT:C1221($stream_audio;0)
ARRAY OBJECT:C1221($stream_video;0)
OB GET ARRAY:C1229($streamdetails;"audio";$stream_audio)
OB GET ARRAY:C1229($streamdetails;"video";$stream_video)
$stream:=""
C_REAL:C285($vwidth;$vheight)
For ($i;1;Size of array:C274($stream_video))
	$vwidth:=OB Get:C1224($stream_video{$i};"width")
	$vheight:=OB Get:C1224($stream_video{$i};"height")
	$vcodec:=OB Get:C1224($stream_video{$i};"codec")
	$vaspect:=OB Get:C1224($stream_video{$i};"aspect")
	$video:=String:C10($vwidth)+"/"+String:C10($vheight)+" "+$vcodec+" "+String:C10(Round:C94($vaspect;2))+Char:C90(13)
	$stream:=$stream+$video
End for 
C_REAL:C285($achannel)
C_TEXT:C284($acodec)
For ($i;1;Size of array:C274($stream_audio))
	$achannel:=OB Get:C1224($stream_audio{$i};"channels")
	$acodec:=OB Get:C1224($stream_audio{$i};"codec")
	$alanguage:=OB Get:C1224($stream_audio{$i};"language")
	$audio:=$alanguage+" "+$acodec+" Channels: "+String:C10($achannel)+Char:C90(13)
	$stream:=$stream+$audio
End for 
If (Length:C16($stream)>5)
	If ([Filme:1]streamdetails:35#$stream)
		[Filme:1]streamdetails:35:=$stream
		SAVE RECORD:C53([Filme:1])
	End if 
End if 