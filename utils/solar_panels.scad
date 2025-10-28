// Solar Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2025.10.28
//---------------------------------------------------------------------------------------
use <metal_components.scad>
//---------------------------------------------------------------------------------------
module solar_panel(panel_size)
{
    difference(){
        color("silver")
            cube(panel_size);
            translate([25, 25, -1])
                cube([panel_size[0] - 50, panel_size[1] - 50, panel_size[2] - 3]);
    }
    translate([10, 10, panel_size[2]])
        color("black")
            cube([panel_size[0], panel_size[1], 2] - [20, 20, 0]);
            
// electric            
    translate([panel_size[0] - 100 - 25 - 25, panel_size[1] / 2 - 50, panel_size[2] - 20])
        color("black")
            cube([100, 100, 20]);
    
}
//---------------------------------------------------------------------------------------
module solar_panel_with_enhanced_frame(panel_size)
{
    solar_panel(panel_size);
// support; on length

    translate([25, panel_size[1] - 20 -5, 1])
        color("Silver") cube([panel_size[0] -25, 20, 20]);
        
    translate([25, 5, 1])
        color("Silver") cube([panel_size[0] -25, 20, 20]);
// support; on width
// left
    translate([5, 5, 1])
        color("Silver") cube([20, panel_size[1] - 10, 20]);
// right 
    translate([panel_size[0] - 5 - 20 - 25, 25, 1])
        color("Silver") cube([20, panel_size[1] - 10 - 40, 20]);
        
// on center
    translate([panel_size[0] / 2 - 10, 25, 1])
        color("Silver") cube([20, panel_size[1] - 10 - 40, 20]);
        
// screws
/*
    translate([panel_size[0] - 20, panel_size[1] + 20, 10])
        rotate([90, 0, 0])
            color("black") 
                cylinder(h = 100, r = 4);
*/
}
//---------------------------------------------------------------------------------------
module corner_with_bar(corner_length, top = 0, bottom = 0)
{
    corner_30_30_3(corner_length);
    translate([19, -bottom, -6])
        rotate([-90, 0, 0])
            cylinder(corner_length + top + bottom, r = 6);
    
}
//---------------------------------------------------------------------------------------
module solar_panel_with_enhanced_frame_and_support_with_bar(panel_size)
{
    
    solar_panel_with_enhanced_frame(panel_size);
// left side
    translate ([-3, 0, -3]) 
        corner_with_bar(panel_size[1], 40, 15)
        ;
// right side        
    translate ([panel_size[0] + 3, -0, -3]) 
        mirror([1, 0, 0])
            corner_with_bar(panel_size[1]);
}
//---------------------------------------------------------------------------------------
module solar_panel_with_enhanced_frame_and_support_with_hinge_bar(panel_size)
{
    solar_panel_with_enhanced_frame(panel_size);

    // left side
    // hinge            
    translate ([4, 0, -3 - 12]) {
        translate([0, -7, 0])
            hinge_bar_with_nuts(panel_size[1], 7, 25);
    }
    
    translate ([-3, 0, -3]) 
        corner_with_bar(panel_size[1], 40, 15)
        ;
        
// right side        
    translate ([panel_size[0] + 3, -0, -3]) 
        mirror([1, 0, 0])
            corner_with_bar(panel_size[1]);            
}
//---------------------------------------------------------------------------------------

//solar_panel(solar_panel_front_size);

//solar_panel_with_enhanced_frame([1485, 668, 30]);

solar_panel_with_enhanced_frame_and_support_with_bar([1485, 668, 30]);

//corner_with_bar(corner_length = 1000, top = 10, bottom = 30);