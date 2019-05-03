//%attributes = {"publishedWeb":true}
  // prüft ob kleines Poster angezeigt werden soll
  // nur der Fall wenn es keine großen Kinoposter gibt
  // returns anzahl poster

C_LONGINT:C283(WebDisplayPoster)
C_LONGINT:C283($bildid)

$result:=0
$bildid:=[Filme:1]FID:1

Begin SQL
	select count(*) from Bilder where Bilder.FID = :$bildid and Bilder.Kinoposter=true
	into :$result
End SQL

If (Picture size:C356([Filme:1]Bild:14)<100)
	If ($result=0)
		$result:=-1
	End if 
End if 
WebDisplayPoster:=$result
