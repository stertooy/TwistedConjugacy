ASSERT@TwistedConjugacy := true;
pkgName := "TwistedConjugacy";

info := PackageInfo( pkgName )[1];

if (
    LoadPackage( pkgName, false ) = fail or
    LoadPackage( "AutoDoc", false ) = fail
) then
    Info( InfoGAPDoc, 1, "#I Could not load required package(s).\n" );
    ForceQuitGap( 1 );
fi;

if IsBound( info.Extensions ) then
    for ext in info.Extensions do
        for pkgver in ext.needed do
            LoadPackage( pkgver[1], pkgver[2], false );
        od;
    od;
fi;

AutoDoc( rec(
    autodoc := rec( files := [ "doc/manual.gd" ] ),
    scaffold := rec( bib := "manual.bib" ),
    gapdoc := rec(
        main := "manual.xml",
        LaTeXOptions := rec( LateExtraPreamble := "\\usepackage{amsmath}" )
    ),
    extract_examples := rec( units := "File" )
));

if not ValidatePackageInfo( "PackageInfo.g" ) then
    Info( InfoGAPDoc, 1, "#I One or more files could not be created.\n" );
    ForceQuitGap( 1 );
else
    Info( InfoGAPDoc, 1, "#I Manual files sucessfully created.\n" );
fi;

tstFile := Filename(
    DirectoriesPackageLibrary( pkgName, "tst" )[1],
    Concatenation( ReplacedString( LowercaseString( pkgName ), " ", "_" ), ".01tst" )
);

if IsReadableFile( tstFile ) then
    Info( InfoGAPDoc, 1, "#I Testing examples found in manual.\n" );
    if Test(
        tstFile,
        rec( compareFunction := "uptowhitespace" )
    ) then
        Info( InfoGAPDoc, 1, "#I All tests passed - manual should be correct.\n" );
    else
        Info( InfoGAPDoc, 1, "#I One or more examples are incorrect.\n" );
        ForceQuitGap( 1 );
    fi;
else
    Info( InfoGAPDoc, 1, "#I No examples found in manual.\n" );
fi;

Info( InfoGAPDoc, 1, "#I Documentation successfully created.\n" );
QuitGap( 0 );
