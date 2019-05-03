//%attributes = {}
  // wird als neuer Prozeß zum herunterladen von Bildern aufgerufen


  //$1 = FID

  // $2 = Bildpfad


C_LONGINT:C283($1;$Fid)
C_TEXT:C284($2;$Bildpfad)

$FID:=$1
$Bildpfad:=$2

QUERY:C277([Bilder:8];[Bilder:8]FID:1=$FID)
ORDER BY:C49([Bilder:8];[Bilder:8]SubID:2;<)
$SubID:=[Bilder:8]SubID:2+1
  //If ($SubID<200)   // verstehe ich nicht, 160710
  //$SubID:=200
  //End if 

CREATE RECORD:C68([Bilder:8])
[Bilder:8]FID:1:=$FID
[Bilder:8]SubID:2:=$subID

$status:=HTTP Get:C1157($Bildpfad;$Dummy)
  // Tools_HTTP_Download ("Picture";->$dummy;$Bildpfad)
If (Picture size:C356($dummy)>0)
	[Bilder:8]dasbild:6:=$dummy
	SAVE RECORD:C53([Bilder:8])
Else 
	ALERT:C41("Fehler beim Bildladen: "+$Bildpfad)
End if 