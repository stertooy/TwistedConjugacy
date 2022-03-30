LoadPackage( "TwistedConjugacy" );

Directories_To_Test := [
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" )
];

if TestPackageAvailability( "polycyclic", "2.13.1" ) = true then
	Append(
		Directories_To_Test,
		DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" )
	);
fi;
if (
	TestPackageAvailability( "polycyclic", "2.13.1" ) = true and
	TestPackageAvailability( "CaratInterface", "2.3.1" ) = true
) then
	Append(
		Directories_To_Test,
		DirectoriesPackageLibrary( "TwistedConjugacy", "tst/crystgroup" )
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
