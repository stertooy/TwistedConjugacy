# Run with: gap -q -b --quitonbreak tst/benchmark-spectra.g
# Each sample constructs fresh inputs; group construction is not timed.
LoadPackage( "TwistedConjugacy" );;
SizeScreen( [ 200, 40 ] );;
Print( "GAP ", GAPInfo.Version, " ",
    DirectoriesPackageLibrary( "TwistedConjugacy", "" ), "\n" );
FreshSL := function()
    return Group( GeneratorsOfGroup( SL( IsPermGroup, 2, 5 ) ) );
end;;
cases := [
    [ "ordinary D64 (pc)",
      function() return [ DihedralGroup( IsPcGroup, 64 ) ]; end,
      ReidemeisterSpectrum, false ],
    [ "ordinary S4 (perm)",
      function() return [ SymmetricGroup( 4 ) ]; end,
      ReidemeisterSpectrum, false ],
    [ "extended D32 (pc)",
      function() return [ DihedralGroup( IsPcGroup, 32 ) ]; end,
      ExtendedReidemeisterSpectrum, false ],
    [ "extended G96 (pc)",
      function() return [ PcGroupCode( 553128533058418720, 96 ) ]; end,
      ExtendedReidemeisterSpectrum, false ],
    [ "coincidence D256 (pc)",
      function() return [ DihedralGroup( IsPcGroup, 256 ) ]; end,
      CoincidenceReidemeisterSpectrum, false ],
    [ "coincidence SmallGroup(32,44) (pc)",
      function() return [ SmallGroup( 32, 44 ) ]; end,
      CoincidenceReidemeisterSpectrum, false ],
    [ "coincidence S4 (perm)",
      function() return [ SymmetricGroup( 4 ) ]; end,
      CoincidenceReidemeisterSpectrum, false ],
    [ "coincidence SL(2,5) fresh (perm)",
      function() return [ FreshSL() ]; end,
      CoincidenceReidemeisterSpectrum, false ],
    [ "coincidence C4xC2 -> D16 (pc)",
      function() return [ AbelianGroup( [ 4, 2 ] ), DihedralGroup( IsPcGroup, 16 ) ]; end,
      CoincidenceReidemeisterSpectrum, false ],
    [ "total D16 (pc)",
      function() return [ DihedralGroup( IsPcGroup, 16 ) ]; end,
      TotalReidemeisterSpectrum, false ],
    [ "total A4 (perm)",
      function() return [ AlternatingGroup( 4 ) ]; end,
      TotalReidemeisterSpectrum, false ],
    [ "endomorphisms D64 (pc)",
      function() return [ DihedralGroup( IsPcGroup, 64 ) ]; end,
      RepresentativesEndomorphismClasses, true ],
    [ "endomorphisms C4xC8 excluding auts (pc)",
      function() return [ AbelianGroup( [ 4, 8 ] ), false ]; end,
      RepresentativesEndomorphismClasses, true ],
    [ "endomorphisms D8xC2 (pc)",
      function() return [ DirectProduct( DihedralGroup( IsPcGroup, 8 ), CyclicGroup( 2 ) ) ]; end,
      RepresentativesEndomorphismClasses, true ],
    [ "homomorphisms D8xC2 -> itself (pc)",
      function()
          local G;
          G := DirectProduct( DihedralGroup( IsPcGroup, 8 ), CyclicGroup( 2 ) );
          return [ G, G ];
      end,
      RepresentativesHomomorphismClasses, true ],
    [ "homomorphisms C2^3 -> S4 (pc/perm)",
      function() return [ AbelianGroup( [ 2, 2, 2 ] ), SymmetricGroup( 4 ) ]; end,
      RepresentativesHomomorphismClasses, true ]
];;
if not IsBound( repeats ) then repeats := 3; fi;;
for c in cases do
    times := [];
    for rep in [ 1 .. repeats ] do
        Reset( GlobalMersenneTwister, 1 );
        Reset( GlobalRandomSource, 1 );
        args := c[ 2 ]();
        GASMAN( "collect" );
        start := Runtime();
        result := CallFuncList( c[ 3 ], args );
        Add( times, Runtime() - start );
        if c[ 4 ] then result := Length( result ); fi;
        if rep = 1 then
            expected := result;
        elif result <> expected then
            Error( "Results differ between repetitions: ", c[ 1 ] );
        fi;
    od;
    Print( c[ 1 ], " | ", times, " | ", result, "\n" );
od;
QUIT;
