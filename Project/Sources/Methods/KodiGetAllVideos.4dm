//%attributes = {}
ALL RECORDS:C47([Parameter:5])
<>Kodi:=[Parameter:5]Kodi:10
<>KodiPort:=8080
ARRAY TEXT:C222(kodi_detitle;0)
ARRAY TEXT:C222(kodi_entitle;0)
ARRAY TEXT:C222(kodi_imdb;0)
ARRAY LONGINT:C221(kodi_year;0)
ARRAY LONGINT:C221(kodi_id;0)

$command:="open 'smb://Thomas:isni5200@nas/Video'"
  // LAUNCH EXTERNAL PROCESS($command)

C_LONGINT:C283(<>KodiRaw)
<>KodiRaw:=0
$start:=0

  //Progress QUIT (0)


$P:=Progress New   // Neuen Balken erstellen
  // Ablaufen in einer Schleife ausführen



While ($start>=0)
	
	  //ARRAY TEXT(kodi_detitle;0)
	  //ARRAY TEXT(kodi_entitle;0)
	  //ARRAY TEXT(kodi_imdb;0)
	  //ARRAY LONGINT(kodi_year;0)
	  //ARRAY LONGINT(kodi_id;0)
	
	
	ARRAY OBJECT:C1221($movies;0)
	Progress SET TITLE ($P;"Hole Daten von Kodi:";-1;String:C10($start);True:C214)
	
	  //Progress SET PROGRESS ($P;-1;"Hole Daten von Kodi: "+String($start))
	
	KodiGetAllVideos_Chunk ($start;->$movies)
	If ((Size of array:C274($movies)=0) | (Size of array:C274($movies)>300))
		$start:=-1
	Else 
		Progress SET TITLE ($P;"Analyse Daten von Kodi";-1;"")
		
		  //Progress SET PROGRESS ($P;-1;"Analyse Daten von Kodi")
		$start:=$start+Size of array:C274($movies)
		If (Size of array:C274($movies)>0)
			For ($i;1;Size of array:C274($movies))
				  //$title:=OB Get($movies{$i};"title")
				  //If (($title="@Butler@") | ($title="@Lockout@"))
				  //trace
				  //end if
				
				
				$id:=OB Get:C1224($movies{$i};"movieid")
				QUERY:C277([Filme:1];[Filme:1]Kodi_ID:31=$id)
				If (Records in selection:C76([Filme:1])=0)
					$imdb:=OB Get:C1224($movies{$i};"imdbnumber")
					If ($imdb#"")
						QUERY:C277([Filme:1];[Filme:1]imdb:15=$imdb)
						If (Records in selection:C76([Filme:1])=0)
							If ($imdb="tt@")
								$imdb:=Substring:C12($imdb;3)
								QUERY:C277([Filme:1];[Filme:1]imdb:15=$imdb)
							End if 
						End if 
					End if 
					If (Records in selection:C76([Filme:1])=0)
						APPEND TO ARRAY:C911(kodi_detitle;OB Get:C1224($movies{$i};"title"))
						APPEND TO ARRAY:C911(kodi_entitle;OB Get:C1224($movies{$i};"originaltitle"))
						APPEND TO ARRAY:C911(kodi_imdb;$imdb)
						APPEND TO ARRAY:C911(kodi_year;OB Get:C1224($movies{$i};"year"))
						APPEND TO ARRAY:C911(kodi_id;$id)
						
						
					Else 
						ASSERT:C1129(Records in selection:C76([Filme:1])=1;"darf nur einen Film für imdb finden")
						If ([Filme:1]Kodi_ID:31=0)
							[Filme:1]Kodi_ID:31:=$id
							Progress SET TITLE ($P;"KodiGetVideo";-1;[Filme:1]DtTitel:9)
							
							KodiGetVideo ($id)
						End if 
						
						KodiStreamDetails ($movies{$i})
						
					End if 
				Else 
					ASSERT:C1129(Records in selection:C76([Filme:1])=1;"darf nur einen Film für kodi id finden")
					  // sonst nichts
					KodiStreamDetails ($movies{$i})
				End if 
			End for 
		End if 
		
	End if 
End while 

If (Size of array:C274(kodi_id)>0)
	$win:=Open form window:C675("Kodi_Filmabgleich")
	DIALOG:C40("Kodi_Filmabgleich")
	CLOSE WINDOW:C154($win)
End if 

Progress QUIT (0)
