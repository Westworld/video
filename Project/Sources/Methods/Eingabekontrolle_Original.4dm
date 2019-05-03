//%attributes = {}
  // verweigert Ok, Cancel, Vor und Zurück bis alle Internetjobs fertig sind


Bildprozess:=0
Amazonprozess:=0
IMDBprozess:=0
OFDBprozess:=0

If ((Bildprozess+IMDBprozess+Amazonprozess+OFDBprozess)#0)
	ALERT:C41("Bitte warten bis alle Abfragen fertig sind")
	REJECT:C38
	OK:=0
Else 
	OK:=1
	VALIDATE TRANSACTION:C240
End if 