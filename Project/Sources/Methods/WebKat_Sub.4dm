//%attributes = {}
$para:=$1
$para:=Replace string:C233($para;".html";"")
ALL RECORDS:C47([Filme:1])
Web_SelectMedia ($para)

ARRAY TEXT:C222(webart;0)
DISTINCT VALUES:C339([Filme:1]Genre1:5;webart)
DISTINCT VALUES:C339([Filme:1]Genre2:6;$art2)
For ($i;1;Size of array:C274($art2))
	$pos:=Find in array:C230(webart;$art2{$i})
	If ($pos<0)
		APPEND TO ARRAY:C911(webart;$art2{$i})
	End if 
End for 
SORT ARRAY:C229(webart)

If (Size of array:C274(webart)>0)
	If (webart{1}="")
		DELETE FROM ARRAY:C228(webart;1)
	End if 
	ARRAY TEXT:C222(weburl;Size of array:C274(webart))
	For ($i;1;Size of array:C274(webart))
		If (<>HTML_Process)
			$id:=Find in array:C230(<>HTML_webart;webart{$i})
			weburl{$i}:=String:C10($id)+".html"
		Else 
			weburl{$i}:=webart{$i}+".html"
		End if 
	End for 
End if 
webkattyp:=$para
