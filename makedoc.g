if fail = LoadPackage( "AutoDoc", ">= 2018.09.20" ) then
    Error( "AutoDoc 2018.09.20 or newer is required" );
fi;

AutoDoc( rec( 
	autodoc := rec( 
		files := [ "doc/manual.gd" ]
	),
	scaffold := rec(
		bib := "manual.bib"
	),
	gapdoc := rec(
		main := "manual.xml"
	)
));

QUIT;
