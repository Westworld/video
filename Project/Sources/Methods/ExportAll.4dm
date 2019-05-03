//%attributes = {}
$folder:=Select folder:C670("Export Ordner")

SET CHANNEL:C77(10;$folder+"Bilder.blob")
ALL RECORDS:C47([Bilder:8])
While (Not:C34(End selection:C36([Bilder:8])))
	SEND RECORD:C78([Bilder:8])
	NEXT RECORD:C51([Bilder:8])
End while 
SET CHANNEL:C77(11)

SET CHANNEL:C77(10;$folder+"Originaltitel.blob")
ALL RECORDS:C47([Filme:1])
While (Not:C34(End selection:C36([Filme:1])))
	SEND RECORD:C78([Filme:1])
	NEXT RECORD:C51([Filme:1])
End while 
SET CHANNEL:C77(11)

SET CHANNEL:C77(10;$folder+"Mitwirkende.blob")
ALL RECORDS:C47([Mitwirkende:3])
While (Not:C34(End selection:C36([Mitwirkende:3])))
	SEND RECORD:C78([Mitwirkende:3])
	NEXT RECORD:C51([Mitwirkende:3])
End while 
SET CHANNEL:C77(11)

SET CHANNEL:C77(10;$folder+"Personen.blob")
ALL RECORDS:C47([Personen:17])
While (Not:C34(End selection:C36([Personen:17])))
	SEND RECORD:C78([Personen:17])
	NEXT RECORD:C51([Personen:17])
End while 
SET CHANNEL:C77(11)

SET CHANNEL:C77(10;$folder+"Parameter.blob")
ALL RECORDS:C47([Parameter:5])
While (Not:C34(End selection:C36([Parameter:5])))
	SEND RECORD:C78([Parameter:5])
	NEXT RECORD:C51([Parameter:5])
End while 
SET CHANNEL:C77(11)