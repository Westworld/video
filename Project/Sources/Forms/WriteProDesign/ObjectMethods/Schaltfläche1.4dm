$path:=System folder:C487(Desktop:K41:16)
ARRAY TEXT:C222($patharr;0)
$path:=Select document:C905($path;".4wp";" title";File name entry:K24:17;$patharr)
If ((OK=1) & (Size of array:C274($patharr)=1))
	WP EXPORT DOCUMENT:C1337(WPArea;$patharr{1};wk 4wp:K81:4;wk normal:K81:7)  //wk web page complete;wk html debug)
End if 