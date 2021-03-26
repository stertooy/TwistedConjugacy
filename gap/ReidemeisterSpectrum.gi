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
		return Set( 
			AllHomomorphismClasses( G, G ),
			f -> ReidemeisterNumber( f )
		);
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
	"for finite abelian groups",
	[ IsGroup and IsFinite, IsGroup and IsFinite and IsAbelian ],
	function ( H, G )
		local Homs, Spectrum, i, j;
		Homs := AllHomomorphismClasses( H, G );
		Spectrum := Set([]);
		for i in [1..Length( Homs )] do
			AddSet( Spectrum, ReidemeisterNumber( Homs[1], Homs[i] ) );
		od;
		return Spectrum;
	end
);

InstallMethod(
	CoincidenceReidemeisterSpectrum,
	"for finite non-abelian groups",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	function ( H, G )
		local Homs, Spectrum, i, j;
		Homs := AllHomomorphismClasses( H, G );
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
		return CoincidenceReidemeisterSpectrum( G, G );
	end
);

RedispatchOnCondition(
	CoincidenceReidemeisterSpectrum,
	true, 
	[ IsGroup ],
	[ IsFinite ],
	0
);
