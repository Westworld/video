//%attributes = {}
  // Mehrere gefunden, Array erstellen

  //$1 = Ptr auf titel, Deutsch oder englisch
  // $2 = blob

ARRAY TEXT:C222(Release;0)
ARRAY TEXT:C222(Product;0)
$schau:=HTTP_Parse ($2;"ofdb_Filmliste";->Release;->Product)
For ($i;1;Size of array:C274(product))
	product{$i}:=HTML2Mac (product{$i})
End for 
$pos:=Find in array:C230(Product;($1->+" (@"))
If ($pos>0)
	$pos2:=Find in array:C230(Product;($1->+" (@");$pos+1)
	If ($pos2>0)
		$pos:=0
	End if 
End if 

If ($pos>0)
	Product:=$pos
	[Filme:1]OFDb:16:=Release{Product}
Else 
	If (Size of array:C274(Product)>0)
		SET WINDOW TITLE:C213([Filme:1]DtTitel:9+" - "+[Filme:1]EnTitel:2+" - "+[Filme:1]Jahr:4)
		Dialog_Content:="OFDB"
		DIALOG:C40("AmazonFilmauswahl")
		[Filme:1]OFDb:16:=Release{Product}
	Else 
		ALERT:C41("Film nicht gefunden, Titel verkürzen!")
	End if 
End if 