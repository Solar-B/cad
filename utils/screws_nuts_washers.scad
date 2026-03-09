// Solar-Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT
// -----------------------------------------------------------------------------------
include <screws_nuts_washers_params.scad>
include <tolerances.scad>
//------------------------------------------------------------------------------------
module screw_sunken(screw_radius, screw_length, head_radius, head_thick)
{
	color ("grey")
	difference(){
		union(){
			cylinder (h = head_thick, r1 = head_radius, r2 = screw_radius, $fn = 30);
			cylinder (h = screw_length, r = screw_radius, $fn = 30);
		}
		translate ([-head_radius, -0.75, 0] - display_tolerance_z) cube([2 * head_radius, 1.5, head_thick - 0.5 + display_tolerance]);
	}
}
//------------------------------------------------------------------------------------
module nut (internal_radius, external_radius, height)
{
	color ("grey")
	difference() {
		cylinder ( h = height, r = external_radius, $fn = 6);
		translate ([0, 0, -tolerance]) cylinder ( h = height + 2 * tolerance, r = internal_radius, $fn = 30);
	}
}
//--------------------------------------------------------------
module autolock_nut (internal_radius, external_radius, height)
{
	color ("grey")
	difference() {
		union(){
			cylinder ( h = height - 1, r = external_radius, $fn = 6);
			translate ([0, 0, height - 1]) cylinder ( h = 1, r = internal_radius + 1, $fn = 30);
		}
		translate ([0, 0, -tolerance]) cylinder ( h = height + 2 * tolerance, r = internal_radius, $fn = 30);
	}
}
//--------------------------------------------------------------
module screw_hexa(screw_radius, screw_length, head_radius, head_thick)
{
	color ("grey")
	union(){
		cylinder (h = head_thick, r = head_radius, $fn = 6);
		translate ([0, 0, head_thick]) cylinder (h = screw_length, r = screw_radius, $fn = 30);
	}
}
//--------------------------------------------------------------
module screw_M8_sunken(length)
{
	screw_sunken(M8_screw_radius, length, M8_nut_radius, M8_nut_thick);
}
//------------------------------------------------------------------------------------
module screw_M6_hexa(length)
{
	screw_hexa(M6_screw_radius, length, M6_nut_radius, M6_nut_thick);
}
//------------------------------------------------------------------------------------
module screw_M8_hexa(length)
{
	screw_hexa(M8_screw_radius, length, M8_nut_radius, M8_nut_thick);
}
//------------------------------------------------------------------------------------
module screw_M16_hexa(length)
{
	screw_hexa(M16_screw_radius, length, M16_nut_radius, M16_nut_thick);
}
//------------------------------------------------------------------------------------
module screw_M14_hexa(length)
{
	screw_hexa(M14_screw_radius, length, M14_nut_radius, M14_nut_thick);
}
//------------------------------------------------------------------------------------

screw_M6_hexa(100);