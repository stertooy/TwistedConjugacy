if SAFEMODE@ then
    CHECK_CENT@Polycyclic := true;
    CHECK_IGS@Polycyclic := true;
    CHECK_INTNORM@Polycyclic := true;
    CHECK_INTSTAB@Polycyclic := true;
    CHECK_NORM@Polycyclic := true;
    CHECK_SCHUR_PCP@Polycyclic := true;
fi;

ReadPackage( "TwistedConjugacy", "lib/pcp/helpfunctions_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/coincidencegroup_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/convert_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/reidemeisterclasses_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/reidemeisternumber_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/safemode_pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/pcp/twistedconjugation_pcp.gi" );

