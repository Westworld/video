//%attributes = {}
$kat:=$1
$katfolder:=$2

C_TEXT:C284($process_in;$process_out)

<>HTML_Process:=True:C214
QUERY:C277([Filme:1];[Filme:1]purchasedate:20#!00-00-00!)
ORDER BY:C49([Filme:1];[Filme:1]purchasedate:20;<)
REDUCE SELECTION:C351([Filme:1];20)

$process_in:=g_ReadFileIn (html_quellordner+"Filmliste.html")
  //DOCUMENT TO BLOB(html_quellordner+"Kategorie.html";$blobin)
Web_FilmBildCounter:=1
webkattyp:="Neue"
PROCESS 4D TAGS:C816($process_in;$process_out)
  //BLOB TO DOCUMENT($katfolder+$kat+".html";$blobout)
$ZeigeKatfolder:=html_mainfolder+Folder separator:K24:12+"WebZeigeKat"+Folder separator:K24:12+$kat+Folder separator:K24:12
CREATE FOLDER:C475($ZeigeKatfolder)

g_WriteFileOut ($ZeigeKatfolder+$kat+".html";$process_out)


