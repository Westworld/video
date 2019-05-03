//%attributes = {}
  // übergibt Bild als skaliertes Blob/Jpg
  // $1 = bild
  // $2 = max größe (Breite oder höhe)

$bild:=$1
PICTURE PROPERTIES:C457($bild;$breit;$hoch)

$faktor:=100
If ($breit>$hoch)  // quer
	If ($breit>$2)  // passt nicht
		$faktor:=$2/$breit
	End if 
Else   // hochkant
	If ($hoch>$2)  // passt nicht
		$faktor:=$2/$hoch
	End if 
End if 
Case of 
	: ($faktor>100)
		
	: ($faktor=100)
		  // nichts!
		
	Else 
		TRANSFORM PICTURE:C988($bild;Scale:K61:2;$faktor;$faktor)
		PICTURE PROPERTIES:C457($bild;$breit;$hoch)
		TRANSFORM PICTURE:C988($bild;Crop:K61:7;0;0;$breit;$hoch)
		  //CONVERT PICTURE($bild;".JPG";0.6)
End case 

$0:=$bild