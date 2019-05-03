$value:=OBJECT Get pointer:C1124(Object current:K67:2)->+"@"
Form:C1466.movies:=ds:C1482.Originaltitel.query("Titel_EN = :1";$value).orderBy("Titel_EN")