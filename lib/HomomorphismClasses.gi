###############################################################################
##
## InducedHomomorphism( epi1, epi2, hom )
##
InstallGlobalFunction(
	InducedHomomorphism,
	function ( epi1, epi2, hom )
		local GM, HN, ind, inv;
		GM := ImagesSource( epi2 );
		HN := ImagesSource( epi1 );
		ind := function( h )
			return ImagesRepresentative(
				epi2, ImagesRepresentative(
					hom, PreImagesRepresentative(
						epi1, h
					)
				)
			);
		end;
		inv := function( g )
			return ImagesRepresentative(
				epi1, PreImagesRepresentative(
					hom, PreImagesRepresentative(
						epi2, g
					)
				)
			);
		end;
		return GroupHomomorphismByFunction(	HN, GM, ind, false, inv );
	end
);


###############################################################################
##
## RestrictedHomomorphism( hom, N, M )
##
InstallGlobalFunction(
	RestrictedHomomorphism,
	function ( hom, N, M )
		local res, inv;
		res := function( n )
			return ImagesRepresentative( hom, n );
		end;
		inv := function( m )
			return PreImagesRepresentative( hom, m );
		end;
		return GroupHomomorphismByFunction( N, M, res, false, inv );
	end
);


###############################################################################
##
## RepresentativesHomomorphismClasses( H, G )
##
InstallGlobalFunction(
	RepresentativesHomomorphismClasses,
	function ( H, G )
		IsFinite( H );
		IsAbelian( H );
		IsFinite( G );
		IsAbelian( G );
		return RepresentativesHomomorphismClassesOp( H, G );
	end
);


###############################################################################
##
## RepresentativesHomomorphismClasses2Generated@( G )
##
##  Note: this is essentially the code of AllHomomorphismClasses, but with some
##  minor changes to remove redundant code. It assumes H is generated by
##  exactly 2 elements.
##
RepresentativesHomomorphismClasses2Generated@ := function( H, G )
	local cl, cnt, bg, bw, bo, bi, k, gens, go, imgs, params, i, prod;
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
						gens[k] := gens[k] ^ ( go / Random( Factors( go ) ) );
					fi;
				od;
			until IndexNC( H, SubgroupNC( H, gens ) ) = 1;
		fi;
		go := List( gens, Order );
		imgs := List( go, i -> Filtered( 
			cl, 
			j -> IsInt( i / Order( Representative( j ) ) )
		));
		prod := Product( imgs, i -> Sum( i, Size ) );
		if prod < bw then
			bg := gens;
			bo := go;
			bi := imgs;
			bw := prod;
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


###############################################################################
##
## RepresentativesHomomorphismClassesOp( H, G )
##
InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for trivial source",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	5,
	function ( H, G )
		if not IsTrivial( H ) then TryNextMethod(); fi;
		return [ GroupHomomorphismByImagesNC( 
			H, G,
			[ One( H ) ], [ One( G ) ]
		)];
	end
);

InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for trivial range",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	4,
	function ( H, G )
		if not IsTrivial( G ) then TryNextMethod(); fi;
		return [ GroupHomomorphismByFunction( 
			H, G,
			h -> One( G )
		)];
	end
);

InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for non-abelian source and abelian range",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	3,
	function ( H, G )
		local p;
		if (
			IsAbelian( H ) or 
			not IsAbelian( G )
		) then TryNextMethod(); fi;
		p := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
		return List( 
		RepresentativesHomomorphismClasses( ImagesSource( p ), G ),
			hom -> p*hom
		);
	end
);

InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for finite cyclic source and finite range",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	2,
	function ( H, G )
		local h, o, L;
		if not IsCyclic( H ) then TryNextMethod(); fi;
		h := MinimalGeneratingSet( H )[1];
		o := Order( h );
		if IsAbelian( G ) then
			L := List( G );
		else
			L := List( ConjugacyClasses( G ), Representative );
		fi;
		L := Filtered( L, g -> IsInt( o / Order( g ) ) );
		return List( L, g -> GroupHomomorphismByImagesNC( 
			H, G,
			[ h ], [ g ]
		));
	end
);

InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for finite 2-generated source and finite range",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	1,
	function ( H, G )
		if Size( SmallGeneratingSet( H ) ) > 2 then TryNextMethod(); fi;
		return RepresentativesHomomorphismClasses2Generated@( H, G );
	end
);

InstallMethod(
	RepresentativesHomomorphismClassesOp,
	"for abitrary finite groups",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
	0,
	function( H, G )
		local asAuto, AutH, AutG, gensAutG, gensAutH, Conj, c, r, ImgReps,
		ImgOrbits, KerOrbits, Pairs, Heads, i, kerOrbit, N, possibleImgs, p, Q,
		idQ, head, Tails, j, imgOrbit, M, AutM, InnGM, tail, e, iso;

		# Step 1: Determine automorphism groups of H and G
		asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
		AutH := AutomorphismGroup( H );
		AutG := AutomorphismGroup( G );
		gensAutG := SmallGeneratingSet( AutG );
		gensAutH := SmallGeneratingSet( AutH );
		
		# Step 2: Determine all possible kernels and images, i.e.
		# the normal subgroups of H and the subgroups of G
		Conj := ConjugacyClassesSubgroups( G );
		for c in Conj do
			r := Representative( c );
			SetNormalizerInParent( r, StabilizerOfExternalSet( c ) );
		od;
		
		ImgReps := List( Conj, Representative );
		ImgOrbits := OrbitsDomain(
			AutG, Flat( List( Conj, List ) ),
			gensAutG, gensAutG,
			asAuto
		);
		ImgOrbits := List( ImgOrbits, x -> Filtered( ImgReps, y -> y in x ) );
		KerOrbits := OrbitsDomain(
			AutH, NormalSubgroups( H ),
			gensAutH, gensAutH,
			asAuto
		);
		
		# Step 3: Calculate info on kernels
		Pairs := [];
		Heads := [];
		for i in [ 1 .. Size( KerOrbits ) ] do
			kerOrbit := KerOrbits[i];
			N := kerOrbit[1];
			possibleImgs := Filtered( 
				[ 1 .. Size( ImgOrbits ) ], j ->
				Size( ImgOrbits[j][1] ) = IndexNC( H, N )
			);
			if IsEmpty( possibleImgs ) then
				continue;
			fi;
			p := NaturalHomomorphismByNormalSubgroupNC( H, N );
			Q := ImagesSource( p );
			p := RestrictedHomomorphism( p, H, Q );
			idQ := Fingerprint@( Q );
			possibleImgs := Filtered( 
				possibleImgs, 
				j -> Fingerprint@( ImgOrbits[j][1] ) = idQ
			);
			if IsEmpty( possibleImgs ) then
				continue;
			fi;
			head := List(
				kerOrbit,
				x -> RepresentativeAction( AutH, N, x, asAuto )
			);
			Heads[i] := head*p;
			Append( Pairs, List( possibleImgs, j -> [ i, j ] ) );
		od;
		
		# Step 4: Calculate info on images
		Tails := [];
		for j in Set( Pairs, x -> x[2] ) do
			imgOrbit := ImgOrbits[j];
			M := imgOrbit[1];
			AutM := AutomorphismGroup( M );
			InnGM := SubgroupNC( AutM, List( 
					GeneratorsOfGroup( NormalizerInParent( M ) ),
					g ->  ConjugatorAutomorphismNC( M, g )
			));
			head := RightTransversal( AutM, InnGM );
			tail := List( 
				imgOrbit, 
				x -> RepresentativeAction( AutG, M, x, asAuto )
			);
			head := List( head, x -> GroupHomomorphismByImagesNC( M, G,
				MappingGeneratorsImages( x )[1],
				MappingGeneratorsImages( x )[2]
			));
			Tails[j] := Flat( List( head, x -> List( tail, y -> x*y ) ) );
		od;
		
		# Step 5: Calculate the homomorphisms
		e := [];
		for i in Set( Pairs, x -> x[1] ) do
			for j in Set( Filtered( Pairs, x -> x[1] = i ), y -> y[2] ) do
				head := Heads[i];
				tail := Tails[j];
				Q := Range(head[1]);
				M := Source(tail[1]);
				iso := IsomorphismGroups( Q, M );
				if iso <> fail then
					if Length( head ) < Length( tail ) then
						head := List( head, x -> x*iso );
					else
						tail := List( tail, x -> iso*x );
					fi;
					Append( e, Flat( 
						List( head, x -> List( tail, y -> x*y ) )
					));
				fi;
			od;
		od;
		return e;
	end
);


###############################################################################
##
## RepresentativesEndomorphismClasses( H, G )
##
InstallGlobalFunction(
	RepresentativesEndomorphismClasses,
	function ( G )
		IsFinite( G );
		IsAbelian( G );
		return RepresentativesEndomorphismClassesOp( G );
	end
);


###############################################################################
##
## RepresentativesEndomorphismClassesOp( G )
##
InstallMethod(
	RepresentativesEndomorphismClassesOp,
	"for trivial group",
	[ IsGroup and IsFinite ],
	3,
	function ( G )
		if not IsTrivial( G ) then TryNextMethod(); fi;
		return [ GroupHomomorphismByImagesNC(
			G, G,
			[ One( G ) ], [ One( G ) ]
		)];
	end
);

InstallMethod(
	RepresentativesEndomorphismClassesOp,
	"for finite cyclic group",
	[ IsGroup and IsFinite ],
	2,
	function ( G )
		local g, o;
		if not IsCyclic( G ) then TryNextMethod(); fi;
		g := MinimalGeneratingSet( G )[1];
		o := Order( g );
		return List( 
			DivisorsInt( o ), 
			k -> GroupHomomorphismByImagesNC( G, G, [ g ], [ g^k ] )
		);
	end
);

InstallMethod(
	RepresentativesEndomorphismClassesOp,
	"for finite 2-generated source",
	[ IsGroup and IsFinite ],
	1,
	function ( G )
		if Size( SmallGeneratingSet( G ) ) <> 2 then TryNextMethod(); fi;
		return RepresentativesHomomorphismClasses2Generated@( G, G );
	end
);

InstallMethod(
	RepresentativesEndomorphismClassesOp,
	"for abitrary finite groups",
	[ IsGroup and IsFinite ],
	0,
	function( G )
		local asAuto, AutG, gensAutG, Conj, c, r, norm, SubReps, SubOrbits,
		Pairs, Proj, Reps, i, subOrbit, N, possibleImgs, p, Q, idQ, head,
		Tails, j, M, AutM, InnGM, tail, e, InnG, iso;

		# Step 1: Determine automorphism group of G
		asAuto := function( A, aut ) return ImagesSet( aut, A ); end;
		AutG := AutomorphismGroup( G );
		gensAutG := SmallGeneratingSet( AutG );

		# Step 2: Determine all possible kernels and images, i.e.
		# the (normal) subgroups of G
		Conj := ConjugacyClassesSubgroups( G );
		for c in Conj do
			r := Representative( c );
			norm := StabilizerOfExternalSet( c );
			SetIsNormalInParent( r, IndexNC( G, norm ) = 1 );
			SetNormalizerInParent( r, norm );
		od;

		SubReps := List( Conj, Representative );
		SubOrbits := OrbitsDomain(
			AutG, Flat( List( Conj, List ) ),
			gensAutG, gensAutG,
			asAuto
		);
		SubOrbits := List( SubOrbits, x -> Filtered( SubReps, y -> y in x ) );

		# Step 3: Calculate info on kernels
		Pairs := [];
		Proj := [];
		Reps := [];
		for i in [ 1 .. Size( SubOrbits ) ] do
			subOrbit := SubOrbits[i];
			N := subOrbit[1];
			if IsTrivial( N ) or not IsNormalInParent( N ) then
				continue;
			fi;
			possibleImgs := Filtered( 
				[ 1 .. Size( SubOrbits ) ], j ->
				Size( SubOrbits[j][1] ) = IndexNC( G, N )
			);
			if IsEmpty( possibleImgs ) then
				continue;
			fi;
			p := NaturalHomomorphismByNormalSubgroupNC( G, N );
			Q := ImagesSource( p );
			p := RestrictedHomomorphism( p, G, Q );
			idQ := Fingerprint@( Q );
			possibleImgs := Filtered( 
				possibleImgs, 
				j -> Fingerprint@( SubOrbits[j][1] ) = idQ
			);
			if IsEmpty( possibleImgs ) then
				continue;
			fi;
			Reps[i] := List( 
				subOrbit,
				x -> RepresentativeAction( AutG, N, x, asAuto )
			);
			Proj[i] := p;
			Append( Pairs, List( possibleImgs, j -> [ i, j ] ) );
		od;

		# Step 4: Calculate info on images
		Tails := [];
		for j in Set( Pairs, x -> x[2] ) do
			subOrbit := SubOrbits[j];
			M := subOrbit[1];
			AutM := AutomorphismGroup( M );
			InnGM := SubgroupNC( AutM, List( 
					GeneratorsOfGroup( NormalizerInParent( M ) ),
					g ->  ConjugatorAutomorphismNC( M, g )
			));
			head := RightTransversal( AutM, InnGM );
			if not IsBound( Reps[j] ) then
				tail := List(
					subOrbit,
					x -> RepresentativeAction( AutG, M, x, asAuto )
				);
			else
				tail := Reps[j];
			fi;
			head := List( head, x -> GroupHomomorphismByImagesNC( M, G,
				MappingGeneratorsImages( x )[1],
				MappingGeneratorsImages( x )[2]
			));
			Tails[j] := Flat( List( head, x -> List( tail, y -> x*y ) ) );
		od;

		e := [];
		InnG := InnerAutomorphismsAutomorphismGroup( AutG );
		Append( e, List( RightTransversal( AutG, InnG ) ) );

		# Step 5: Calculate the homomorphisms
		for i in Set( Pairs, x -> x[1] ) do
			for j in Set( Filtered( Pairs, x -> x[1] = i ), y -> y[2] ) do
				head := Reps[i];
				tail := Tails[j];
				p := Proj[i];
				Q := Range(p);
				M := Source(tail[1]);
				iso := IsomorphismGroups( Q, M );
				if iso <> fail then
					iso := p*iso;
					if Length( head ) < Length( tail ) then
						head := List( head, x -> x*iso );
					else
						tail := List( tail, x -> iso*x );
					fi;
					Append( e, Flat(
						List( head, x -> List( tail, y -> x*y ) )
					));
				fi;
			od;
		od;
		return e;
	end
);
