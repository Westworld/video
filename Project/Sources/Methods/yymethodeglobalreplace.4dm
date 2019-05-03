//%attributes = {}
ARRAY TEXT:C222($arrPaths;0)
METHOD GET PATHS:C1163(Path all objects:K72:16;$arrPaths)
For ($i;1;Size of array:C274($arrPaths))
	C_TEXT:C284($tVcode)
	METHOD GET CODE:C1190($arrPaths{$i};$tVcode)
	If (Position:C15("[Personen_alt]";$tVcode)>0)
		$new:=Replace string:C233($tVcode;"[Personen_alt]";"[Personen]")
		METHOD SET CODE:C1194($arrPaths{$i};$new)
	End if 
End for 
