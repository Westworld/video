//%attributes = {}
C_TEXT:C284($0)
  // übergibt verfügbare Sprache

$return:=""
If ([Filme:1]:12#"")
	$return:=$return+"Deutsch: "+[Filme:1]:12
End if 

If ([Filme:1]:18#"")
	If ($return#"")
		$return:=$return+"   "
	End if 
	$return:=$return+"Englisch: "+[Filme:1]:18
End if 

$0:=$return