#! @Chapter reidemeisternumbers

#! @Section reidemeisternumbers

#! @BeginExample
Q := QuaternionGroup( 8 );;
phi := GroupHomomorphismByImages(
      Q, Q, [ Q.1, Q.2 ], [ Q.2, Q.1 ]
);;
ReidemeisterNumber( phi );
#! 3
D := DihedralGroup( 8 );;
psi := GroupHomomorphismByImages( Q, D, [ Q.1, Q.2 ], [ D.1 * D.2, D.3 ] );;
chi := GroupHomomorphismByImages( Q, D, [ Q.1, Q.2 ], [ D.1, D.3 ] );;
ReidemeisterNumber( psi, chi );
#! 4
#! @EndExample

#! @Section reidemeisterspectra

#! @BeginExample
ReidemeisterSpectrum( Q );
#! [ 2, 3, 5 ]
ExtendedReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 5 ]
CoincidenceReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 8 ]
CoincidenceReidemeisterSpectrum( D, Q );
#! [ 4, 8 ]
CoincidenceReidemeisterSpectrum( Q, D );
#! [ 2, 3, 4, 6, 8 ]
TotalReidemeisterSpectrum( Q );
#! [ 1, 2, 3, 4, 5, 6, 8 ]
#! @EndExample
