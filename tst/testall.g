LoadPackage( "TwistedConjugacy" );
ASSERT@TwistedConjugacy := true;

Directories_To_Test := [
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" )
];

if TestPackageAvailability( "polycyclic", "2.16" ) = true then
	Append(
		Directories_To_Test,
		DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" )
	);
fi;

TestDirectory(
	Directories_To_Test,
	rec(
		exitGAP := true,
		testOptions := rec( compareFunction := "uptowhitespace" )
	)
);

FORCE_QUIT_GAP( 1 );
