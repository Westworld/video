If (Form event:C388=On Double Clicked:K2:5)
	  // click where?
	  //$ptr:=OBJECT Get pointer(Object current)  // Spalte
	  //$zeile:=($ptr->)-1  // zeile
	  //RESOLVE POINTER($ptr;$name;$tabnum;$fieldnum)
	  //$Spalte:=Num(Substring($name;4))
	  //$columns:=LISTBOX Get number of columns(*;"Filmanzeige")
	
	  //$item:=($columns*$zeile)+$spalte
	
	  //$id:=Filme_ID{$item}
	
	  //$p:=New process("FilmAnzeigen_Neu";0;"FilmAnzeigen_Neu";$id)
	
	
End if 