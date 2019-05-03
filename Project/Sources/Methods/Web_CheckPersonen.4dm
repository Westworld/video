//%attributes = {}
  // prüft ob Set Vorhanden existiert, sonst wird es aufgebaut

C_BOOLEAN:C305(<>SetVorhandenErzeugt)
If (<>SetVorhandenErzeugt)
	  // nicht
	
Else 
	ALL RECORDS:C47([Filme:1])
	RELATE MANY SELECTION:C340([Mitwirkende:3]FID:1)
	RELATE ONE SELECTION:C349([Mitwirkende:3];[Personen:17])
	
	CREATE SET:C116([Personen:17];"<>vorhanden")
	
	<>SetVorhandenErzeugt:=True:C214
End if 