//%attributes = {"publishedWeb":true}
  // für Web offline erzeugung
  // sucht alle Filme für Schauspieler
  // $1="R" = Regie, ansonsten als Darsteller

C_TEXT:C284($1;$0)
$para:=Substring:C12($1;2)
$0:=""

If ($para="R")
	WebSchauKennung:="R"
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1;*)
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="@R@")
	If (Records in selection:C76([Mitwirkende:3])#0)
		$0:="Regie:"
	End if 
Else 
	WebSchauKennung:="D"
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1;*)
	QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="@D@")
	If (Records in selection:C76([Mitwirkende:3])#0)
		$0:="Darsteller:"
	End if 
End if 

