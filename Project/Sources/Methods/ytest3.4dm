//%attributes = {}
DOCUMENT TO BLOB:C525("E:\\blob.txt";$myblob)
$biotext:=Convert to text:C1012($myblob;"UTF-8")

  // test enthält </p>, /br />
  // encoding, ahrefs

$biotext:=Replace string:C233($biotext;"<br />";"")
$biotext:=Replace string:C233($biotext;"<p>";"")
$biotext:=Replace string:C233($biotext;"</p>";"")

$pos:=Position:C15("<a ";$biotext)
While ($pos>0)
	$pos2:=Position:C15(">";$biotext;$pos)
	If ($pos2>0)
		$biotext:=Delete string:C232($biotext;$pos;$pos2-$pos+1)
	End if 
	
	$pos:=Position:C15("<a ";$biotext)
End while 
$biotext:=Replace string:C233($biotext;"</a>";"")

SET TEXT TO PASTEBOARD:C523($biotext)

  // $utf8_text = html_entity_decode( $text, ENT_QUOTES, "utf-8" ); 
$result:=""
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"phpdecode.php"
$fehler:=PHP Execute:C1058($path;"mydecode";$result;$biotext)
SET TEXT TO PASTEBOARD:C523($result)
