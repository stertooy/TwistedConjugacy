gap> START_TEST( "Testing TwistedConjugacy for infinite PcpGroups: semidirect products" );

#
gap> N := DihedralPcpGroup( 0 );;
gap> A := Group([
>     InnerAutomorphism( N, N.1 ),
>     InnerAutomorphism( N, N.2 ),
>     GroupHomomorphismByImagesNC( N, N, [ N.1, N.2 ], [ N.1*N.2, N.2^-1 ] )
> ]);;
gap> G := AbelianPcpGroup( [ 0 ] );;
gap> alpha := GroupHomomorphismByImagesNC( G, A, [ G.1 ], [ A.1*A.3 ] );;
gap> S := SemidirectProduct( G, alpha, N );
Pcp-group with orders [ 0, 2, 0 ]
gap> e1 := Embedding( S, 1 );;
gap> e2 := Embedding( S, 2 );;
gap> p := Projection( S );;
gap> p = Projection( S );
true
gap> e1 * p = IdentityMapping( G );
true
gap> ClosureGroup( Image( e1, G ), Image( e2, N ) ) = S;
true

#
gap> N := PcGroupToPcpGroup( PcGroupCode( 5551210572, 72 ) );;
gap> A := Group([
>     InnerAutomorphismNC( N, N.2 ),
>     GroupHomomorphismByImagesNC( N, N, [ N.4, N.1*N.2 ], [ N.4*N.5, N.1*N.2^2*N.3^2*N.4 ] )
> ]);;
gap> G := PcGroupToPcpGroup( PcGroupCode( 149167619499417164, 72 ) );;
gap> alpha := GroupHomomorphismByImagesNC( G, Group( auts ), [ G.2, G.1*G.4 ], [ A.1, A.2 ] );;
gap> S := SemidirectProduct( G, alpha, N );
Pcp-group with orders [ 2, 3, 3, 2, 2, 2, 3, 3, 2, 2 ]
gap> e1 := Embedding( S, 1 );;
gap> e1 = Embedding( S, 1 );
true
gap> e2 := Embedding( S, 2 );;
gap> e2 = Embedding( S, 2 );
true
gap> p := Projection( S );;
gap> e1 * p = IdentityMapping( G );
true
gap> ClosureGroup( Image( e1, G ), Image( e2, N ) ) = S;
true

#
gap> STOP_TEST( "semidirect.tst" );
