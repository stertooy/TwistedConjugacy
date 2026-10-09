LoadPackage( "TwistedConjugacy" );
TWC.ASSERT := true;

TestDirectory(
    [
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
    ],
    rec(
        exitGAP := true,
        showProgress := true,
        testOptions := rec( compareFunction := "uptowhitespace" )
    )
);
