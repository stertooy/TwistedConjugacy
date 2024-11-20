LoadPackage( "TwistedConjugacy" );
ASSERT@TwistedConjugacy := true;

Directories_To_Test := ;

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

if TestPackageAvailability( "polycyclic", "2.16" ) <> fail then
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
