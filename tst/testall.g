LoadPackage( "TwistedConjugacy" );
TWC_ASSERT := true;
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
    CHECK_CENT@Polycyclic := true;
    CHECK_IGS@Polycyclic := true;
    CHECK_INTSTAB@Polycyclic := true;
    pass := TestDirectory(
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
        testOpts
    ) and pass;
fi;

ForceQuitGap( pass );
