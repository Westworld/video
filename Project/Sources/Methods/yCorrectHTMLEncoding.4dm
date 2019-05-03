//%attributes = {}
If (False:C215)
	ALL RECORDS:C47([Mitwirkende:3])
	While (Not:C34(End selection:C36([Mitwirkende:3])))
		$mod:=False:C215
		$new:=yCorrectHTMLEncoding2 ([Mitwirkende:3]Rolle:4)
		$new:=RemoveSPAN ($new)
		If ([Mitwirkende:3]Rolle:4#$new)
			[Mitwirkende:3]Rolle:4:=$new
			$mod:=True:C214
		End if 
		
		If ($mod)
			SAVE RECORD:C53([Mitwirkende:3])
		End if 
		NEXT RECORD:C51([Mitwirkende:3])
	End while 
	
End if 

If (False:C215)
	ALL RECORDS:C47([Personen:17])
	While (Not:C34(End selection:C36([Personen:17])))
		$mod:=False:C215
		$new:=yCorrectHTMLEncoding2 ([Personen:17]Engl_Beschreibung:11)
		$new:=RemoveSPAN ($new)
		If ([Personen:17]Engl_Beschreibung:11#$new)
			[Personen:17]Engl_Beschreibung:11:=$new
			$mod:=True:C214
		End if 
		
		$new:=yCorrectHTMLEncoding2 ([Personen:17]Geboren:6)
		$new:=RemoveSPAN ($new)
		If ([Personen:17]Geboren:6#$new)
			[Personen:17]Geboren:6:=$new
			$mod:=True:C214
		End if 
		
		$new:=yCorrectHTMLEncoding2 ([Personen:17]Herkunft:7)
		$new:=RemoveSPAN ($new)
		If ([Personen:17]Herkunft:7#$new)
			[Personen:17]Herkunft:7:=$new
			$mod:=True:C214
		End if 
		
		$new:=yCorrectHTMLEncoding2 ([Personen:17]Kommentar:8)
		$new:=RemoveSPAN ($new)
		If ([Personen:17]Kommentar:8#$new)
			[Personen:17]Kommentar:8:=$new
			$mod:=True:C214
		End if 
		
		$new:=yCorrectHTMLEncoding2 ([Personen:17]Suchname:5)
		$new:=RemoveSPAN ($new)
		If ([Personen:17]Suchname:5#$new)
			[Personen:17]Suchname:5:=$new
			$mod:=True:C214
		End if 
		
		If ($mod)
			SAVE RECORD:C53([Personen:17])
		End if 
		NEXT RECORD:C51([Personen:17])
	End while 
End if 




ALL RECORDS:C47([Filme:1])
While (Not:C34(End selection:C36([Filme:1])))
	$mod:=False:C215
	$new:=yCorrectHTMLEncoding2 ([Filme:1]Bemerkung:17)
	$new:=RemoveSPAN ($new)
	If ([Filme:1]Bemerkung:17#$new)
		[Filme:1]Bemerkung:17:=$new
		$mod:=True:C214
	End if 
	
	$new:=yCorrectHTMLEncoding2 ([Filme:1]DtTitel:9)
	$new:=RemoveSPAN ($new)
	If ([Filme:1]DtTitel:9#$new)
		[Filme:1]DtTitel:9:=$new
		$mod:=True:C214
	End if 
	
	$new:=yCorrectHTMLEncoding2 ([Filme:1]EnTitel:2)
	$new:=RemoveSPAN ($new)
	If ([Filme:1]EnTitel:2#$new)
		[Filme:1]EnTitel:2:=$new
		$mod:=True:C214
	End if 
	
	$new:=yCorrectHTMLEncoding2 ([Filme:1]Inhalt:7)
	$new:=RemoveSPAN ($new)
	If ([Filme:1]Inhalt:7#$new)
		[Filme:1]Inhalt:7:=$new
		$mod:=True:C214
	End if 
	
	$new:=yCorrectHTMLEncoding2 ([Filme:1]Land:3)
	$new:=RemoveSPAN ($new)
	If ([Filme:1]Land:3#$new)
		[Filme:1]Land:3:=$new
		$mod:=True:C214
	End if 
	
	If ($mod)
		SAVE RECORD:C53([Filme:1])
	End if 
	NEXT RECORD:C51([Filme:1])
End while 
