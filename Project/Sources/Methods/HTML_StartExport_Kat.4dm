//%attributes = {}
$kat:=$1
$katfolder:=$2

C_TEXT:C284($process_in;$process_out)

<>HTML_Process:=True:C214
WebKat_Sub ($kat)
$process_in:=g_ReadFileIn (html_quellordner+"Kategorie.html")
  //DOCUMENT TO BLOB(html_quellordner+"Kategorie.html";$blobin)
PROCESS 4D TAGS:C816($process_in;$process_out)
  //BLOB TO DOCUMENT($katfolder+$kat+".html";$blobout)
g_WriteFileOut ($katfolder+$kat+".html";$process_out)

$dir:=Folder separator:K24:12
$ZeigeKatfolder:=html_mainfolder+$dir+"WebZeigeKat"
CREATE FOLDER:C475($ZeigeKatfolder)
$ZeigeKatfolder:=html_mainfolder+$dir+"WebZeigeKat"+$dir+$kat+$dir
CREATE FOLDER:C475($ZeigeKatfolder)

$ZeigeAlphafolder:=html_mainfolder+$dir+"WebZeigeAlpha"
CREATE FOLDER:C475($ZeigeAlphafolder)
$ZeigeAlphafolder:=html_mainfolder+$dir+"WebZeigeAlpha"+$dir+$kat+$dir
CREATE FOLDER:C475($ZeigeAlphafolder)
  //DOCUMENT TO BLOB(html_quellordner+"Filmliste.html";$blobin)

$process_in:=g_ReadFileIn (html_quellordner+"Filmliste.html")

  // zuerst Kategorien, dann alphabet
For ($i;1;Size of array:C274(webart))
	QUERY:C277([Filme:1];[Filme:1]Genre1:5=webart{$i};*)
	QUERY:C277([Filme:1]; | [Filme:1]Genre2:6=webart{$i})
	Web_SelectMedia ($kat)
	
	CREATE SET:C116([Filme:1];"s")
	UNION:C120("s";"Filme";"Filme")
	
	ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)
	webkattyp:=webart{$i}  // $kat
	
	Web_FilmBildCounter:=1  // als Counter links, rechts
	PROCESS 4D TAGS:C816($process_in;$process_out)
	$id:=Find in array:C230(<>HTML_webart;webart{$i})
	$pfad:=$ZeigeKatfolder+String:C10($id)+".html"
	  //BLOB TO DOCUMENT($pfad;$blobout)
	g_WriteFileOut ($pfad;$process_out)
	
End for 

For ($i;0;26)  // alphabet + 0
	If ($i=0)
		QUERY:C277([Filme:1];[Filme:1]DtTitel:9<"A";*)
		QUERY:C277([Filme:1]; | [Filme:1]DtTitel:9>"ZZZZZ")
		webkattyp:="0"
	Else 
		QUERY:C277([Filme:1];[Filme:1]DtTitel:9=(Char:C90($i+64)+"@"))
		webkattyp:=Char:C90($i+64)
	End if 
	Web_SelectMedia ($kat)
	
	  // set erweitern
	CREATE SET:C116([Filme:1];"s")
	UNION:C120("s";"Filme";"Filme")
	
	ORDER BY:C49([Filme:1];[Filme:1]DtTitel:9;>)
	
	Web_FilmBildCounter:=1  // als Counter links, rechts
	PROCESS 4D TAGS:C816($process_in;$process_out)
	If ($i=0)
		$pfad:=$ZeigeAlphafolder+"0.html"
	Else 
		$pfad:=$ZeigeAlphafolder+Char:C90($i+64)+".html"
	End if 
	  //BLOB TO DOCUMENT($pfad;$blobout)
	g_WriteFileOut ($pfad;$process_out)
End for 

