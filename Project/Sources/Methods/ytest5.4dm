//%attributes = {}
$movie:=ds:C1482.Filme.all().first()
$movie.Inhalt:=$movie.Inhalt+"."
$success:=$movie.save(True:C214)

$parasel:=ds:C1482.Parameter.all()
$para:=$parasel.first()
$para.PID:=$para.PID+1
$success:=$para.save(True:C214)
