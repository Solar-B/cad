// Solar-Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT
//--------------------------------------------------------------
include <bearings_params.scad>
include <tolerances.scad>
//--------------------------------------------------------------
module bearing_axial(external_radius, internal_radius, height)
{
    difference(){
        color("silver")
        cylinder(h = height, r = external_radius, $fn = 100);
        translate (-display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = internal_radius, $fn = 100);
    }
}
//--------------------------------------------------------------
module bearing_axial_51203()
{
    bearing_axial(external_radius = tb_51203_external_radius, internal_radius = tb_51203_internal_radius, height = tb_51203_height);
}
//--------------------------------------------------------------
module bearing_conic_30202()
{
    bearing_axial(external_radius = tb_30202_external_radius, internal_radius = tb_30202_internal_radius, height = tb_30202_height);
}
//--------------------------------------------------------------

bearing_conic_30202();