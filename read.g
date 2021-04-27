ReadPackage( "TwistedConjugacy", "lib/HelpFunctions.gi" );
ReadPackage( "TwistedConjugacy", "lib/CoincidenceGroup.gi" );
ReadPackage( "TwistedConjugacy", "lib/TwistedConjugation.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterClasses.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterNumber.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterSpectrum.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterZeta.gi" );

if TestPackageAvailability("polycyclic","2.13.1") = true then
	ReadPackage( "TwistedConjugacy", "lib/HelpFunctions_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/CoincidenceGroup_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/ConvertFinitePcpToPc.gi" );
	ReadPackage( "TwistedConjugacy", "lib/TwistedConjugation_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/ReidemeisterClasses_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/ReidemeisterNumber_Pcp.gi" );
fi;
