//%attributes = {}
Case of 
	: ([Filme:1]Mediaart:19<3)
		$0:="Video"
		
	: ([Filme:1]Mediaart:19=3)
		$0:="DVD"
	: ([Filme:1]Mediaart:19=4)
		$0:="DVD-R"
	: ([Filme:1]Mediaart:19=5)
		$0:="DVD-TV"
	: ([Filme:1]Mediaart:19=6)
		$0:="BluRay"
	: ([Filme:1]Mediaart:19=7)
		$0:="BluRay TV"
	Else 
		$0:="???"
End case 

If ([Filme:1]MKV_Pfad:22#"")
	$0:=$0+" MKV"
End if 