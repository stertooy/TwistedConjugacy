LoadPackage( "TwistedConjugacy" );
ASSERT@TwistedConjugacy := true;

pass := TestDirectory(
    [
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" )
    ],
    rec(
        exitGAP := false,
        showProgress := true,
        testOptions := rec( compareFunction := "uptowhitespace" )
    )
);

if LoadPackage( "Polycyclic" ) then
    pass := TestDirectory(
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
        rec(
            exitGAP := false,
            showProgress := true,
            testOptions := rec( compareFunction := "uptowhitespace" )
        )
    ) and pass;
fi;

ForceQuitGap( pass );
