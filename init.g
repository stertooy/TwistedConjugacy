# Introduce NC versions of preimage functions as a temporary measure
if not IsBound( PreImagesSetNC ) then
    BindGlobal( "PreImagesSetNC", PreImagesSet );
fi;
if not IsBound( PreImagesRepresentativeNC ) then
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative );
fi;

ReadPackage( "TwistedConjugacy", "lib/affineactions.gd" );
ReadPackage( "TwistedConjugacy", "lib/coincidencegroup.gd" );
ReadPackage( "TwistedConjugacy", "lib/cosets.gd" );
ReadPackage( "TwistedConjugacy", "lib/derivations.gd" );
ReadPackage( "TwistedConjugacy", "lib/helpfunctions.gd" );
ReadPackage( "TwistedConjugacy", "lib/homomorphisms.gd" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterclasses.gd" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisternumber.gd" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterspectrum.gd" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterzeta.gd" );
ReadPackage( "TwistedConjugacy", "lib/twistedconjugation.gd" );
