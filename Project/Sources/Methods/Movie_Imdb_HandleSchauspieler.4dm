//%attributes = {}
  // bearbeitet Schauspieler
  // Daten von IDMB erhalten in $1

$result:=$1

ARRAY TEXT:C222(castlist;0)
ARRAY TEXT:C222(castRolle;0)
$schau:=HTTP_Parse ($result;"IMBD_Cast";->castlist;->castrolle)
_O_ARRAY STRING:C218(80;castRolle;Size of array:C274(castlist))  // manchmal haben die letzten keine rollenangabe

For ($i;1;Size of array:C274(castlist))
	$schau:=HTML2Mac (castlist{$i})
	
	If ($schau#"")
		If ($schau="@/name/nm@")
			$pos:=Position:C15("/name/nm";$schau)
			If ($pos>0)
				$id:=Substring:C12($schau;$pos+6)
				$pos:=Position:C15("/";$id)
				$id:=Substring:C12($id;1;$pos-1)
				$pos:=Position:C15(">";$schau)
				$schau:=Substring:C12($schau;$pos+1)
				$schau:=RemoveSPAN ($schau)
				If ($schau=" @")
					$schau:=Substring:C12($schau;2)
				End if 
			End if 
		Else 
			  // alte Form, übernehmen wie es ist
		End if 
		
		If ($id#"")
			QUERY:C277([Personen:17];[Personen:17]IMDB:3=$id)
			If (Records in selection:C76([Personen:17])=0)
				QUERY:C277([Personen:17];[Personen:17]Suchname:5=$schau)
				If (Records in selection:C76([Personen:17])=1)
					[Personen:17]IMDB:3:=$id
					SAVE RECORD:C53([Personen:17])
					schauspieler_suchebeiOFDB 
				End if 
			End if 
		Else 
			QUERY:C277([Personen:17];[Personen:17]Suchname:5=$schau)
		End if 
		If (Records in selection:C76([Personen:17])=0)
			CreatePersonen ($schau;$id)
		End if 
		CreatePersonen_Bild   // prüft ob es bild gibt
		$rolle:=castRolle{$i}
		$rolle:=Replace string:C233($rolle;Char:C90(13);"")
		$rolle:=g_RemoveBlanks ($rolle)
		$pos:=Position:C15("<a href=";$rolle)
		If ($pos>0)
			$rolle:=Substring:C12($rolle;$pos+5)
		End if 
		$pos:=Position:C15(">";$rolle)
		If ($pos>0)
			$rolle:=Substring:C12($rolle;$pos+1)
			$pos:=Position:C15("<";$rolle)
			If ($pos>0)
				$rolle:=Substring:C12($rolle;1;$pos-1)
			End if 
		End if 
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
		QUERY:C277([Mitwirkende:3];[Mitwirkende:3]PID:2=[Personen:17]PID:1)
		If (Records in selection:C76([Mitwirkende:3])=0)
			CREATE RECORD:C68([Mitwirkende:3])
			[Mitwirkende:3]FID:1:=[Filme:1]FID:1
			[Mitwirkende:3]Kennung:3:="D"
			[Mitwirkende:3]PID:2:=[Personen:17]PID:1
			[Mitwirkende:3]Rolle:4:=HTML2Mac ($rolle)
			SAVE RECORD:C53([Mitwirkende:3])
		Else 
			If ([Mitwirkende:3]Kennung:3="R")
				[Mitwirkende:3]Kennung:3:="RD"
				[Mitwirkende:3]Rolle:4:=HTML2Mac ($rolle)
				SAVE RECORD:C53([Mitwirkende:3])
			Else 
				If (([Mitwirkende:3]Rolle:4="") & ($rolle#""))
					[Mitwirkende:3]Rolle:4:=HTML2Mac ($rolle)
					SAVE RECORD:C53([Mitwirkende:3])
				End if 
			End if 
		End if 
	End if 
End for 