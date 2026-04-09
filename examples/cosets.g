#! @Chapter cosets

#! @Section rightcosets

#! @BeginExample
G := ExamplesOfSomePcpGroups( 5 );;
H := Subgroup( G, [ G.1 * G.2 ^ -1, G.3 ^ 2 ] );;
K := Subgroup( G, [ G.1 ^ 2, G.2 * G.3 ] );;
x := G.1 * G.3 ^ -1;;
y := G.1 * G.2 ^ 2 * G.3;;
z := G.3 * G.4 ^ -1;;
Hx := RightCoset( H, x );;
Ky := RightCoset( K, y );;
Intersection( Hx, Ky );
#! RightCoset(<group with 1 generator>,<object>)
Kz := RightCoset( K, z );;
Intersection( Hx, Kz );
#! [  ]
#! @EndExample

#! @Section doublecosets

#! @BeginExample
HxK := DoubleCoset( H, x, K );;
HzK := DoubleCoset( H, z, K );;
y in HxK;
#! true
HxK = HzK;
#! false
DoubleCosets( G, H, K );
#! [ DoubleCoset(<group with 2 generators>,<object>,
#!               <group of size infinity with 2 generators>),
#!   DoubleCoset(<group with 2 generators>,<object>,
#!               <group of size infinity with 2 generators>) ]
DoubleCosetIndex( G, H, K );
#! 2
#! @EndExample
