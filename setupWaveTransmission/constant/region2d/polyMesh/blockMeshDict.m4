// Parametrized windTunnel

//Run using:
//m4 -P blockMeshDict.m4 > blockMeshDict

//m4 definitions:
m4_changecom(//)m4_changequote([,])
m4_define(calc, [m4_esyscmd(perl -e 'use Math::Trig; printf ($1)')])
m4_define(VCOUNT, 0)
m4_define(vlabel, [[// ]Vertex $1 = VCOUNT m4_define($1, VCOUNT)m4_define([VCOUNT], m4_incr(VCOUNT))])

//Lengthes
m4_define(L1, 20.)

//Heights
m4_define(H1, 1)

//Width
m4_define(W1, 0.1)

//Slope
m4_define(IS, 0.001)

//Bottom elevations
m4_define(S0, 0.8)

//Top elevations
m4_define(S0top, calc(S0 + H1))

//plane A
m4_define(xA, 0)

//plane B
m4_define(xB, calc(xA+L1))

//Numbers of cells in y- and z-direction
m4_define(cellsZ1, 1)

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
	(xA 0 S0) vlabel(A0)
	(xA W1 S0) vlabel(A1)
	(xA 0 S0top) vlabel(A2)
	(xA W1 S0top) vlabel(A3)
	
	// plane B
	(xB 0 S0) vlabel(B2)
	(xB W1 S0) vlabel(B3)
	(xB 0 S0top) vlabel(B4)
	(xB W1 S0top) vlabel(B5)

);

blocks          
(
    // Section A	
    hex (A0 B2 B3 A1 A2 B4 B5 A3) (200 1 cellsZ1) simpleGrading (1 1 1)
);

edges           
(
);

patches         
(
	patch front2d
	(
	(A0 A2 A3 A1)	
	)

	patch back2d
	(
	(B2 B3 B5 B4)
	)

	empty bottom2d
	(
	(A0 A1 B3 B2)
	)

	empty top2d
	(
	(A2 B4 B5 A3)
	)

	empty walls2d
	(
	(A0 B2 B4 A2)
	(A1 A3 B5 B3)
	)

);

mergePatchPairs
(
);

// ************************************************************************* //
