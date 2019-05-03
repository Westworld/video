//%attributes = {}
  // HTTP Auswertung
  // $1 = HTTP text
  // $2 = Kennung für Query
  // $3 = Ptr auf Array, optional
  // $4 = Ptr auf Array für Zusatzwort, optional
  // $0 = rückgabe Text, bei Array letzter Treffer


$ergebnis:=""
$ergebnis2:=""
C_TEXT:C284($1;$fulltext)
$fulltext:=$1

READ ONLY:C145([HTTP_query:9])
QUERY:C277([HTTP_query:9];[HTTP_query:9]HTTP_ID:1=$2)
If (Records in selection:C76([HTTP_query:9])#1)
	ALERT:C41($2+" in HTTP query nicht gefunden!")
Else 
	If ([HTTP_query:9]Schleife:7)
		If (Count parameters:C259<3)
			ALERT:C41("HTTP_Parse: "+$2+" - bei Schleife muß array übergeben werden, werte nur erstes Element aus")
			[HTTP_query:9]Schleife:7:=False:C215
		End if 
		If ([HTTP_query:9]Zusatzwort_Springe_bis:10#"")
			If (Count parameters:C259<4)
				ALERT:C41("HTTP_Parse: "+$2+" - bei Zusatzwort muß zweites array übergeben werden, werte nur erstes Wort aus")
				[HTTP_query:9]Zusatzwort_Springe_bis:10:=""
			End if 
		End if 
	End if 
	
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523($fulltext)
	End if 
	
	$pos:=Position:C15([HTTP_query:9]Anfangstext:2;$fulltext)
	If ($pos<1)
		If ([HTTP_query:9]Alternativer _Anfangstext:3#"")
			$pos:=Position:C15([HTTP_query:9]Alternativer _Anfangstext:3;$fulltext)
		End if 
	End if 
	
	  // so, jetzt müßten wir es gefunden haben
	If ($pos<1)
		If ([HTTP_query:9]Optional:12)
			  // nichts
		Else 
			ALERT:C41("Fehler beim HTTP Parsen "+[HTTP_query:9]HTTP_ID:1+" nicht gefunden")
		End if 
	Else 
		$offset:=$pos-1
		$text:=Substring:C12($fulltext;$pos)
		
		If ([HTTP_query:9]Schleife:7)
			$pos:=Position:C15([HTTP_query:9]Schleife_Endetext:8;$text)
			If ($pos>0)
				$text:=Substring:C12($text;1;$pos)
			End if 
			If ([HTTP_query:9]Schleife_Alternativer_Endetext:6#"")
				$pos:=Position:C15([HTTP_query:9]Schleife_Alternativer_Endetext:6;$text)
				If ($pos>0)
					$text:=Substring:C12($text;1;$pos)
				End if 
			End if 
			
			While ($text#"")  // schleife durch alle Wörter und erzeuge array
				$pos:=Position:C15([HTTP_query:9]Springe_bis:4;$text)
				If (False:C215)
					SET TEXT TO PASTEBOARD:C523($text)
				End if 
				If ($pos>0)
					$text:=Substring:C12($text;$pos+Length:C16([HTTP_query:9]Springe_bis:4))
					If ([HTTP_query:9]Springe_bis_Teil2:9#"")
						$pos:=Position:C15([HTTP_query:9]Springe_bis_Teil2:9;$text)
						If ($pos>0)
							$text:=Substring:C12($text;$pos+Length:C16([HTTP_query:9]Springe_bis_Teil2:9))
						End if 
					End if 
					$pos:=Position:C15([HTTP_query:9]Wort_Endetext:5;$text)
					If ($pos>0)
						$ergebnis:=g_RemoveBlanks (Substring:C12($text;1;$pos-1))
						$text:=Substring:C12($text;$pos)
						
						If ([HTTP_query:9]Zusatzwort_Springe_bis:10#"")
							$pos:=Position:C15([HTTP_query:9]Zusatzwort_Springe_bis:10;$text)
							If ($pos>0)
								$text:=Substring:C12($text;$pos+Length:C16([HTTP_query:9]Zusatzwort_Springe_bis:10))
								$pos:=Position:C15([HTTP_query:9]Zusatzwort_Endetext:11;$text)
								If ($pos>0)
									$ergebnis2:=g_RemoveBlanks (Substring:C12($text;1;$pos-1))
									$text:=Substring:C12($text;$pos)
								End if 
								
							End if 
						End if 
					Else 
						  // ALERT("Fehler beim HTTP Parsen- Wortende nicht gefunden")
						  // jetzt müßten wir das ende erreicht haben
						$text:=""
						$ergebnis:=""
					End if 
				Else 
					  //  ALERT("Fehler beim HTTP Parsen "+[HTTP_query]Springe_bis+" nicht gefunden")
					  // jetzt müßten wir das ende erreicht haben
					$text:=""
					$ergebnis:=""
				End if 
				If ($ergebnis#"")
					INSERT IN ARRAY:C227($3->;Size of array:C274($3->)+1;1)
					$3->{Size of array:C274($3->)}:=$ergebnis
				End if 
				If ($ergebnis2#"")
					INSERT IN ARRAY:C227($4->;Size of array:C274($4->)+1;1)
					$4->{Size of array:C274($4->)}:=$ergebnis2
					$ergebnis2:=""
				End if 
			End while 
			
			
		Else 
			  // Anfangstext gefunden, jetzt Wortanfang suchen
			If ([HTTP_query:9]Springe_bis:4#"")
				$pos:=Position:C15([HTTP_query:9]Springe_bis:4;$text)
				If ($pos>0)
					$text:=Substring:C12($text;$pos+Length:C16([HTTP_query:9]Springe_bis:4))
					If ([HTTP_query:9]Springe_bis_Teil2:9#"")
						$pos:=Position:C15([HTTP_query:9]Springe_bis_Teil2:9;$text)
						If ($pos>0)
							$text:=Substring:C12($text;$pos+Length:C16([HTTP_query:9]Springe_bis_Teil2:9))
						End if 
					End if 
					$pos:=Position:C15([HTTP_query:9]Wort_Endetext:5;$text)
					If ($pos>0)
						$ergebnis:=g_RemoveBlanks (Substring:C12($text;1;$pos-1))
					Else 
						ALERT:C41("Fehler beim HTTP Parsen- Wortende nicht gefunden")
					End if 
				Else 
					ALERT:C41("Fehler beim HTTP Parsen "+[HTTP_query:9]Springe_bis:4+" nicht gefunden")
				End if 
			End if 
		End if 
	End if 
End if 

UNLOAD RECORD:C212([HTTP_query:9])
$0:=$ergebnis
