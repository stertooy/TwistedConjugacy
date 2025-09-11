###############################################################################
##
## ReidemeisterZetaCoefficients( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G (optional)
##
##  OUTPUT:
##      P:          single period of the periodic sequence P_n
##      Q:          non-zero part of the eventually zero sequence Q_n
##
##  REMARKS:
##      For every n, R(endo1^n,endo2^n) = P_n + Q_n
##
InstallGlobalFunction(
    ReidemeisterZetaCoefficients,
    function( endo1, arg... )
        local G, endo2;
        G := Range( endo1 );
        if Length( arg ) = 0 then
            endo2 := IdentityMapping( G );
        else
            endo2 := arg[1];
        fi;
        return ReidemeisterZetaCoefficientsOp( endo1, endo2 );
    end
);

###############################################################################
##
## ReidemeisterZetaCoefficientsOp( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G (optional)
##
##  OUTPUT:
##      P:          single period of the periodic sequence P_n
##      Q:          non-zero part of the eventually zero sequence Q_n
##
##  REMARKS:
##      For every n, R(endo1^n,endo2^n) = P_n + Q_n
##
InstallMethod(
    ReidemeisterZetaCoefficientsOp,
    "for finite groups",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    function( endo1, endo2 )
        local G, k, l, steps, G1, G2, endo, R, P, Q;
        G := Range( endo1 );
        if not IsFinite( G ) then TryNextMethod(); fi;
        k := 1;
        l := 0;
        for endo in [ endo1, endo2 ] do
            steps := -1;
            G2 := G;
            repeat
                steps := steps + 1;
                G1 := G2;
                G2 := ImagesSet( endo, G1 );
            until G1 = G2;
            k := LcmInt( k, Order( RestrictedHomomorphism( endo, G1, G1 ) ) );
            l := Maximum( l, steps );
        od;
        R := List(
            [ 1 .. k + l ], n -> ReidemeisterNumberOp( endo1 ^ n, endo2 ^ n )
        );
        R := Concatenation(
            R{ [ 1 .. l ] },
            TWC_RemovePeriodsList( R{[ 1 + l .. k + l ] })
        );
        k := Length( R ) - l;
        P := List( [ 1 .. k ], n -> R[ ( n - l - 1 ) mod k + 1 + l ] );
        Q := List( [ 1 .. l ], n -> R[n] - P[ ( n - 1 ) mod k + 1 ] );
        ShrinkRowVector( Q );
        return [ P, Q ];
    end
);

###############################################################################
##
## IsRationalReidemeisterZeta( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G (optional)
##
##  OUTPUT:
##      bool:       true if the Reidemeister zeta function of endo1 and endo2
##                  is rational
##
InstallGlobalFunction(
    IsRationalReidemeisterZeta,
    function( endo1, arg... )
        local G, endo2;
        G := Range( endo1 );
        if Length( arg ) = 0 then
            endo2 := IdentityMapping( G );
        else
            endo2 := arg[1];
        fi;
        return IsRationalReidemeisterZetaOp( endo1, endo2 );
    end
);

###############################################################################
##
## IsRationalReidemeisterZetaOp( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G
##
##  OUTPUT:
##      bool:       true if the Reidemeister zeta function of endo1 and endo2
##                  is rational
##
InstallMethod(
    IsRationalReidemeisterZetaOp,
    "for finite groups",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    function( endo1, endo2 )
        local G, coeffs;
        G := Range( endo1 );
        if not IsFinite( G ) then TryNextMethod(); fi;
        if
            ( IsBijective( endo1 ) or IsBijective( endo2 ) ) and
            endo1 * endo2 = endo2 * endo1
        then
            return true;
        fi;
        coeffs := ReidemeisterZetaCoefficientsOp( endo1, endo2 );
        if (
            not IsEmpty( coeffs[2] ) or
            TWC_DecomposePeriodicList( coeffs[1] ) = fail
        ) then
            return false;
        fi;
        return true;
    end
);

###############################################################################
##
## ReidemeisterZeta( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G (optional)
##
##  OUTPUT:
##      func:       the Reidemeister zeta function of endo1 and endo2
##
InstallGlobalFunction(
    ReidemeisterZeta,
    function( endo1, arg... )
        local G, endo2;
        G := Range( endo1 );
        if Length( arg ) = 0 then
            endo2 := IdentityMapping( G );
        else
            endo2 := arg[1];
        fi;
        return ReidemeisterZetaOp( endo1, endo2 );
    end
);

###############################################################################
##
## ReidemeisterZetaOp( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G
##
##  OUTPUT:
##      func:       the Reidemeister zeta function of endo1 and endo2
##
InstallMethod(
    ReidemeisterZetaOp,
    "for rational Reidemeister zeta functions of finite groups",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    function( endo1, endo2 )
        local G, coeffs, p;
        G := Range( endo1 );
        if not IsFinite( G ) then TryNextMethod(); fi;
        coeffs := ReidemeisterZetaCoefficientsOp( endo1, endo2 );
        if not IsEmpty( coeffs[2] ) then
            return fail;
        fi;
        p := TWC_DecomposePeriodicList( coeffs[1] );
        if p = fail then
            return fail;
        fi;
        return function( s )
            local zeta, i;
            zeta := 1;
            for i in [ 1 .. Length( p ) ] do
                if p[i] <> 0 then
                    zeta := zeta * ( 1 - s ^ i ) ^ -p[i];
                fi;
            od;
            return zeta;
        end;
    end
);

###############################################################################
##
## PrintReidemeisterZeta( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G (optional)
##
##  OUTPUT:
##      str:        a string containing the Reidemeister zeta function of endo1
##                  and endo2 in text form
##
InstallGlobalFunction(
    PrintReidemeisterZeta,
    function( endo1, arg... )
        local G, endo2;
        G := Range( endo1 );
        if Length( arg ) = 0 then
            endo2 := IdentityMapping( G );
        else
            endo2 := arg[1];
        fi;
        return PrintReidemeisterZetaOp( endo1, endo2 );
    end
);

###############################################################################
##
## PrintReidemeisterZetaOp( endo1, endo2 )
##
##  INPUT:
##      endo1:      endomorphism of G
##      endo2:      endomorphism of G
##
##  OUTPUT:
##      str:        a string containing the Reidemeister zeta function of endo1
##                  and endo2 in text form
##
InstallMethod(
    PrintReidemeisterZetaOp,
    "for finite groups",
    [ IsGroupHomomorphism, IsGroupHomomorphism ],
    function( endo1, endo2 )
        local G, coeffs, P, Q, q, i, qi, zeta, factors, powers, p, k, pi;
        G := Range( endo1 );
        if not IsFinite( G ) then TryNextMethod(); fi;
        coeffs := ReidemeisterZetaCoefficientsOp( endo1, endo2 );
        P := coeffs[1];
        Q := coeffs[2];
        if not IsEmpty( Q ) then
            q := "";
            for i in [ 1 .. Length( Q ) ] do
                if Q[i] = 0 then
                    continue;
                fi;
                if q <> "" and Q[i] > 0 then
                    q := Concatenation( q, "+" );
                elif Q[i] < 0 then
                    q := Concatenation( q, "-" );
                fi;
                qi := AbsInt( Q[i] ) / i;
                if qi = 1 then
                    q := Concatenation( q, "s" );
                else
                    q := Concatenation( q, PrintString( qi ), "*s" );
                fi;
                if i <> 1 then
                    q := Concatenation( q, "^", PrintString( i ) );
                fi;
            od;
            zeta := Concatenation( "exp(", q, ")" );
        else
            zeta := "";
        fi;
        factors := [];
        powers := [];
        p := TWC_DecomposePeriodicList( P );
        if p = fail then
            k := Length( P );
            for i in [ 0 .. k - 1 ] do
                pi := ValuePol( ShiftedCoeffs( P, 1 ), E(k) ^ -i ) / k;
                if pi = 0 then
                    continue;
                fi;
                if i = k / 2 then
                    Add( factors, "1+s" );
                elif i = 0 then
                    Add( factors, "1-s" );
                elif i = 1 then
                    Add( factors, Concatenation(
                        "1-E(",
                        PrintString( k ),
                        ")*s"
                    ));
                elif i = k / 2 + 1 then
                    Add( factors, Concatenation(
                        "1+E(",
                        PrintString( k ),
                        ")*s"
                    ));
                elif k mod 2 = 0 and i > k / 2 then
                    Add( factors, Concatenation(
                        "1+E(",
                        PrintString( k ),
                        ")^",
                        PrintString( i - k / 2 ),
                        "*s"
                    ));
                else
                    Add( factors, Concatenation(
                        "1-E(",
                        PrintString( k ),
                        ")^",
                        PrintString( i ),
                        "*s"
                    ));
                fi;
                Add( powers, -pi );
            od;
        else
            for i in [ 1 .. Length( p ) ] do
                if p[i] = 0 then
                    continue;
                fi;
                if i > 1 then
                    Add( factors, Concatenation( "1-s^", PrintString( i ) ) );
                else
                    Add( factors, "1-s" );
                fi;
                Add( powers, -p[i] );
            od;
        fi;
        for i in [ 1 .. Length( factors ) ] do
            if zeta <> "" then
                zeta := Concatenation( zeta, "*" );
            fi;
            zeta := Concatenation( zeta, "(", factors[i], ")" );
            if not IsPosInt( powers[i] ) then
                zeta := Concatenation(
                    zeta,
                    "^(",
                    PrintString( powers[i] ),
                    ")"
                );
            elif powers[i] <> 1 then
                zeta := Concatenation(
                    zeta,
                    "^",
                    PrintString( powers[i] )
                );
            fi;
        od;
        return zeta;
    end
);
