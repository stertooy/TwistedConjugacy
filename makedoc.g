if fail = LoadPackage( "AutoDoc", ">= 2022.07.10" ) then
    Info( InfoGAPDoc, 1, "#I AutoDoc 2022.07.10 or newer is required.\n" );
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
        main := "manual.xml",
        LaTeXOptions := rec(
            LateExtraPreamble := "\\usepackage{amsmath}"
        )
    ),
    extract_examples := rec(
        units := "Chapter"
    )
));

if not ValidatePackageInfo( "PackageInfo.g" ) then
    Info( InfoGAPDoc, 1, "#I One or more files could not be created.\n" );
    FORCE_QUIT_GAP( 1 );
else
    Info( InfoGAPDoc, 1, "#I Manual files sucessfully created.\n" );
fi;

errorFound := false;
Info( InfoGAPDoc, 1, "#I Testing examples found in manual.\n" );

for i in [1..99] do
    filename := Concatenation(
        "tst/twistedconjugacy",
        ReplacedString( String( i, 2 ), " ", "0" ),
        ".tst"
    );
    if not IsExistingFile( filename ) then break; fi;
    errorFound := errorFound or not Test(
        filename,
        rec( compareFunction := "uptowhitespace" )
    );
    RemoveFile( filename );
od;

if errorFound then
    Info( InfoGAPDoc, 1, "#I One or more examples are incorrect.\n" );
    FORCE_QUIT_GAP( 1 );
else
    Info( InfoGAPDoc, 1, "#I All tests passed.\n" );
fi;

Info( InfoGAPDoc, 1, "#I Documentation successfully created.\n" );
QUIT_GAP( 0 );
