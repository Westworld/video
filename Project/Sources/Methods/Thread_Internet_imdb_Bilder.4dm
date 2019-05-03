//%attributes = {}
C_LONGINT:C283($1;$2)
C_TEXT:C284($3)
$RufenderProzess:=$1
$FID:=$2
$IMDB_ID:=$3

QUERY:C277([Bilder:8];[Bilder:8]FID:1=[Filme:1]FID:1)
If (Records in selection:C76([Bilder:8])<4)
	Movie_Internet_imdb_Bilder ($FID;$IMDB_ID)
End if 

Repeat 
	$vlNbTasks:=Count tasks:C335
	$vlActualCount:=0
	For ($vlProcess;1;$vlNbTasks)
		If (Process state:C330($vlProcess)>=Executing:K13:4)
			PROCESS PROPERTIES:C336($vlProcess;$Name;$vlState;$vlTime)
			If ($name="Internet_download-Picture")
				$vlActualCount:=$vlActualCount+1
			End if 
		End if 
	End for 
Until ($vlActualCount=0)

Bildprozess:=0
SET PROCESS VARIABLE:C370($RufenderProzess;Bildprozess;Bildprozess)
<>Job:="Bild"
POST OUTSIDE CALL:C329($RufenderProzess)