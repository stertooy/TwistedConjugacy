OuterAutomorphismInfo@ := function( G )
	local Aut, Inn, p, Out;
	Aut := AutomorphismGroup( G );
	Inn := InnerAutomorphismsAutomorphismGroup( Aut );
	p := NaturalHomomorphismByNormalSubgroupNC( Aut, Inn );
    return [ p, ImagesSource( p ) ];
end;

GroupFingerprint@ := function( G )
	if IdGroupsAvailable( Size( G ) ) then
		return IdGroup( G );
    elif IsAbelian( G ) then
        return Collected( AbelianInvariants( G ) );
	else 
		return Collected( List(
			ConjugacyClasses( G ),
			x -> [ Order( Representative( x ) ), Size(x) ]
		));
	fi;
end;

# Note: this is essentially the code of AllHomomorphismClasses, with minor changes
# It is assumed that SmallGeneratingSet( H ); has length 2
RepresentativesHomomorphismClasses2Generated@ := function( H, G )
	local cl, cnt, bg, bw, bo, bi, k, gens, go, imgs, params, clg, 
	vsu, c, i, blah;
	cl := ConjugacyClasses( G );
	bw := infinity;
	bo := [ 0, 0 ];
	cnt := 0;
	repeat
		if cnt = 0 then
			gens := SmallGeneratingSet( H );
		else
			repeat
				gens := [ Random( H ), Random( H ) ];
				for k in [ 1, 2 ] do
					go := Order( gens[k] );
					if Random( 1, 6 ) = 1 then
						gens[k] := gens[k] ^ (go / Random( Factors( go ) ));
					fi;
				od;
			until IndexNC( H, SubgroupNC( H, gens ) ) = 1;
		fi;
		go := List( gens, Order );
		imgs := List( go, i -> Filtered( cl, j -> IsInt( i / Order( Representative( j ) ) ) ) );
		blah := Product( imgs, i -> Sum( i, Size ) );
		if blah < bw then
			bg := gens;
			bo := go;
			bi := imgs;
			bw := blah;
		elif Set( go ) = Set( bo ) then
			cnt := cnt + Int( bw / Size( G ) * 3 );
		fi;
		cnt := cnt + 1;
	until bw / Size( G ) * 3 < cnt;
	params := rec(
		gens := bg,
		from := H
	);
	return MorClassLoop( G, bi, params, 9 );
end;

RepresentativesHomomorphismClassesGeneral@ := function( H, arg... )
	local G, asAuto, isEndo, AutH, AutG, OutH, Conj, Imgs, Kers, KerOrbits, e, kerOrbit, N, isoRepsN, p, Q, idQ, possibleImgs, le, M, iso, m, i, Outs2, j, k, A, B, C, imgOrbit, ImgOrbits, isoRepsM, l, jk;
	if Length( arg ) = 0 then
		G := H;
		isEndo := true;
	else
		G := arg[1];
		isEndo := false;
	fi;
	asAuto := function( G, hom ) return ImagesSet( hom, G ); end;
	AutH := AutomorphismGroup( H );
	AutG := AutomorphismGroup( G );
	Conj := ConjugacyClassesSubgroups( G );
	Imgs := List( Conj, Representative );
	if isEndo then
		Kers := List( Filtered( Conj, IsTrivial ), Representative );
	else
		Kers := NormalSubgroups( H );
	fi;
	KerOrbits := Orbits( AutH, Kers, asAuto );
	e:=[];
	for kerOrbit in KerOrbits do
		N := kerOrbit[1];
		if isEndo and IsTrivial( N ) then
			OutH := OuterAutomorphismInfo@( H );
			Append( e, List( OutH[2], x -> PreImagesRepresentative( OutH[1], x ) ) );
			continue;
		fi;
		p := NaturalHomomorphismByNormalSubgroupNC( H, N );
		Q := ImagesSource( p );
		possibleImgs := Filtered( Imgs, x-> Size( x ) = Size( Q ) );
		if IsEmpty( possibleImgs ) then
			continue;
		fi;
		idQ := GroupFingerprint@( Q );
		isoRepsN := List( kerOrbit, x -> RepresentativeAction( AutH, N, x, asAuto ) );
		possibleImgs := Filtered( possibleImgs, x -> GroupFingerprint@( x ) = idQ );
		ImgOrbits := Orbits( AutG, possibleImgs, asAuto );
		le:=[];
		for imgOrbit in ImgOrbits do
			imgOrbit := Filtered( imgOrbit, x -> x in Imgs ); # Get rid of duplicates up to conjugacy
			M := imgOrbit[1];
			iso := IsomorphismGroups( Q, M );
			if iso <> fail then
				isoRepsM := List( imgOrbit, x -> RepresentativeAction( AutG, M, x, asAuto ) );
				m := p*iso;
				i := GroupHomomorphismByFunction( M, G, x -> x );
				Outs2 := List( OrbitsDomain( 
					Normalizer( G, M ), 
					AutomorphismGroup( M ), 
					function( aut, g ) return aut*ConjugatorAutomorphismNC( M, g ); end
				), x -> x[1] );
				C := isoRepsM;
				if Size( isoRepsN ) < Size( Outs2 ) then
					A := List( isoRepsN, x -> x*m );
					B := Outs2;
				else
					A := isoRepsN;
					B := List( Outs2, x -> m*x );
				fi;
				if Size( Outs2 ) < Size( isoRepsM ) then
					B := List( B, x -> x*i );
					C := isoRepsM;
				else
					C := List( isoRepsM, x -> i*x );
				fi;
				for j in A do
					for k in B do
						jk := j*k;
						for l in C do
							Add( le, jk*l );
						od;
					od;
				od;
			fi;
		od;
		Append(e,le);
	od;
	return e;
end;


###############################################################################
##
## RepresentativesHomomorphismClasses( H, G )
##
InstallMethod(
	RepresentativesHomomorphismClasses,
	"for trivial source",
	[ IsGroup, IsGroup ],
    5,
	function ( H, G )
        if not IsTrivial( H ) then
            TryNextMethod();
        fi;
        return [ GroupHomomorphismByImagesNC( H, G, [ One( H ) ], [ One( G ) ] ) ];
	end
);

InstallMethod(
	RepresentativesHomomorphismClasses,
	"for trivial range",
	[ IsGroup, IsGroup ],
    4,
	function ( H, G )
        if not IsTrivial( G ) then
            TryNextMethod();
        fi;
        return [ GroupHomomorphismByFunction( H, G, h -> One( G ) ) ];
	end
);


InstallMethod(
	RepresentativesHomomorphismClasses,
	"for non-abelian source and abelian range",
	[ IsGroup, IsGroup ],
    3,
	function ( H, G )
        local p;
        if IsAbelian( H ) or not IsAbelian( G ) then
            TryNextMethod();
        fi;
        p := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
        return List( RepresentativesHomomorphismClasses( ImagesSource( p ), G ), hom -> p*hom );
	end
);

InstallMethod(
	RepresentativesHomomorphismClasses,
	"for finite cyclic source and finite range",
	[ IsGroup, IsGroup ],
    2,
	function ( H, G )
        local h, o, L;
        if not IsCyclic( H ) or not IsFinite( H ) or not IsFinite( G ) then
            TryNextMethod();
        fi;
        h := MinimalGeneratingSet( H )[1];
        o := Order( h );
        if IsAbelian( G ) then
            L := List( G );
        else
            L := List( ConjugacyClasses( G ), Representative );
        fi;
        L := Filtered( L, g -> IsInt( o / Order( g ) ) );
        return List( L, g -> GroupHomomorphismByImagesNC( H, G, [ h ], [ g ] ) );
	end
);


InstallMethod(
	RepresentativesHomomorphismClasses,
	"for finite 2-generated source",
	[ IsGroup, IsGroup ],
    1,
	function ( H, G )
        local s;
        s := SmallGeneratingSet( H );
        if Size( s ) > 2 and IsFinite( G ) or not IsFinite( H ) then
            TryNextMethod();
        fi;
		return RepresentativesHomomorphismClasses2Generated@( H, G );
	end
);

InstallMethod(
	RepresentativesHomomorphismClasses,
    "for abitrary finite groups",
	[ IsGroup, IsGroup ],
    0,
    function ( H, G )
		if not IsFinite( H ) or not IsFinite( G ) then
			TryNextMethod();
		fi;
		return RepresentativesHomomorphismClassesGeneral@( H, G );
	end
);

###############################################################################
##
## RepresentativesEndomorphismClasses( G )
##
InstallMethod(
	RepresentativesEndomorphismClasses,
	"for trivial group",
	[ IsGroup ],
    5,
	function ( G )
        if not IsTrivial( G ) then
            TryNextMethod();
        fi;
        return [ GroupHomomorphismByImagesNC( G, G, [ One( G ) ], [ One( G ) ] ) ];
	end
);


InstallMethod(
	RepresentativesEndomorphismClasses,
	"for finite cyclic group",
	[ IsGroup ],
    2,
	function ( G )
        local g, o;
        if not IsCyclic( G ) or not IsFinite( G ) then
            TryNextMethod();
        fi;
        g := MinimalGeneratingSet( G )[1];
        o := Order( g );
        return List( DivisorsInt( o ), k -> GroupHomomorphismByImagesNC( G, G, [ g ], [ g^k ] ) );
	end
);


InstallMethod(
	RepresentativesEndomorphismClasses,
	"for finite 2-generated source",
	[ IsGroup ],
    1,
	function ( G )
        local s;
        s := SmallGeneratingSet( G );
        if Size( s ) > 2 or not IsFinite( G ) then
            TryNextMethod();
        fi;
		return RepresentativesHomomorphismClasses2Generated@( G, G );
	end
);


InstallMethod(
	RepresentativesEndomorphismClasses,
    "for abitrary finite groups",
	[ IsGroup ],
    0,
    function ( G )
		if not IsFinite( G ) then
			TryNextMethod();
		fi;
		return RepresentativesHomomorphismClassesGeneral@( G );
	end
);

