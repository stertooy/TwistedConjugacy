LoadPackage( "AutoDoc", false );
pkgName := "TwistedConjugacy";
if LoadPackage( pkgName, false ) = fail then
    Info( InfoGAPDoc, 1, "#I Could not load the package.\n" );
    ForceQuitGap( 1 );
fi;
ASSERT@TwistedConjugacy := true;

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
    ForceQuitGap( 1 );
else
    Info( InfoGAPDoc, 1, "#I Manual files sucessfully created.\n" );
fi;

correct := true;
Info( InfoGAPDoc, 1, "#I Testing examples found in manual.\n" );

pkgName := LowercaseString( pkgName );
pkgName := ReplacedString( pkgName, " ", "_" );

for file in DirectoryContents( "tst" ) do
    if (
        StartsWith( file, pkgName ) and
        EndsWith( file, ".tst" ) and
        Length( file ) - Length( pkgName ) >= 6 and
        ForAll( file{[1 + Length( pkgName ) .. Length( file ) - 4]}, IsDigitChar )
    ) then
        Info( InfoGAPDoc, 1, Concatenation( "#I   Now testing file ", file, "\n" ) );
        correct := correct and Test(
            Filename( "tst", file ),
            rec( compareFunction := "uptowhitespace" )
        );
        RemoveFile( Filename( "tst", file ) );
    fi;
od;

if not correct then
    Info( InfoGAPDoc, 1, "#I One or more examples are incorrect.\n" );
    ForceQuitGap( 1 );
else
    Info( InfoGAPDoc, 1, "#I All tests passed.\n" );
fi;

Info( InfoGAPDoc, 1, "#I Documentation successfully created.\n" );
QuitGap( 0 );
