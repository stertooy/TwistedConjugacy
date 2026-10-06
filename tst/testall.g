LoadPackage( "TwistedConjugacy" );
TWC.ASSERT := true;

ForceQuitGap( TestDirectory(
    [
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
    ],
    rec(
        exitGAP := false,
        showProgress := true,
        testOptions := rec( compareFunction := "uptowhitespace" )
    )
) );
