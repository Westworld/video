If (Form event:C388=On Double Clicked:K2:5)
	  // click where?
	C_LONGINT:C283($zeile)
	$ptr:=OBJECT Get pointer:C1124(Object current:K67:2)  // Spalte
	$zeile:=($ptr->)-1  // zeile
	RESOLVE POINTER:C394($ptr;$name;$tabnum;$fieldnum)
	$Spalte:=Num:C11(Substring:C12($name;4))
	$columns:=LISTBOX Get number of columns:C831(*;"Actoranzeige")
	
	$item:=($columns*$zeile)+$spalte
	
	$id:=Actor_ID{$item}
	
	$p:=New process:C317("ActorAnzeigen_Neu";0;"ActorAnzeigen_Neu";$id)
	
	
End if 