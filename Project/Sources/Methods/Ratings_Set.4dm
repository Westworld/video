//%attributes = {}
  // Ratings_Set(SubformObjectName;Option;Name)
  // Option=cancel-off - cancel-on - star-on - star-off   - !!! case sensitive
  // option=Draw;Name=Number of stars
  // Option=Set;Name=0-1-2-3-4-5

C_OBJECT:C1216($mydata)
C_POINTER:C301($ptr)
C_LONGINT:C283($count;$value;$i)
C_PICTURE:C286($pictvar)
C_TEXT:C284($pict)


If (Count parameters:C259>3)  // in subform context
	$mydata:=$4
Else   // outside
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;$1)
	$mydata:=$ptr->
End if 

Case of 
	: ($2="drawsub")
		$count:=Num:C11($3)
		OB SET:C1220($mydata;"Count";$count)
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"CancelPict")
		OBJECT SET VISIBLE:C603(*;"CancelPict";True:C214)
		$pict:=OB Get:C1224($mydata;"cancel-off")
		READ PICTURE FILE:C678($pict;$pictvar)
		$ptr->:=$pictvar
		
		C_POINTER:C301($nilptr)
		$pict:=OB Get:C1224($mydata;"star-off")
		READ PICTURE FILE:C678($pict;$pictvar)
		For ($i;1;$count)
			OBJECT DUPLICATE:C1111(*;"CancelPict";"Star"+String:C10($i);$nilptr;"";(16+4)*$i;0)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Star"+String:C10($i))
			$ptr->:=$pictvar
		End for 
		
	: ($2="draw")
		EXECUTE METHOD IN SUBFORM:C1085($1;"Ratings_Set";*;$1;"drawsub";$3;$mydata)
		
	: ($2="Get")
		$value:=OB Get:C1224($mydata;"value";Is real:K8:4)
		$0:=$value
		
	: ($2="Set")
		EXECUTE METHOD IN SUBFORM:C1085($1;"Ratings_Set";*;$1;"setdraw";$3;$mydata)
		
	: ($2="setdraw")
		$value:=Num:C11($3)
		OB SET:C1220($mydata;"value";$value)
		$count:=OB Get:C1224($mydata;"Count";Is real:K8:4)
		If ($value=0)
			$pict:=OB Get:C1224($mydata;"cancel-off")
			READ PICTURE FILE:C678($pict;$pictvar)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"CancelPict")
			$ptr->:=$pictvar
			
			$pict:=OB Get:C1224($mydata;"star-off")
			READ PICTURE FILE:C678($pict;$pictvar)
			For ($i;1;$count)
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Star"+String:C10($i))
				$ptr->:=$pictvar
			End for 
		Else 
			
			$pict:=OB Get:C1224($mydata;"cancel-on")
			READ PICTURE FILE:C678($pict;$pictvar)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"CancelPict")
			$ptr->:=$pictvar
			
			$pict:=OB Get:C1224($mydata;"star-on")
			READ PICTURE FILE:C678($pict;$pictvar)
			For ($i;1;$value)
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Star"+String:C10($i))
				$ptr->:=$pictvar
			End for 
			
			$pict:=OB Get:C1224($mydata;"star-off")
			READ PICTURE FILE:C678($pict;$pictvar)
			For ($i;$value+1;$count)
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Star"+String:C10($i))
				$ptr->:=$pictvar
			End for 
			
		End if 
		CALL SUBFORM CONTAINER:C1086(On Data Change:K2:15)
		
	Else 
		If (Count parameters:C259>3)
			TRACE:C157  // should never go here
		Else 
			OB SET:C1220($mydata;$2;$3)
			$ptr->:=$mydata
		End if 
End case 
