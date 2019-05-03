//%attributes = {"publishedWeb":true,"publishedSql":true}
  // Sortiere Schauspiele
  //  Regie ganz oben
  // dann nach häufigkeit

If ([Mitwirkende:3]Kennung:3="R")
	$0:=10000
Else 
	  // in wievielen Filmen hat er noch mitgespielt?
	$pid:=[Mitwirkende:3]PID:2
	$anz:=ds:C1482.Mitwirkende.query("PID=:1";$pid).length
	
	  //$anz:=0
	  //$pid:=[Mitwirkende]PID
	  //Begin SQL
	  //select count(*) from Mitwirkende where PID = :$pid
	  //into :$anz;
	  //End SQL
	$0:=$anz
End if 