//%attributes = {}
  // entfernt <p> etc
  // test enthält </p>, /br />
  // encoding, ahrefs
$biotext:=$1

$biotext:=Replace string:C233($biotext;"<br />";"")
$biotext:=Replace string:C233($biotext;"<p>";"")
$biotext:=Replace string:C233($biotext;"</p>";"")
$biotext:=Replace string:C233($biotext;"<i>";"")
$biotext:=Replace string:C233($biotext;"</i>";"")
$biotext:=Replace string:C233($biotext;"<b>";"")
$biotext:=Replace string:C233($biotext;"</b>";"")
$biotext:=Replace string:C233($biotext;"<strong>";"")
$biotext:=Replace string:C233($biotext;"</strong>";"")

$pos:=Position:C15("<a ";$biotext)
While ($pos>0)
	$pos2:=Position:C15(">";$biotext;$pos)
	If ($pos2>0)
		$biotext:=Delete string:C232($biotext;$pos;$pos2-$pos+1)
	End if 
	
	$pos:=Position:C15("<a ";$biotext)
End while 
$biotext:=Replace string:C233($biotext;"</a>";"")

If (False:C215)
	SET TEXT TO PASTEBOARD:C523($biotext)
End if 

  // $utf8_text = html_entity_decode( $text, ENT_QUOTES, "utf-8" ); 
$result:=""
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"phpdecode.php"
$fehler:=PHP Execute:C1058($path;"mydecode";$result;$biotext)
If (False:C215)
	SET TEXT TO PASTEBOARD:C523($result)
End if 

$0:=$result