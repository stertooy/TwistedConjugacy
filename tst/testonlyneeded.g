LoadPackage( "TwistedConjugacy" : OnlyNeeded );;

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/PcGroup" ),
	rec(
		exitGAP := false,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/PermGroup" ),
	rec(
		exitGAP := true,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

FORCE_QUIT_GAP(1);
