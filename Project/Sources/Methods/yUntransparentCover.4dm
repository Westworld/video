//%attributes = {}
ALL RECORDS:C47([Filme:1])
GET PICTURE FROM LIBRARY:C565("weiss";$weiss)
TRANSFORM PICTURE:C988($weiss;Scale:K61:2;10;10)
While (Not:C34(End selection:C36([Filme:1])))
	If (Picture size:C356([Filme:1]Bild:14)#0)
		
		$pict:=[Filme:1]Bild:14
		PICTURE PROPERTIES:C457($pict;$breit;$hoch)
		COMBINE PICTURES:C987($pict2;$weiss;Superimposition:K61:10;$pict;0;0)
		TRANSFORM PICTURE:C988($pict2;Crop:K61:7;0;0;$breit;$hoch)
		[Filme:1]Bild:14:=$pict2
		SAVE RECORD:C53([Filme:1])
		  //SET PICTURE TO PASTEBOARD($pict)
	End if 
	NEXT RECORD:C51([Filme:1])
End while 
