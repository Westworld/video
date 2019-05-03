//%attributes = {}
$para:=$1
Case of 
	: ($para="MKV")
		QUERY SELECTION:C341([Filme:1];[Filme:1]MKV_Pfad:22#"")
	: ($para="BluRay")
		QUERY SELECTION:C341([Filme:1];[Filme:1]Mediaart:19>=6)
	: ($para="DVD")
		QUERY SELECTION:C341([Filme:1];[Filme:1]Mediaart:19>=3;*)
		QUERY SELECTION:C341([Filme:1];[Filme:1]Mediaart:19<6)
		
	: ($para="SVHS")
		QUERY SELECTION:C341([Filme:1];[Filme:1]Mediaart:19=2)
		
	: ($para="Alle")
		  //ALL RECORDS([Originaltitel])
		
	Else 
		REDUCE SELECTION:C351([Filme:1];0)
End case 