ReadPackage( "TwistedConjugacy", "lib/HelpFunctions.gi" );
ReadPackage( "TwistedConjugacy", "lib/CoincidenceGroup.gi" );
ReadPackage( "TwistedConjugacy", "lib/Homomorphisms.gi" );
ReadPackage( "TwistedConjugacy", "lib/TwistedConjugation.gi" );
ReadPackage( "TwistedConjugacy", "lib/TwistedConjugationMultiple.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterClasses.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterNumber.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterSpectrum.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterZeta.gi" );

if TestPackageAvailability( "polycyclic", "2.15.1" ) = true then
    ReadPackage( "TwistedConjugacy", "lib/PcpGroup/HelpFunctions_Pcp.gi" );
    ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ConvertFinitePcpToPc.gi" );
fi;
