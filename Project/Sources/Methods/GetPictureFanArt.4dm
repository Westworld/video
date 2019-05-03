//%attributes = {}
  // setzt Opacity auf 35%
  // $1=bildpfad in, $0 bild var out

C_TEXT:C284($1)
C_PICTURE:C286($0)

$svgRef:=SVG_New (Screen width:C187;Screen height:C188)
$object:=SVG_New_rect ($svgRef;0;0;Screen width:C187;Screen height:C188;0;0;"black";"black")

$doc:="file://"+Convert path system to POSIX:C1106($1)
$objectp:=SVG_New_image ($svgRef;$doc)

SVG_SET_OPACITY ($objectp;35)
$0:=SVG_Export_to_picture ($svgRef;Own XML data source:K45:18)
