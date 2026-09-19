// Solar Bear
// A hybrid Sun/muscle-powered trike

// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io

// License: MIT

//---------------------------------------------------------------------------------------
// last update: 2026.09.19
//---------------------------------------------------------------------------------------
include <screws_nuts_washers_params.scad>
//---------------------------------------------------------------------------------------
use <metal_profiles.scad>
use <solar_panels.scad>
use <human.scad>
use <screws_nuts_washers.scad>
use <bearings.scad>
//---------------------------------------------------------------------------------------
module wheel_front_support()
{
    difference(){
// corner
        union(){
            translate([-120, -M14_nut_key_size / 2 - 10 - 4 + 2, -0])
                corner_angled_40_40_4(240, 90);
// wheel 10mm thick support
            translate([-25, -M14_nut_key_size / 2 - 10 + 2, 4])
                cube([50, 10, 40]);
        }
        
        translate([0, -8, M14_nut_thick + 4 + 12.5]) 
            rotate([90, 0, 0])
                cylinder (h = 16, r = 7);
    }
    //screw
    translate([0, 0, M14_nut_thick])
        mirror([0, 0, 1])
            screw_M14_hexa(80);
        
        // direction
    translate([-120 - 3, -M14_nut_key_size / 2 - 10 - 4 - 28, -0]){
        difference(){
            corner_30_30_3(70);
            translate([15, 15, -1]) 
                cylinder (h = 7, r = 5);
        }
    }
}
//---------------------------------------------------------------------------------------
module direction_control_shaft(bar_length)
{
// bar
    translate([0, 17, 0])
        rotate([-90, 0, 0])
            cylinder(h = bar_length - 2 * 17, r = 5);
// bearing1 
    difference(){
        cylinder(h = 10, r = 17, center = true);
        cylinder(h = 12, r = 5, center = true);
    }
    // screw
    cylinder(h = 50, r = 5, center = true);
// bearing2
    translate([0, bar_length, 0]){
        difference(){
            cylinder(h = 10, r = 17, center = true);
            cylinder(h = 12, r = 5, center = true);
        }
            // screw
    cylinder(h = 70, r = 5, center = false);
    }
}
//---------------------------------------------------------------------------------------
module direction_control_corner()
{
    difference(){
        union(){
            translate([0, 20, 0])
            rotate([90, 0, 0]) 
                pipe_40_20_2(120 + 20)
                ;

            rotate([0, 0, -90]) 
            translate([0, 20, 0]){
                rotate([90, 0, 0]) 
                    pipe_40_20_2(160 + 20)
                    ;
            }
        }
        // middle hole
        translate([-0, -0, -16])
            cylinder (h = 100, r = 5);
    }
    // screws
    translate([-150, -0, -15])
        cylinder (h = 110, r = 5);
}
//---------------------------------------------------------------------------------------
module frame_front_wheel_connector(extension_length, dist_to_bearing = 27)
{
    aa = 35;
    rr = 24.1;
    
    echo("bearing center y=",dist_to_bearing);
    difference(){
        translate([0, - dist_to_bearing, 0])
            rotate([-90, 0, 0])
                pipe_40_40_2(2 * dist_to_bearing + extension_length);
                
// center hole for wheels support
        translate([0, 0, -21])
            cylinder(h = 42, r = 12.5);

// screws for holding bearings
        echo("screw pos x (from edge)= ",20-sin(aa) * rr);
        echo("screw pos y (from center)= ",cos(aa) * rr);
        
        echo("screw pos y1 (from edge) = ",dist_to_bearing+cos(aa) * rr);
        echo("screw pos y2 (from edge) = ",dist_to_bearing-cos(aa) * rr);
        translate([0, -dist_to_bearing / 2, 0]){
            

                translate([0, 0, 20 + 7])
                mirror([0, 0, 1]){
                    translate([sin(aa) * rr, cos(aa) * rr, 0])
                        rotate([0, 0, 20])screw_M8_hexa(60);
                    translate([sin(-aa) * rr, cos(-aa) * rr, 0])
                        rotate([0, 0, 35])screw_M8_hexa(60);
                    translate([sin(180-aa) * rr, cos(180-aa) * rr, 0])
                        rotate([0, 0, 34])screw_M8_hexa(60);
                    translate([sin(180+aa) * rr, cos(180+aa) * rr, 0])
                        rotate([0, 0, 25])screw_M8_hexa(60);
                }
        }
    }
    // screws for holding bearings
    translate([0, 0, 20 + 7])
        mirror([0, 0, 1]){
            translate([sin(aa) * rr, cos(aa) * rr, 0])
                rotate([0, 0, 20])screw_M8_hexa(60);
            translate([sin(-aa) * rr, cos(-aa) * rr, 0])
                rotate([0, 0, 35])screw_M8_hexa(60);
            translate([sin(180-aa) * rr, cos(180-aa) * rr, 0])
                rotate([0, 0, 34])screw_M8_hexa(60);
            translate([sin(180+aa) * rr, cos(180+aa) * rr, 0])
                rotate([0, 0, 25])screw_M8_hexa(60);
        }

// install bearings too        
    translate([0, 0, 20])
        bearing_conic_30202();
     translate([0, 0, -20 - 11])
            bearing_conic_30202();
}
//---------------------------------------------------------------------------------------
module frame_front(
    wheels_front_distance_between_supports, 
    bearing_wheel_support_to_edge_distance,
    frame_front_height,
    castor_angle, 
    frame_front_distance_to_solar_frames_bottom
    )
{
    echo ("horizontal bar length = ", wheels_front_distance_between_supports - 2 * bearing_wheel_support_to_edge_distance);
    difference(){
        translate([0, -(wheels_front_distance_between_supports / 2 - bearing_wheel_support_to_edge_distance), 0])
        rotate([-90, 0, 0])
            cylinder(h = wheels_front_distance_between_supports - 2 * bearing_wheel_support_to_edge_distance, r = 17)
            ;            
            
            
// holes for connecting solar wing
    echo(frame_front_distance_to_solar_frames_bottom = frame_front_distance_to_solar_frames_bottom);
    
        translate([-21, - frame_front_distance_to_solar_frames_bottom, -0])
            rotate([0, 90, 0])
            cylinder(h = 42, r = 4);
        translate([-21, + frame_front_distance_to_solar_frames_bottom, -0])
        rotate([0, 90, 0])
            cylinder(h = 42, r = 4);
            
            // holes for connecting bottom frame
/*
            translate([11, - 441, -21])
            cylinder(h = 42, r = 6);
        translate([11, + 441, -21])
            cylinder(h = 42, r = 6);
*/
    }
//    
    // screws for solar wing
    translate([-26, - frame_front_distance_to_solar_frames_bottom, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);
            
    translate([-26, + frame_front_distance_to_solar_frames_bottom, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);

    // frame-wheel connectors
    translate([0, -wheels_front_distance_between_supports / 2 + bearing_wheel_support_to_edge_distance + 50, 0])
            translate([0, -bearing_wheel_support_to_edge_distance -50, 0])
                frame_front_wheel_connector(50);
                
    translate([0, wheels_front_distance_between_supports / 2 - bearing_wheel_support_to_edge_distance - 50, 0])
            translate([0, bearing_wheel_support_to_edge_distance +50, 0])
                mirror([0,1,0])
                    frame_front_wheel_connector(50);
    
        
// vertical bar
    echo(frame_front_height = frame_front_height);
    echo("frame_front_vertical holes from top", 34);
    
    rotate([0, -castor_angle, 0])
        translate([-0, 0, 15]){
            translate([-3, 0, 3])
        difference(){
            rotate([0, 0, 90])
                pipe_40_20_2(frame_front_height)
            
            ;
                // holes for connecting solar wing
            translate([-1, -10, frame_front_height - 34])
                rotate([0, 90, 0])
                    cylinder (h = 23, r = 4, center = true);
            translate([-1, 10, frame_front_height - 34])
                rotate([0, 90, 0])
                    cylinder (h = 23, r = 4, center = true);
        }
        // base of the vertical, welded, used to connect to horizontal
        translate([10, 40, 0])
            rotate([0, 0, 180])
                corner_30_23_3(80);
    }
}
//---------------------------------------------------------------------------------------
module pipe_wing_panel_suport(_length, top_cut_angle)
{
    difference(){
        rotate([0, 0, 90])
            pipe_15_15_1_5(length = _length);
            
// holes for screws

        // cut top angle
        translate([-0, 15, _length ])
            rotate([90-top_cut_angle, 0, 0])
                cylinder(h = 50, r = 15, center = true);
    }
    
    // ring
    translate([0, 0, _length - 4 ])
    translate([0, 20, 0])
        rotate([90-top_cut_angle, 0, 0])
            tube(h = 30, r_ext = 15, r_int = 12.5)
            ;
}
//---------------------------------------------------------------------------------------
module solar_wings_support(length_int, length_ext, top_cut_angle_int, top_cut_angle_ext)
{
// base support
    difference() {
        translate([40, 0, 0])
            rotate([0, 0, 90])
                corner_30_30_3(80);
                // holes
        translate([25, 4, 15])
            rotate([90, 0, 0])
            cylinder(h = 5, r = 4);
        translate([-25, 4, 15])
            rotate([90, 0, 0])
            cylinder(h = 5, r = 4);
    } 
            
//  solar panels, second support; internal
    echo("internal pipe_panel_suport_center (length = length_int, base_cut angle:  37, top_cut_angle : top_cut_angle_int)");
    
    translate([-7.5, 12.1, 22.1])
        rotate([-15, 0, 0])
            pipe_wing_panel_suport(length_int, top_cut_angle = top_cut_angle_int)
                ;
//  solar panels, second support; external
    
    echo("external pipe_panel_suport_center(lenght = length_ext, base_cut_angle = 23, top_cut_angle = top_cut_angle_ext)");
        translate([7.5, -1.2, 12])
            mirror([0, 1 , 0])
            rotate([67.2, 0, 0])
            //rotate([0, 0, 90])
                pipe_wing_panel_suport(length_ext, top_cut_angle=top_cut_angle_ext)
                ;

}
//---------------------------------------------------------------------------------------
module handle_bar(length, arm_angle, arm_length)
{
// horizontal
    translate([0, -length / 2, 0])
        rotate([-90, 0, 0])
            pipe_30_20_2(length);
            /*
    //translate([0, -length / 2, 0])
      rotate([0, 0, 90])
        rotate([-90, 0, 0])
            pipe_30_20_2(300);
            
    translate([-300, 0, 0])
    rotate([0, 0, 135 + 20])
        rotate([-90, 0, 0])
            pipe_20_20_2(700);
            */
// hand bars            
    translate([0, -length / 2 + 13, 0])
        rotate([0, -arm_angle, 0])
            cylinder_1_2(arm_length);
            
    translate([0, length / 2 - 13, 0])
        rotate([0, -arm_angle, 0])
            cylinder_1_2(arm_length);
}
//---------------------------------------------------------------------------------------
module chain_deviation()
{
    cylinder(h = 40, r = 20);
}
//---------------------------------------------------------------------------------------
//pipe_panel_suport_center(200, 20, 4);
//pipe_panel_suport_center(705, top_cut_angle = 35, top_dist_to_holes = 27);

//wheel_front_support();
//direction_control_shaft(bar_length = 1000);
//direction_control_corner();

//frame_front_wheel_connector(extension_length = 50, dist_to_bearing = 27);

//pipe_wing_panel_suport(693, top_cut_angle = 37, top_dist_to_holes = 30);
solar_wings_support(length_int = 660, length_ext = 580, top_cut_angle_int = 37, top_cut_angle_ext = 17);

//handle_bar(length = 800, arm_angle = 15, arm_length = 300);
