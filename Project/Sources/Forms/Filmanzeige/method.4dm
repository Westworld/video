Case of 
	: (Form event:C388=On Load:K2:1)
		ALL RECORDS:C47([Filme:1])
		Filmanzeige_LoadListbox 
		
	: (Form event:C388=On Resize:K2:27)
		
		Filmanzeige_LoadListbox ("resize")
		
		
	: (Form event:C388=On Outside Call:K2:11)
		C_TEXT:C284(ProcessSetGenre;ProcessSetMerkmal)
		Case of 
			: (ProcessSetGenre#"")
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Genre")
				$ptr->:=ProcessSetGenre
				ARRAY TEXT:C222($arrGenre;0)
				Tools_SplitTextTTR (->$arrGenre;ProcessSetGenre;Character code:C91(";");13)
				
				QUERY WITH ARRAY:C644([Filme:1]Genre1:5;$arrGenre)
				CREATE SET:C116([Filme:1];"S1")
				QUERY WITH ARRAY:C644([Filme:1]Genre2:6;$arrGenre)
				CREATE SET:C116([Filme:1];"S2")
				UNION:C120("s1";"s2";"s1")
				USE SET:C118("s1")
				
				Filmanzeige_LoadListbox 
				ProcessSetGenre:=""
				
			: (ProcessSetMerkmal#"")
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"Merkmal")
				$ptr->:=ProcessSetMerkmal
				
				ARRAY TEXT:C222($arrQuery;0)
				Tools_SplitTextTTR (->$arrQuery;ProcessSetMerkmal;Character code:C91(";");13)
				
				If (Size of array:C274($arrQuery)>0)
					QUERY:C277([Filme:1];[Filme:1]FID:1=-1;*)  // just to allow |
					For ($i;1;Size of array:C274($arrQuery))
						Case of 
							: ($arrQuery{$i}="Merkliste Astrid")
								QUERY:C277([Filme:1]; | [Filme:1]merklisteA:29=True:C214;*)
							: ($arrQuery{$i}="Merkliste Thomas")
								QUERY:C277([Filme:1]; | [Filme:1]merklisteT:30=True:C214;*)
								
							: ($arrQuery{$i}="Astrid *")
								QUERY:C277([Filme:1]; | [Filme:1]WertungA:27=1;*)
							: ($arrQuery{$i}="Astrid **")
								QUERY:C277([Filme:1]; | [Filme:1]WertungA:27=2;*)
							: ($arrQuery{$i}="Astrid ***")
								QUERY:C277([Filme:1]; | [Filme:1]WertungA:27=3;*)
							: ($arrQuery{$i}="Astrid ****")
								QUERY:C277([Filme:1]; | [Filme:1]WertungA:27=4;*)
							: ($arrQuery{$i}="Astrid *****")
								QUERY:C277([Filme:1]; | [Filme:1]WertungA:27=5;*)
								
							: ($arrQuery{$i}="Thomas *")
								QUERY:C277([Filme:1]; | [Filme:1]WertungT:28=1;*)
							: ($arrQuery{$i}="Thomas **")
								QUERY:C277([Filme:1]; | [Filme:1]WertungT:28=2;*)
							: ($arrQuery{$i}="Thomas ***")
								QUERY:C277([Filme:1]; | [Filme:1]WertungT:28=3;*)
							: ($arrQuery{$i}="Thomas ****")
								QUERY:C277([Filme:1]; | [Filme:1]WertungT:28=4;*)
							: ($arrQuery{$i}="Thomas *****")
								QUERY:C277([Filme:1]; | [Filme:1]WertungT:28=5;*)
						End case 
					End for 
					QUERY:C277([Filme:1])
				Else 
					ALL RECORDS:C47([Filme:1])
				End if 
				
				Filmanzeige_LoadListbox 
				ProcessSetMerkmal:=""
				
			Else 
				ALL RECORDS:C47([Filme:1])
				Filmanzeige_LoadListbox 
		End case 
		
End case 