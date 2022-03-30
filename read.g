ReadPackage( "TwistedConjugacy", "lib/HelpFunctions.gi" );
ReadPackage( "TwistedConjugacy", "lib/CoincidenceGroup.gi" );
ReadPackage( "TwistedConjugacy", "lib/Homomorphisms.gi" );
ReadPackage( "TwistedConjugacy", "lib/TwistedConjugation.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterClasses.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterNumber.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterSpectrum.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterZeta.gi" );

if TestPackageAvailability("polycyclic","2.13.1") = true then
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/HelpFunctions_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/CoincidenceGroup_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ConvertFinitePcpToPc.gi" );
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/TwistedConjugation_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ReidemeisterClasses_Pcp.gi" );
	ReadPackage( "TwistedConjugacy", "lib/PcpGroup/ReidemeisterNumber_Pcp.gi" );
fi;

if (
	TestPackageAvailability("polycyclic","2.13.1") = true and
	TestPackageAvailability("CaratInterface","2.3.1") = true
) then
	ReadPackage( "TwistedConjugacy", "lib/CrystGroup/Homomorphisms_Cryst.gi" );
fi;
