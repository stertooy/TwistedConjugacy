if fail = LoadPackage( "AutoDoc", ">= 2018.02.14" ) then
	Info( InfoGAPDoc, 1, "#I AutoDoc 2018.02.14 or newer is required.\n" );
	FORCE_QUIT_GAP( 1 );
fi;

if not IsPackageLoaded( "TwistedConjugacy" ) then
	SetPackagePath( "TwistedConjugacy", "./" );
	if fail = LoadPackage( "TwistedConjugacy" ) then
		Info( InfoGAPDoc, 1, "#I Could not load the package.\n" );
		FORCE_QUIT_GAP( 1 );
	fi;
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
	),
	extract_examples := rec(
		units := "Chapter"
	)
));

if not ValidatePackageInfo( "PackageInfo.g" ) then
	Info( InfoGAPDoc, 1, "#I One or more files could not be created.\n" );
	FORCE_QUIT_GAP( 1 );
fi;

checkExamples := true;

for i in [1..99] do
	filename := Concatenation(
		"tst/twistedconjugacy",
		ReplacedString( String( i, 2 ), " ", "0" ),
		".tst"
	);
	if not IsExistingFile( filename ) then break; fi;
	checkExamples := checkExamples and Test(
		filename,
		rec( compareFunction := "uptowhitespace" )
	);
	RemoveFile( filename );
od;

if not checkExamples then
	Info( InfoGAPDoc, 1, "#I One or more examples are incorrect.\n" );
	FORCE_QUIT_GAP( 1 );
fi;

QUIT_GAP( 0 );
