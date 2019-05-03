//%attributes = {}
  // aktualisiert choice list

ARRAY TEXT:C222($gen1;0)
ARRAY TEXT:C222($gen2;0)

ALL RECORDS:C47([Filme:1])
DISTINCT VALUES:C339([Filme:1]Genre1:5;$gen1)
DISTINCT VALUES:C339([Filme:1]Genre2:6;$gen2)

For ($i;1;Size of array:C274($gen2))
	$pos:=Find in array:C230($gen1;$gen2{$i})
	If ($pos<0)
		APPEND TO ARRAY:C911($gen1;$gen2{$i})
	End if 
End for 
SORT ARRAY:C229($gen1;>)
If ($gen1{1}="")
	DELETE FROM ARRAY:C228($gen1;1)
End if 
ARRAY TO LIST:C287($gen1;"Genre")
