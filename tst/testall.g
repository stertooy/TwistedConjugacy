LoadPackage( "TwistedConjugacy" );
ToggleSafeMode@TwistedConjugacy();

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

ToggleSafeMode@TwistedConjugacy();
if TestPackageAvailability( "polycyclic", "2.16" ) <> fail then
    ASSERT@TwistedConjugacy := true;
    LoadPackage( "Polycyclic" );
    pass := pass and TestDirectory(
        DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
        rec(
            exitGAP := false,
            showProgress := true,
            testOptions := rec( compareFunction := "uptowhitespace" )
        )
    );
fi;

ForceQuitGap( pass );
