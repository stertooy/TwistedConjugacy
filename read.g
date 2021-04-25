ReadPackage( "TwistedConjugacy", "lib/HelpFunctions.gi" );
ReadPackage( "TwistedConjugacy", "lib/CoincidenceGroup.gi" );
ReadPackage( "TwistedConjugacy", "lib/TwistedConjugation.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterClasses.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterNumber.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterSpectrum.gi" );
ReadPackage( "TwistedConjugacy", "lib/ReidemeisterZeta.gi" );

if TestPackageAvailability("polycyclic",">=2.13.1") then
	ReadPackage( "TwistedConjugacy", "lib/ConvertFinitePcpToPc.gi" );
fi;
