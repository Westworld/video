Case of 
	: (Form event:C388=On Load:K2:1)
		
	: (Form event:C388=On Outside Call:K2:11)
		Case of 
			: (<>Job#"Cancel")
				If (<>JobURL#"")
					$url:=<>JobURL
					vNextJob:=<>Job
					  // WA OPEN URL(*;"mybrowser";$url)
					vstatus:=$url
				End if 
			Else 
				CANCEL:C270
		End case 
		<>Job:="-"
End case 