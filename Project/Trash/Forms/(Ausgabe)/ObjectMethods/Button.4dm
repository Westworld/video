COPY NAMED SELECTION:C331([Personen:17];"merken")
USE SET:C118("UserSet")
FIRST RECORD:C50([Personen:17])
theid:=[Personen:17]PID:1
Repeat 
	NEXT RECORD:C51([Personen:17])
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1)
	APPLY TO SELECTION:C70([Mitwirkende:3];[Mitwirkende:3]PID:2:=theid)
Until (End selection:C36([Personen:17]))
  //For ($i;2;Records in set("UserSet"))
  //USE SET("UserSet")
  //GOTO SELECTED RECORD([Personen];$i)
  ////DELETE RECORD([Personen])
  //End for 

USE NAMED SELECTION:C332("merken")
CLEAR NAMED SELECTION:C333("merken")
HIGHLIGHT RECORDS:C656([Personen:17])