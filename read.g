# Introduce NC versions of preimage functions as a temporary measure
if not IsBound( PreImagesSetNC ) then
    BindGlobal( "PreImagesSetNC", PreImagesSet );
fi;
if not IsBound( PreImagesRepresentativeNC ) then
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative );
fi;

BindGlobal( "TWC", rec( ASSERT := false ) );

ReadPackage( "TwistedConjugacy", "lib/affineactions.g" );
ReadPackage( "TwistedConjugacy", "lib/affineactions.gi" );
ReadPackage( "TwistedConjugacy", "lib/coincidencegroup.g" );
ReadPackage( "TwistedConjugacy", "lib/coincidencegroup.gi" );
ReadPackage( "TwistedConjugacy", "lib/cosets.gi" );
ReadPackage( "TwistedConjugacy", "lib/derivations.g" );
ReadPackage( "TwistedConjugacy", "lib/derivations.gi" );
ReadPackage( "TwistedConjugacy", "lib/homomorphisms.g" );
ReadPackage( "TwistedConjugacy", "lib/homomorphisms.gi" );
ReadPackage( "TwistedConjugacy", "lib/helpfunctions.g" );
ReadPackage( "TwistedConjugacy", "lib/helpfunctions.gi" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterclasses.g" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterclasses.gi" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisternumber.gi" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterspectrum.gi" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterzeta.g" );
ReadPackage( "TwistedConjugacy", "lib/reidemeisterzeta.gi" );
ReadPackage( "TwistedConjugacy", "lib/twistedconjugation.gi" );
