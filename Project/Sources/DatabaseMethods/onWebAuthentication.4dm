<>HTML_Process:=False:C215
If (Undefined:C82(<>HTML_webart))
	ALL RECORDS:C47([Filme:1])
	ARRAY TEXT:C222(<>HTML_webart;0)
	DISTINCT VALUES:C339([Filme:1]Genre1:5;<>HTML_webart)
	DISTINCT VALUES:C339([Filme:1]Genre2:6;$art2)
	For ($i;1;Size of array:C274($art2))
		$pos:=Find in array:C230(<>HTML_webart;$art2{$i})
		If ($pos<0)
			APPEND TO ARRAY:C911(<>HTML_webart;$art2{$i})
		End if 
	End for 
	SORT ARRAY:C229(<>HTML_webart)
	If (<>HTML_webart{1}="")
		DELETE FROM ARRAY:C228(<>HTML_webart;1)
	End if 
End if 