//%attributes = {"invisible":true}
  // in this database iso to mac does not work anymore
  // why?

C_TEXT:C284($0;$1)
C_BLOB:C604(<>IsoToMacblob)
If (BLOB size:C605(<>IsoToMacblob)=0)
	DOCUMENT TO BLOB:C525("Isotomac.txt";<>IsoToMacblob)
End if 

If (BLOB size:C605(<>IsoToMacblob)#256)
	ALERT:C41("Fehlerhaftes blob")
Else 
	$0:=""
	For ($i;1;Length:C16($1))
		$char:=Character code:C91($1[[$i]])
		$0:=$0+Char:C90(<>IsoToMacblob{$char})
	End for 
End if 