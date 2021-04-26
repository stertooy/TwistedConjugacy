LoadPackage( "TwistedConjugacy" : OnlyNeeded );

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/pcgroup" ),
	rec(
		exitGAP := false,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

TestDirectory(
	DirectoriesPackageLibrary( "TwistedConjugacy", "tst/permgroup" ),
	rec(
		exitGAP := true,
		testOptions := rec(compareFunction := "uptowhitespace")
	)
);

FORCE_QUIT_GAP(1);
