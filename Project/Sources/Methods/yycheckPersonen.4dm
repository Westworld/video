//%attributes = {}
ARRAY LONGINT:C221($arrValue;0)
ARRAY LONGINT:C221($arrCount;0)

ALL RECORDS:C47([Personen:17])
DISTINCT VALUES:C339([Personen:17]MovieDB:12;$arrValue;$arrCount)

For ($i;2;Size of array:C274($arrCount))
	If ($arrCount{$i}>1)
		
		QUERY:C277([Personen:17];[Personen:17]MovieDB:12=$arrValue{$i})
		  //create set([Personen];"merken")
		$theid:=[Personen:17]PID:1
		$text:=[Personen:17]Kommentar:8
		$textorig:=$text
		NEXT RECORD:C51([Personen:17])
		
		Repeat 
			If ((Length:C16($text)<100) & (Length:C16([Personen:17]Kommentar:8)>Length:C16($text)))
				$text:=[Personen:17]Kommentar:8
			End if 
			$personenID:=[Personen:17]PID:1
			QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=$personenID)
			If (Records in selection:C76([Mitwirkende:3])>0)
				  //APPLY TO SELECTION([Mitwirkende];[Mitwirkende]PID:=$theid)  // veränder Auswahl
				ARRAY LONGINT:C221($number;Records in selection:C76([Mitwirkende:3]))
				For ($i2;1;Size of array:C274($number))
					$number{$i2}:=$theid
				End for 
				ARRAY TO SELECTION:C261($number;[Mitwirkende:3]PID:2)
			End if 
			NEXT RECORD:C51([Personen:17])
		Until (End selection:C36([Personen:17]))
		
		  //use set("merken")
		
		If ($text#$textorig)
			FIRST RECORD:C50([Personen:17])
			[Personen:17]Kommentar:8:=$text
			SAVE RECORD:C53([Personen:17])
		End if 
		
		For ($i2;2;Records in selection:C76([Personen:17]))
			GOTO SELECTED RECORD:C245([Personen:17];$i2)
			DELETE RECORD:C58([Personen:17])
		End for 
		
	End if 
End for 