//%attributes = {}
$0:=0
C_TEXT:C284($result)

Bildprozess:=New process:C317("Thread_Internet_imdb_Bilder";128000;"Bilder Download";Current process:C322;[Filme:1]FID:1;[Filme:1]imdb:15)

$pagecontent:=<>pageContent

  // browser already displays correct page, now fetch the data
  //  dort orig titel, direktor, schauspieler und laufzeit holen
  //mybrowser:=0
  //GET PROCESS VARIABLE(<>browserWindow;mybrowser;mybrowser)
$titel:=HTTP_Parse ($pagecontent;"IMBD_OrigTitel")
If (($titel#"") & ([Filme:1]EnTitel:2=""))
	[Filme:1]EnTitel:2:=$titel
End if 
[Filme:1]Länge:10:=Abs:C99(Num:C11(HTTP_Parse ($pagecontent;"IMDB_Length")))

QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1;*)
QUERY:C277([Mitwirkende:3];[Mitwirkende:3]Kennung:3="R")
If (Records in selection:C76([Mitwirkende:3])=0)
	$regie:=HTTP_Parse ($pagecontent;"IMBd_Directed")
	$regie:=RemoveSPAN ($regie)
	If ($regie#"")
		CREATE RECORD:C68([Mitwirkende:3])
		[Mitwirkende:3]FID:1:=[Filme:1]FID:1
		[Mitwirkende:3]Kennung:3:="R"
		QUERY:C277([Personen:17];[Personen:17]Suchname:5=$regie)
		If (Records in selection:C76([Personen:17])=0)
			CreatePersonen ($regie)
		End if 
		[Mitwirkende:3]PID:2:=[Personen:17]PID:1
		SAVE RECORD:C53([Mitwirkende:3])
	End if 
End if 

  // mitwirkende

Movie_Imdb_HandleSchauspieler ($pagecontent)

QUERY:C277([Mitwirkende:3];[Mitwirkende:3]FID:1=[Filme:1]FID:1)
SET WINDOW TITLE:C213([Filme:1]DtTitel:9)