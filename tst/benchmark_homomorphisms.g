# Manual performance comparison; not part of TestDirectory.
# Run with a GAP package root pointing at this checkout, for example:
# gap -q -b -l '/tmp/twc-test-root;/opt/gap/4.16.1' tst/benchmark_homomorphisms.g
# The printed package directory must resolve to the checkout being tested.
#
# Each measurement constructs a fresh group and resets both random sources.
# Times are GAP Runtime() milliseconds, with five seeds to expose variation in
# the previous generating-pair search. Very small times have 1 ms resolution.
# The original two-generator implementation below is retained as a manual
# benchmark reference.

LoadPackage( "TwistedConjugacy" );;
Print( "Package: ", DirectoriesPackageLibrary( "TwistedConjugacy", "" ), "\n" );
twcBenchmark := rec();;

twcBenchmark.original := function( H, G )
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
                    go := Order( gens[ k ] );
                    if Random( 1, 6 ) = 1 then
                        gens[ k ] := gens[ k ] ^ (
                            go / Random( Factors( go ) )
                        );
                    fi;
                od;
            until IndexNC( H, SubgroupNC( H, gens ) ) = 1;
        fi;
        go := List( gens, Order );
        imgs := List( go, i -> Filtered(
            cl,
            j -> IsInt( i / Order( Representative( j ) ) )
        ) );
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


twcBenchmark.cases := [
    [ "D8 (pc)", function() return DihedralGroup( IsPcGroup, 8 ); end ],
    [ "D64 (pc)", function() return DihedralGroup( IsPcGroup, 64 ); end ],
    [ "D64 (perm)", function() return DihedralGroup( IsPermGroup, 64 ); end ],
    [ "SmallGroup(64,17) (pc)",
        function() return SmallGroup( 64, 17 ); end ],
    [ "SmallGroup(36,6) (pc)",
        function() return SmallGroup( 36, 6 ); end ],
    [ "SmallGroup(40,8) (pc)",
        function() return SmallGroup( 40, 8 ); end ],
    [ "SmallGroup(60,12) (pc)",
        function() return SmallGroup( 60, 12 ); end ],
    [ "SmallGroup(64,8) (pc)",
        function() return SmallGroup( 64, 8 ); end ],
    [ "SmallGroup(64,18) (pc)",
        function() return SmallGroup( 64, 18 ); end ],
    [ "SmallGroup(64,20) (pc)",
        function() return SmallGroup( 64, 20 ); end ],
    [ "S4", function() return SymmetricGroup( 4 ); end ],
    [ "A5", function() return AlternatingGroup( 5 ); end ],
    [ "PcGroupCode(1018013,28)",
        function() return PcGroupCode( 1018013, 28 ); end ],
    [ "PcGroupCode(36293,28)",
        function() return PcGroupCode( 36293, 28 ); end ],
    [ "Existing permutation group (126)", function()
        return Group( [
            (1,4,2)(3,7,5)(6,9,8)(11,16)(12,15)(13,14),
            (1,6,3)(2,8,5)(4,9,7)(10,11,12,13,14,15,16)
        ] );
    end ]
];;

twcBenchmark.run := function( makeGroup, enumerate )
    local times, counts, seed, G, start, homs;
    times := [];
    counts := [];
    for seed in [ 17, 29, 43, 71, 97 ] do
        Reset( GlobalMersenneTwister, seed );
        Reset( GlobalRandomSource, seed );
        G := makeGroup();
        start := Runtime();
        homs := enumerate( G );
        Add( times, Runtime() - start );
        Add( counts, Length( homs ) );
    od;
    if Length( Set( counts ) ) <> 1 then
        Error( "Number of homomorphism classes depends on random seed" );
    fi;
    return rec( times := times,
        medianMs := SortedList( times )[ QuoInt( Length( times ), 2 ) + 1 ],
        count := Length( homs ),
        properCount := Number( homs, hom -> not IsBijective( hom ) ) );
end;;

twcBenchmark.main := function()
    local case, include;
    for case in twcBenchmark.cases do
        Print( "\n", case[ 1 ], "\n" );
        twcBenchmark.old := twcBenchmark.run( case[ 2 ],
            G -> twcBenchmark.original( G, G ) );
        twcBenchmark.homs := twcBenchmark.run( case[ 2 ],
            G -> TWC.RepsHomClasses2Gen( G, G ) );
        twcBenchmark.full := twcBenchmark.run( case[ 2 ],
            G -> RepresentativesEndomorphismClasses( G ) );
        twcBenchmark.proper := twcBenchmark.run( case[ 2 ],
            G -> RepresentativesEndomorphismClasses( G, false ) );
        if twcBenchmark.old.count <> twcBenchmark.full.count
            or twcBenchmark.old.count <> twcBenchmark.homs.count
            or twcBenchmark.old.properCount <> twcBenchmark.proper.count then
            Error( "Number of homomorphism classes changed" );
        fi;
        Print( "  original: ", twcBenchmark.old, "\n",
               "  homs:     ", twcBenchmark.homs, "\n",
               "  full:     ", twcBenchmark.full, "\n",
               "  false:    ", twcBenchmark.proper, "\n" );
        if 2 * twcBenchmark.homs.medianMs > 3 * twcBenchmark.old.medianMs then
            Print( "  PERFORMANCE REGRESSION: exceeds 1.5x original\n" );
        fi;
    od;

    # The existing order-252 pc example has three generators, so compare the
    # public default and false branches instead of the two-generator helper.
    Print( "\nExisting pc group (252), generic public method\n" );
    for include in [ true, false ] do
        twcBenchmark.result := twcBenchmark.run(
            function() return PcGroupCode( 57308604420143, 252 ); end,
            G -> RepresentativesEndomorphismClasses( G, include )
        );
        Print( "  ", include, ": ", twcBenchmark.result, "\n" );
    od;

end;;
twcBenchmark.main();
Unbind( twcBenchmark );
QUIT;
