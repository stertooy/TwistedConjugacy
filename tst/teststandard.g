LoadPackage( "TwistedConjugacy" );;

if TestPackageAvailability("polycyclic","2.13.1") = true then
	TestDirectory(
		DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcpgroup" ),
		rec(
			exitGAP := false,
			testOptions := rec(compareFunction := "uptowhitespace")
		)
	);
fi;

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
	rec(
		exitGAP := false,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permroup" ),
	rec(
		exitGAP := true,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

FORCE_QUIT_GAP(1);
