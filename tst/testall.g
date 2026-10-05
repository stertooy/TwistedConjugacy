LoadPackage( "TwistedConjugacy" );
TWC.ASSERT := true;
testOpts := rec(
    exitGAP := false,
    showProgress := true,
    testOptions := rec( compareFunction := "uptowhitespace" )
);

pass := TestDirectory(
    [
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" )
    ],
    testOpts
);

if IsPackageLoaded( "Polycyclic" ) then
    pass := TestDirectory(
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
        testOpts
    ) and pass;
fi;

ForceQuitGap( pass );
