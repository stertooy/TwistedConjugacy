###############################################################################
##
## ReidemeisterSpectrum( G )
##
InstallMethod(
	ReidemeisterSpectrum, 
	"for finite groups",
	[ IsGroup and IsFinite ],
	function ( G )
		local Aut, Inn, p, RepsAut;
		Aut := AutomorphismGroup( G );
		Inn := InnerAutomorphismsAutomorphismGroup( Aut );
		p := NaturalHomomorphismByNormalSubgroupNC( Aut, Inn );
		RepsAut := List(
			ConjugacyClasses( Image( p ) ), 
			cc -> PreImagesRepresentative( p, Representative( cc ) ) 
		);
		return Set( RepsAut, f -> ReidemeisterNumber( f ) );
	end 
);

RedispatchOnCondition(
	ReidemeisterSpectrum,
	true, 
	[ IsGroup ],
	[ IsFinite ],
	0
);


###############################################################################
##
## ExtendedReidemeisterSpectrum( G )
##
InstallMethod(
	ExtendedReidemeisterSpectrum,
	"for finite groups",
	[ IsGroup and IsFinite ],
	function ( G )
		return Set( AllEndomorphisms( G ), f -> ReidemeisterNumber( f ) );
	end
);

RedispatchOnCondition(
	ExtendedReidemeisterSpectrum,
	true, 
	[ IsGroup ],
	[ IsFinite ],
	0
);
