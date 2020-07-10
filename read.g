ReadPackage( "TwistedConjugacy", "gap/HelpFunctions.gi" );
ReadPackage( "TwistedConjugacy", "gap/GroupConstructors.gi" );
ReadPackage( "TwistedConjugacy", "gap/TwistedConjugation.gi" );
ReadPackage( "TwistedConjugacy", "gap/ReidemeisterClasses.gi" );
ReadPackage( "TwistedConjugacy", "gap/ReidemeisterNumber.gi" );
ReadPackage( "TwistedConjugacy", "gap/ReidemeisterSpectrum.gi" );
ReadPackage( "TwistedConjugacy", "gap/ReidemeisterZeta.gi" );
if IsPackageLoaded( "aclib" ) then
	ReadPackage( "TwistedConjugacy", "gap/GroupConstructors_aclib.gi" );
	ReadPackage( "TwistedConjugacy", "gap/ReidemeisterClasses_aclib.gi" );
	ReadPackage( "TwistedConjugacy", "gap/ReidemeisterNumber_aclib.gi" );
fi;
