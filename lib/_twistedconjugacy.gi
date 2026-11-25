BindGlobal( "TWC", rec( ASSERT := false ) );

# Introduce NC versions of preimage functions as a temporary measure
if not IsBound( PreImagesElmNC ) then
    BindGlobal( "PreImagesElmNC", PreImagesElm );
fi;

if not IsBound( PreImagesSetNC ) then
    BindGlobal( "PreImagesSetNC", PreImagesSet );
fi;

if not IsBound( PreImagesRepresentativeNC ) then
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative );
fi;
