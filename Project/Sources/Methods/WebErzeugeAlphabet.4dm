//%attributes = {"publishedWeb":true}
If (<>HTML_Process)
	$link:="../../4DAction/WebZeigeAlpha/"+webkattyp+"/"
Else 
	$link:="/4DAction/WebZeigeAlpha/"+webkattyp+"/"
End if 

$html:=""

For ($i;1;26)
	If (<>HTML_Process)
		$html:=$html+"<a href=\""+$link+Char:C90(64+$i)+".html\">"+Char:C90(64+$i)+"</a> "
	Else 
		$html:=$html+"<a href=\""+$link+Char:C90(64+$i)+"\">"+Char:C90(64+$i)+"</a> "
	End if 
End for 
If (<>HTML_Process)
	$html:=$html+"<a href=\""+$link+"0.html"+"\">0-9</a> "
Else 
	$html:=$html+"<a href=\""+$link+"0"+"\">0-9</a> "
End if 

$0:=$html