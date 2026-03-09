// Solar Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2026.2.22
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
            
// electric contact
    translate([panel_size[0] - 100 - 25 - 25, panel_size[1] / 2 - 50, panel_size[2] - 20])
        color("black")
            cube([100, 100, 20]);
}
//---------------------------------------------------------------------------------------
module solar_panel_with_enhanced_frame(panel_size, _door_angle = 0, $show_panels = true)
{
    translate([0, 0, 20])
        rotate([0, -_door_angle, 0]){
        if ($show_panels == true)
            solar_panel(panel_size)
        ;
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
            
    }
        
       
    rotate([0, -_door_angle, 0])
    translate([0, 5, 0])
        color("Silver") cube([panel_size[0], 20, 20]);
        
    translate([0, panel_size[1] - 155, 0])
        color("Silver") cube([panel_size[0], 20, 20]);
        
    translate([0, panel_size[1] - 25, 0])
        color("Silver") cube([panel_size[0], 20, 20]);
        
// screws
/*
    translate([panel_size[0] - 20, panel_size[1] + 20, 10])
        rotate([90, 0, 0])
            color("black") 
                cylinder(h = 100, r = 4);
*/
}
//---------------------------------------------------------------------------------------
module corner_25_25_3_with_holes(length, hole_pos1, hole_pos2, a1, a2)
{
    difference(){
        corner_25_25_3(length);
        // holes
        translate([-1, hole_pos1, 12.5])
            rotate([0, 90, 0])
                cylinder(h = 5, r = 4);
        translate([-1, length - hole_pos2, 12.5])
            rotate([0, 90, 0])
                cylinder(h = 5, r = 4);
                
                // angle 1
        translate([0, 30, 0])
            rotate([a1, 0, 0])
                translate([-1, -50, 0])
                    cube([50, 50, 50]);
    }
}
//---------------------------------------------------------------------------------------
module solar_panel_with_enhanced_frame_and_support(panel_size, _door_angle = 0, 
    bar_offset_left_bottom = 0, 
    bar_offset_left_top = 0, 
    bar_offset_right_bottom = 0, 
    bar_offset_right_top = 0, 
    $show_panels = true)
{
    solar_panel_with_enhanced_frame(panel_size, _door_angle, $show_panels);
// left side
    translate ([-3, -bar_offset_left_bottom, -3]) 
        corner_25_25_3_with_holes(panel_size[1] + bar_offset_left_bottom + bar_offset_left_top, 30, 25, 50, 50)// these values are hard-coded
        ;
// right side        
    translate ([panel_size[0] + 3, -bar_offset_right_bottom, -3]) 
        mirror([1, 0, 0])
            difference(){
                corner_30_30_3(panel_size[1] + bar_offset_right_bottom + bar_offset_right_top);
                translate([-1, 56, 15])
                    rotate([0, 90, 0])
                        cylinder(h = 60, r = 4);
                translate([-1, 76, 15])
                    rotate([0, 90, 0])
                        cylinder(h = 50, r = 4);
// other side, bottom
                translate([-1, panel_size[1] - 55, 15])
                    rotate([0, 90, 0])
                        cylinder(h = 50, r = 4);
                translate([-1, panel_size[1] - 70, 15])
                    rotate([0, 90, 0])
                        cylinder(h = 50, r = 4);
            }
}
//---------------------------------------------------------------------------------------
module solar_wing(angle, panel_size, angle2, space, open_door_angle, offset_top, offset_bottom, $show_panels = true)
{
    rotate([0, 0, angle2])
        rotate([-angle, 0, 0])
        translate([0, space, 0]) 
            solar_panel_with_enhanced_frame_and_support(panel_size, open_door_angle, 
    bar_offset_left_bottom = offset_bottom, //52
    bar_offset_left_top = offset_top, //100, 
    bar_offset_right_bottom = 0, 
    bar_offset_right_top = 0, 
            $show_panels);
        
    rotate([0, 0, -angle2]) 
        rotate([angle, 0, 0]) 
            translate([0, - space, 0]) 
            mirror([0, 1, 0])
                solar_panel_with_enhanced_frame_and_support(panel_size, open_door_angle, 
    bar_offset_left_bottom = offset_bottom, //52, 
    bar_offset_left_top = offset_top, //100, 
    bar_offset_right_bottom = 0, 
    bar_offset_right_top = 0, 
                $show_panels);
                
}
//---------------------------------------------------------------------------------------

//solar_panel(solar_panel_front_size);

//solar_panel_with_enhanced_frame([1485, 668, 30]);


solar_panel_with_enhanced_frame_and_support([1485, 668, 30], _door_angle = 20, 
    bar_offset_left_bottom = 30, 
    bar_offset_left_top = 40, 
    bar_offset_right_bottom = 30, 
    bar_offset_right_top = 40);

    
//solar_wing(50, [1485, 668, 30], angle2 = 8, space = 20, offset_bottom = 52, offset_top = 100, open_door_angle = 0);

//corner_25_25_3_with_holes(1000, 20, 50, 50);
//corner_30_30_3(1000);