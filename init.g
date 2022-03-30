ReadPackage( "TwistedConjugacy", "lib/TwistedConjugacy.gd" );
if (
	TestPackageAvailability("polycyclic","2.13.1") = true and
	TestPackageAvailability("CaratInterface","2.3.1") = true
) then
	ReadPackage( "TwistedConjugacy", "lib/CrystGroup/TwistedConjugacy_Cryst.gd" );
fi;
