//%attributes = {}
  // entfernt Klammerngruppe

  // $0 = Ergebnis; $1 = Text; $2 = Klammer auf


$KlammerAuf:=$2
$Titel:=$1
Case of 
	: ($KlammerAuf="<")
		$KlammerZu:=">"
	: ($KlammerAuf="(")
		$KlammerZu:=")"
	: ($KlammerAuf="[")
		$KlammerZu:="]"
	Else 
		$KlammerZu:="§"
End case 

Repeat 
	$continue:=True:C214
	$pos:=Position:C15($KlammerAuf;$titel)
	If ($pos>0)
		$such:=Substring:C12($titel;$pos)
		$pos2:=Position:C15($KlammerZu;$such)
		If ($pos2>0)
			$such:=Substring:C12($such;1;$pos2)
			$titel:=Replace string:C233($titel;$Such;"")
		End if 
	Else 
		$continue:=False:C215
	End if 
Until ($Continue=False:C215)

$0:=$titel