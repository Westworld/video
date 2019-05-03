//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
READ ONLY:C145(*)

C_TEXT:C284(WebSchauKennung)

If ($1=0)
	If (WebSchauKennung="R")
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1;*)
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="@R@")
	Else 
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1;*)
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="@D@")
	End if 
	$0:=True:C214
Else 
	If ($1<=Records in selection:C76([Mitwirkende:3]))
		GOTO SELECTED RECORD:C245([Mitwirkende:3];$1)
		QUERY:C277([Filme:1];[Filme:1]FID:1=[Mitwirkende:3]FID:1)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 