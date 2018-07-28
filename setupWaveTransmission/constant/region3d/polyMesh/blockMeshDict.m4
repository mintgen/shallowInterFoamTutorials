// Parametrized windTunnel

//Run using:
//m4 -P blockMeshDict.m4 > blockMeshDict

//m4 definitions:
m4_changecom(//)m4_changequote([,])
m4_define(calc, [m4_esyscmd(perl -e 'use Math::Trig; printf ($1)')])
m4_define(VCOUNT, 0)
m4_define(vlabel, [[// ]Vertex $1 = VCOUNT m4_define($1, VCOUNT)m4_define([VCOUNT], m4_incr(VCOUNT))])

//Lengthes
m4_define(L1, 55.)
m4_define(L2, 5.)

//Heights
m4_define(H1, 3.)
m4_define(H2, 3.)

//Width
m4_define(W1, 0.1)

//Slope
m4_define(IS, 0.001)

//Bottom elevations
m4_define(S0, 1000)
//m4_define(SIN, calc(S0 + IS1 * L1))
//m4_define(SOUT, calc(S0 - IS2 * L5))

//Top elevations
m4_define(S0top, calc(S0 + H1))
//m4_define(SINtop, calc(SIN + Height))
//m4_define(SOUTtop, calc(SOUT + Height))

//plane A
m4_define(xA, 20)

//plane B
m4_define(xB, calc(xA+L1))

//plane C 
m4_define(xC, calc(xB+L2))

//Numbers of cells in y- and z-direction
m4_define(cellsZ1, 300)
m4_define(cellsZ2, 300)

/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  1.7.1                                 |
|   \\  /    A nd           | Web:      www.OpenFOAM.com                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;

    root            "";
    case            "";
    instance        "";
    local           "";

    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

convertToMeters 1;

vertices        
(
	// plane A
	(xA 0 0) vlabel(A0)
	(xA W1 0) vlabel(A1)
	(xA 0 H1) vlabel(A2)
	(xA W1 H1) vlabel(A3)
	
	// plane B
	(xB 0 calc(0 - L1 * IS - H2)) vlabel(B0)
	(xB W1 calc(0 - L1 * IS - H2)) vlabel(B1)
	(xB 0 calc(0 - L1 * IS)) vlabel(B2)
	(xB W1 calc(0 - L1 * IS)) vlabel(B3)
	(xB 0 calc(0 - L1 * IS + H1)) vlabel(B4)
	(xB W1 calc(0 - L1 * IS + H1)) vlabel(B5)
	
	// plane C
	(xC 0 calc(0 - (L1 + L2) * IS - H2)) vlabel(C0)
	(xC W1 calc(0 - (L1 + L2) * IS - H2)) vlabel(C1)
	(xC 0 calc(0 - (L1 + L2) * IS)) vlabel(C2)
	(xC W1 calc(0 - (L1 + L2) * IS)) vlabel(C3)
	(xC 0 calc(0 - (L1 + L2) * IS + H1)) vlabel(C4)
	(xC W1 calc(0 - (L1 + L2) * IS + H1)) vlabel(C5)
	
);

blocks          
(
    // Section A	
    hex (A0 B2 B3 A1 A2 B4 B5 A3) (550 1 cellsZ1) simpleGrading (1 1 1)
    // Section B
    hex (B2 C2 C3 B3 B4 C4 C5 B5) (50 1 cellsZ1) simpleGrading (1 1 1)
    // Section C
    hex (B0 C0 C1 B1 B2 C2 C3 B3) (50 1 cellsZ2) simpleGrading (1 1 1)
);

edges           
(
);

patches         
(
	patch frontA
	(
	(A0 A2 A3 A1)	
	)

	patch frontC
	(
	(B0 B2 B3 B1)	
	)

	patch backB
	(
	(C2 C3 C5 C4)
	)

	patch backC
	(
	(C0 C1 C3 C2)
	)

	wall bottomA
	(
	(A0 A1 B3 B2)
	)

	patch bottomC
	(
	(B0 B1 C1 C0)
	)

	patch topA
	(
	(A2 B4 B5 A3)
	)

	patch topB
	(
	(B4 C4 C5 B5)
	)

	empty wallsAll
	(
	(A0 B2 B4 A2)
	(A1 A3 B5 B3)
	(B2 C2 C4 B4)
	(B3 B5 C5 C3)
	(B0 C0 C2 B2)
	(B1 B3 C3 C1)
	)

);

mergePatchPairs
(
);

// ************************************************************************* //
