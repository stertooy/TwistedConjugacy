if SAFEMODE@ then
    CHECK_CENT@Polycyclic := true;
    CHECK_IGS@Polycyclic := true;
    CHECK_INTNORM@Polycyclic := true;
    CHECK_INTSTAB@Polycyclic := true;
    CHECK_NORM@Polycyclic := true;
    CHECK_SCHUR_PCP@Polycyclic := true;
fi;

ReadPackage( "TwistedConjugacy", "lib/PcpGroup/HelpFunctions_Pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/PcpGroup/CoincidenceGroup_Pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ConvertFinitePcpToPc.gi" );
ReadPackage( "TwistedConjugacy", "lib/PcpGroup/TwistedConjugation_Pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ReidemeisterClasses_Pcp.gi" );
ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ReidemeisterNumber_Pcp.gi" );

