OuterAutomorphismInfo := function( G )
	local Aut, Inn, p, Out;
	Aut := AutomorphismGroup( G );
	Inn := InnerAutomorphismsAutomorphismGroup( Aut );
	p := NaturalHomomorphismByNormalSubgroupNC( Aut, Inn );
    return [ p, ImagesSource( p ) ];
end;



fingerprint := function( G )
	if IdGroupsAvailable( Size( G ) ) then
		return IdGroup( G );
	else 
		return Collected( List(
			ConjugacyClasses( G ),
			x -> [ Order( Representative( x ) ), Size(x) ]
		));
	fi;
end;
  
  
asAuto := function( G, hom ) 
	return ImagesSet( hom, G );
end;


###############################################################################
##
## RepresentativesHomomorphismClasses( H, G )
##
InstallMethod(
	RepresentativesHomomorphismClasses,
	"for 2-generated source",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
    1,
	function ( H, G )
        local s;
        s := SmallGeneratingSet( H );
        if Size( s ) > 2 and IsFinite( H ) then
            TryNextMethod();
        fi;
		return AllHomomorphismClasses( H, G );
	end
);

InstallMethod(
	RepresentativesHomomorphismClasses,
    "for abitrary finite groups",
	[ IsGroup and IsFinite, IsGroup and IsFinite ],
    0,
    function( H, G )
        local isEndo, cl, c, AutH, AutG, OutH, Conj, Imgs, Kers, KerOrbits, e, kerOrbit, N, isoRepsN, p, Q, idQ, possibleImgs, le, M, iso, m, i, Outs2, j, k, A, B, C, imgOrbit, ImgOrbits, isoRepsM, l, jk;
        isEndo := H = G;
        if not isEndo and IsAbelian( G ) and not IsAbelian( H ) then
            p := NaturalHomomorphismByNormalSubgroupNC( H, DerivedSubgroup( H ) );
            return List( RepresentativesHomomorphismClasses( ImagesSource( p ), G ), function ( x )
                    return p * x;
                end );
        fi;
        if IsTrivial( G ) then
            return [ GroupHomomorphismByFunction( H, G, x -> One( G ) ) ];
        elif IsTrivial( H ) then
            return [ GroupHomomorphismByImagesNC( H, G, [ One( H ) ], [ One( G ) ] ) ];
        elif IsCyclic( H ) then
            k := MinimalGeneratingSet( H )[1];
            c := Order( k );
            if IsAbelian( G ) then
                cl := List( G );
            else
                cl := List( ConjugacyClasses( G ), Representative );
            fi;
            cl := Filtered( cl, x -> IsInt( c / Order( x ) ) );
            return List( cl, x -> GroupHomomorphismByImagesNC( H, G, [ k ], [ x ] ) );
        fi;
        AutH := AutomorphismGroup( H );
        AutG := AutomorphismGroup( G );
        Conj := ConjugacyClassesSubgroups( G );
        Imgs := List( ConjugacyClassesSubgroups( G ), Representative );
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
                OutH := OuterAutomorphismInfo( H );
                Append( e, List( OutH[2], x -> PreImagesRepresentative( OutH[1], x ) ) );
                continue;
            fi;
            p := NaturalHomomorphismByNormalSubgroupNC( H, N );
            Q := ImagesSource( p );
            possibleImgs := Filtered( Imgs, x-> Size( x ) = Size( Q ) );
            if IsEmpty( possibleImgs ) then
                continue;
            fi;
            idQ := fingerprint( Q );
            isoRepsN := List( kerOrbit, x -> RepresentativeAction( AutH, N, x, asAuto ) );
            possibleImgs := Filtered( possibleImgs, x -> fingerprint( x ) = idQ );
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
    end
);