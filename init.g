# Introduce NC versions of preimage functions as a temporary measure
if not IsBound( PreImagesNC ) then
    BindGlobal( "PreImagesNC", PreImages );
fi;
if not IsBound( PreImagesSetNC ) then
    BindGlobal( "PreImagesSetNC", PreImagesSet );
fi;
if not IsBound( PreImagesRepresentativeNC ) then
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative );
fi;

ReadPackage( "TwistedConjugacy", "lib/TwistedConjugacy.gd" );
