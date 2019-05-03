Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222($text;0)
		LIST TO ARRAY:C288("Merkmal";$text)
		ARRAY BOOLEAN:C223($booL;Size of array:C274($text))
		
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"arr1")
		COPY ARRAY:C226($bool;$ptr->)
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"arr2")
		COPY ARRAY:C226($text;$ptr->)
		
	: (Form event:C388=On Clicked:K2:4)
		$ptr2:=OBJECT Get pointer:C1124(Object named:K67:5;"arr2")
		$zeile:=$ptr2->
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"arr1")
		If ($ptr->{$zeile})
			$ptr->{$zeile}:=False:C215
		Else 
			$ptr->{$zeile}:=True:C214
		End if 
		
		$text2:=""
		For ($i;1;Size of array:C274($ptr->))
			If ($ptr->{$i})
				$text2:=$text2+$ptr2->{$i}+";"
			End if 
		End for 
		ProcessSetMerkmal:=$text2
		POST OUTSIDE CALL:C329(Current process:C322)
		
		
	: (Form event:C388=On Data Change:K2:15)
		$ptr2:=OBJECT Get pointer:C1124(Object named:K67:5;"arr2")
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"arr1")
		
		$text2:=""
		For ($i;1;Size of array:C274($ptr->))
			If ($ptr->{$i})
				$text2:=$text2+$ptr2->{$i}+";"
			End if 
		End for 
		ProcessSetMerkmal:=$text2
		POST OUTSIDE CALL:C329(Current process:C322)
End case 