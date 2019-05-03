//%attributes = {}
  // von Film_neu

C_BOOLEAN:C305($1)
If (Count parameters:C259>0)
	$new:=$1
Else 
	$new:=False:C215
End if 

C_COLLECTION:C1488($2;$genre;$3;$merkmale)
C_TEXT:C284($merkmal)
Case of 
	: (Count parameters:C259>2)  // merkmal
		$merkmale:=$3
		If ($merkmale#Null:C1517)
			$querycol:=New collection:C1472
			For each ($merkmal;$merkmale)
				  // suche nach merkmal und addiere zr auswahl
				  // oder lieber query string zusammensetzen?
				Case of 
					: ($merkmal="Merkliste Astrid")
						$querycol.push("(merklisteA=true)")
					: ($merkmal="Merkliste Thomas")
						$querycol.push("(merklisteT=true)")
						
					: ($merkmal="Astrid *")
						$querycol.push("(WertungA=1)")
					: ($merkmal="Astrid **")
						$querycol.push("(WertungA=2)")
					: ($merkmal="Astrid ***")
						$querycol.push("(WertungA=3)")
					: ($merkmal="Astrid ****")
						$querycol.push("(WertungA=4)")
					: ($merkmal="Astrid *****")
						$querycol.push("(WertungA=5)")
						
					: ($merkmal="Thomas *")
						$querycol.push("(WertungT=1)")
					: ($merkmal="Thomas **")
						$querycol.push("(WertungT=2)")
					: ($merkmal="Thomas ***")
						$querycol.push("(WertungT=3)")
					: ($merkmal="Thomas ****")
						$querycol.push("(WertungT=4)")
					: ($merkmal="Thomas *****")
						$querycol.push("(WertungT=5)")
				End case 
			End for each 
			C_TEXT:C284($query)
			If ($querycol.length>0)
				$query:=$querycol.join(" | ")
				Form:C1466.Filme:=ds:C1482.Filme.query($query)
			End if 
		End if 
		
	: (Count parameters:C259>1)  // genre
		$genre:=$2
		If ($genre#Null:C1517)
			Form:C1466.Filme:=ds:C1482.Filme.query("Genre1 in :1 or Genre2 in :1";$genre)
		End if 
		  //Else 
		  //$selection:=null
End case 

$CoverPictSize:=160

$columns:=LISTBOX Get number of columns:C831(*;"Filmanzeige")
OBJECT GET COORDINATES:C663(*;"Filmanzeige";$left;$top;$right;$bottom)
$width:=$right-$left
$column_soll:=$width\$CoverPictSize

If ($columns#$column_soll)
	LISTBOX DELETE COLUMN:C830(*;"Filmanzeige";1;$columns)
	
	C_POINTER:C301($nilptr)
	For ($i;1;$column_soll)
		LISTBOX INSERT COLUMN FORMULA:C970(*;"Filmanzeige";$i;"arr"+String:C10($i);"Listbox_Grid_ShowCover(This;"+String:C10($i-1)+")";Is picture:K8:10;"Header"+String:C10($i);$nilptr)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"arr"+String:C10($i);Align left:K42:2)
		OBJECT SET FORMAT:C236(*;"arr"+String:C10($i);Char:C90(Truncated non centered:K6:4))  //Scaled to fit proportional))
		LISTBOX SET PROPERTY:C1440(*;"arr"+String:C10($i);lk resizing mode:K53:36;lk manual:K53:60)
	End for 
	LISTBOX SET COLUMN WIDTH:C833(*;"Filmanzeige";$CoverPictSize;$CoverPictSize;$CoverPictSize)
	LISTBOX SET ROWS HEIGHT:C835(*;"Filmanzeige";$CoverPictSize+10)
End if 

If (($columns#$column_soll) | ($new))
	
	C_COLLECTION:C1488($col)
	C_LONGINT:C283($nbmovies;$nbrows;$i)
	
	$nbmovies:=Form:C1466.Filme.length
	$nbrows:=($nbmovies+($column_soll-1))\$column_soll
	SET WINDOW TITLE:C213(String:C10($nbmovies)+" Filme";Frontmost window:C447)
	Form:C1466.Grid:=New collection:C1472
	$col:=Form:C1466.Grid
	$col.resize($nbrows)
	For ($i;0;$nbrows-1)
		$col[$i]:=$i  // I put a number as the collection element, list box will automatically use it as This.value
	End for 
	
End if 

