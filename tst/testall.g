LoadPackage( "TwistedConjugacy" );

TestDirectory(DirectoriesPackageLibrary( "TwistedConjugacy", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1);