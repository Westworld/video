//%attributes = {}
  // finde alle personen die 2 mal im gleichen film mitspielen, aber nicht R

CREATE EMPTY SET:C140([Mitwirkende:3];"doppelt")
ALL RECORDS:C47([Mitwirkende:3])
ORDER BY:C49([Mitwirkende:3];[Mitwirkende:3]FID:1;>;[Mitwirkende:3]PID:2;>;[Mitwirkende:3]Kennung:3;>)
$pid:=[Mitwirkende:3]PID:2
$fid:=[Mitwirkende:3]FID:1
$kennung:=[Mitwirkende:3]Kennung:3
NEXT RECORD:C51([Mitwirkende:3])

While (Not:C34(End selection:C36([Mitwirkende:3])))
	If (($pid=[Mitwirkende:3]PID:2) & ($fid=[Mitwirkende:3]FID:1) & ([Mitwirkende:3]Kennung:3=$kennung))
		ADD TO SET:C119([Mitwirkende:3];"doppelt")
	Else 
		$pid:=[Mitwirkende:3]PID:2
		$fid:=[Mitwirkende:3]FID:1
		$kennung:=[Mitwirkende:3]Kennung:3
	End if 
	NEXT RECORD:C51([Mitwirkende:3])
End while 

USE SET:C118("doppelt")