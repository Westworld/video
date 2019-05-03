//%attributes = {}
$0:=0
C_TEXT:C284($result)
$pagecontent:=<>pageContent

$url:=HTTP_Parse ($pagecontent;"IMBD_LoadPerson")
If ($url#"")
	  // Tools_HTTP_Download ("Picture";->[Personen]Bild;$url)
	  // $status:=HTTP Get($url;[Personen]Bild)
	C_PICTURE:C286($pic)
	$status:=HTTP Get:C1157($url;$pic)
	[Personen:17]Bild:2:=$pic
End if 
