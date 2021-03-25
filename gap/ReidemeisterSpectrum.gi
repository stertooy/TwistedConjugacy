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


###############################################################################
##
## CoincidenceReidemeisterSpectrum( H, G )
##
InstallMethod(
	CoincidenceReidemeisterSpectrum,
	"for finite groups",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	function ( H, G )
		local Homs, Spectrum, i, j;
		Homs := AllHomomorphisms( H, G );
		Spectrum := Set([]);
		for i in [1..Length( Homs )] do
			for j in [i..Length( Homs )] do
				AddSet( Spectrum, ReidemeisterNumber( Homs[i], Homs[j] ) );
			od;
		od;
		return Spectrum;
	end
);

RedispatchOnCondition(
	CoincidenceReidemeisterSpectrum,
	true, 
	[ IsGroup, IsGroup ],
	[ IsFinite, IsFinite ],
	0
);


###############################################################################
##
## CoincidenceReidemeisterSpectrum( G )
##
InstallOtherMethod(
	CoincidenceReidemeisterSpectrum,
	[ IsGroup and IsFinite ],
	function ( G )
		local Endo, Spectrum, i, j;
		Endo := AllEndomorphisms( G );
		Spectrum := Set([]);
		for i in [1..Length( Endo )] do
			for j in [i..Length( Endo )] do
				AddSet( Spectrum, ReidemeisterNumber( Endo[i], Endo[j] ) );
			od;
		od;
		return Spectrum;
	end
);

RedispatchOnCondition(
	CoincidenceReidemeisterSpectrum,
	true, 
	[ IsGroup ],
	[ IsFinite ],
	0
);
