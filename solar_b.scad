// Solar Bear
// A hybrid Sun/muscle-powered trike

// https://github.com/solar-b

// License: MIT

//---------------------------------------------------------------------------------------
// Version: 24.12
// last update: 2026.3.9.0
//---------------------------------------------------------------------------------------
// Maker: Mihai Oltean
// https://mihaioltean.github.io
//---------------------------------------------------------------------------------------
include <utils/screws_nuts_washers_params.scad>
//---------------------------------------------------------------------------------------
use <utils/metal_components.scad>
use <utils/bike_parts.scad>
use <utils/solar_panels.scad>
use <utils/human.scad>
use <utils/screws_nuts_washers.scad>
use <utils/bearings.scad>
//---------------------------------------------------------------------------------------
solar_panel_front_size = [1485, 668, 30];////[1030, 668, 30];[1250, 668, 30];
solar_panel_back_size = [545, 668, 30];//[545, 668, 30];//[768, 668, 30];
solar_panel_distance_between_holes = [1234, 1090];
//---------------------------------------------------------------------------------------
wing_front_fly_angle = 50;
wing_front_ramp_angle = 8;
wing_front_crack_angle = 8;

wing_back_fly_angle = 46.4;
wing_back_ramp_angle = 18.5;
wing_back_crack_angle = 22.0;
//---------------------------------------------------------------------------------------
wing_front_offset_X = 15;
wing_front_offset_Y = 790;

wing_back_offset_X = wing_front_offset_X -63;
wing_back_offset_Y = 835;
//---------------------------------------------------------------------------------------

wheel_radius_front = 270;
wheel_radius_back = 270;
wheel_thick = 60;
wheel_hub_small_front = 112;
wheel_hub_small_back = 130;
//---------------------------------------------------------------------------------------

wheels_front_distance = 1300;// 1400
wheels_front_back_distance = 1702;
bottom_frame_length = wheels_front_back_distance + wheel_radius_back + 62;
echo(bottom_frame_length = bottom_frame_length);

//frame_top_distance = 0;
frame_front_distance_between_bottom_frames = 492;
//frame_bottom_length = wheels_back_distance;


//---------------------------------------------------------------------------------------
first_bottom_bar_at = 704;
second_bottom_bar_at = 1497;
//third_bottom_bar_at = 1900;
//---------------------------------------------------------------------------------------
human_angle = 45;
human_pos_X = wing_front_offset_X + 30;
human_pos_Y = 380;
//---------------------------------------------------------------------------------------
frame_front_height = 602;
frame_back_height = 625;
frame_back_length = 1030;

frame_bottom_rotation_angle = -1.50;
//---------------------------------------------------------------------------------------
handle_bar_length = 800;
handle_bar_arm_height = 300;
handle_bar_arm_angle = 30;
//---------------------------------------------------------------------------------------
//angle_direction_control = 30;

offset_wheel = 16.75;
r = sqrt(155*155 + offset_wheel * offset_wheel);
angle_initial = atan(offset_wheel/ 105);
echo(angle_initial = angle_initial);

angle_wheel_1 = angle_initial + handle_bar_arm_angle;
angle_wheel_2 = handle_bar_arm_angle+angle_initial;

//---------------------------------------------------------------------------------------
crank_arm_length = 170;
crank_angle = -90;
crank_y = wheel_radius_front + 70;
//---------------------------------------------------------------------------------------
door_angle = 0;
fork_stick_radius = 14.26;// 1 1/8 inch
//---------------------------------------------------------------------------------------
module wheel_front_support()
{
    difference(){
// corner
        union(){
            translate([-100, -M14_nut_key_size / 2 - 10 - 4 + 2, -0])
                corner_40_40_4(220);
// wheel 10mm thick support
            translate([-25, -M14_nut_key_size / 2 - 10 + 2, 5])
                cube([50, 10, 40]);
        }
        
        translate([0, -8, M14_nut_thick + 4 + 12.5]) 
            rotate([90, 0, 0])
                cylinder (h = 16, r = 7);
    }
    //screw
    translate([0, 0, M14_nut_thick + 4])
        mirror([0, 0, 1])
        screw_M14_hexa(80);
        
        
    translate([-100 - 3, -M14_nut_key_size / 2 - 10 - 4 - 28, -0]){
        difference(){
            corner_30_30_3(70);
            translate([15, 15, -1]) cylinder (h = 7, r = 5);
        }
    }
}
//---------------------------------------------------------------------------------------
module wheel_with_front_support(_angle_Z)
{
    rotate([0, 0, _angle_Z]){
        translate([0, -wheel_hub_small_front / 2 - 23, 0]) 
            rotate([90, 0, 0]){
                wheel_with_break_disk(wheel_radius_front, wheel_thick, shaft_thick = 7, break_disk_radius = 80, wheel_hub_small_front);
            }
        
        //rotate([0, _angle_V, 0])
        translate([0, 0, - 4 - M14_nut_thick - 12.5]) 
            wheel_front_support()
            ;
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
    cylinder(h = 50, r = 5, center = true);
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
module frame_front()
{
    difference(){
        translate([0, -wheels_front_distance / 2 - 26, 0])
        rotate([-90, 0, 0])
            pipe_40_40_2(wheels_front_distance + 52);
                        
            // holes for wheels support
        translate([0, -wheels_front_distance / 2, -21])
            cylinder(h = 42, r = 12);
        translate([0, wheels_front_distance / 2, -21])
            cylinder(h = 42, r = 12);
            
            // holes for screws holding the bearings
            
            
            
// holes for connecting solar wing
        translate([-21, - frame_front_distance_between_bottom_frames, -0])
            rotate([0, 90, 0])
            cylinder(h = 42, r = 4);
        translate([-21, + frame_front_distance_between_bottom_frames, -0])
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
    aa = 35;
    rr = 24.1;
    echo("screw pos x = ",sin(aa) * rr);
    echo("screw pos y = ",cos(aa) * rr);
    echo("screw pos y1 = ",26+cos(aa) * rr);
    echo("screw pos y2 = ",26-cos(aa) * rr);
    // bearings
    translate([0, -wheels_front_distance / 2, 0]){
        translate([0, 0, 20])
            bearing_conic_30202();
    
        translate([0, 0, -20 - 11])
            bearing_conic_30202();
        
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
    }
    // screws for solar wing
    translate([-26, - frame_front_distance_between_bottom_frames, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);
            
    translate([-26, + frame_front_distance_between_bottom_frames, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);

    // bearings
    translate([0, wheels_front_distance / 2, 0]){
        translate([0, 0, 20])
            bearing_conic_30202();
    
        translate([0, 0, -20 - 11])
            bearing_conic_30202();
        

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
    }
        
// vertical bar
    translate([-0, 0, 20])
        difference(){
            rotate([0, 0, 90])
              pipe_40_20_2(frame_front_height)
                ;        
// holes for connecting solar wing
                translate([0, -10, frame_front_height - 39])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
                translate([0, 10, frame_front_height - 39])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
        }
}
//---------------------------------------------------------------------------------------
module frame_front_with_direction_control()
{
    frame_front();
// direction control corner

    translate([0, 0, -38])
        rotate([0, 0, -handle_bar_arm_angle])
            direction_control_corner();
/*
// direction control shaft left
    translate ([-cos(angle_wheel_1) * 105, sin(angle_wheel_1) * 105 + 16, +25])
        direction_control_shaft(bar_length = wheels_front_distance - 47) ;
*/
// direction control shaft left    
    
    translate ([-cos(handle_bar_arm_angle) * r, sin(handle_bar_arm_angle) * r - (wheels_front_distance / 2 - offset_wheel), +25])
        direction_control_shaft(bar_length = wheels_front_distance - 2 * offset_wheel) ;
        
// screws for connecting the bottom frame
    translate([-8,  -30, -26])
        screw_M8_hexa(120);
    translate([-8, +30, -26])
        screw_M8_hexa(120);
        
// screws for connecting the bottom frame
    translate([0, 0, -100])
        cylinder(h = 100, r = 4);
}
//---------------------------------------------------------------------------------------
module frame_back()
{      
// horizontal
    difference(){
        translate([0, -frame_back_length / 2, 0])
            rotate([0, -90, 0])
            //mirror([1, 0, 0])
                corner_25_25_3(frame_back_length);
            // holes for connecting bottom frame to front-back 
        translate([-15, - (130/2 + 10), -11])
            cylinder(h = 42, r = 4);
        translate([-15, + (130/2 + 10), -11])
            cylinder(h = 42, r = 4);
            
            // hole for connecting wing
        translate([1, frame_back_length / 2 - 30, 12.5])
            rotate([0, -90, 0])
            cylinder(h = 50, r = 4);
    }
            // screws for connecting wing
    translate([6, frame_back_length / 2 - 30, 13.5])
        rotate([0, -90, 0])
        screw_M8_hexa(30);
    translate([6, -(frame_back_length / 2 - 30), 13.5])
        rotate([0, -90, 0])
        screw_M8_hexa(30);
    
// vertical        
    translate([-13, 0, 3])
        difference(){
            rotate([0, 0, 90])
            pipe_40_20_2(frame_back_height);
// holes for connecting solar wing
                translate([0, -10, frame_back_height - 42])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
                translate([0, 10, frame_back_height - 42])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
        }
}
//---------------------------------------------------------------------------------------
module frame_bottom()
{
    difference(){    
        rotate([0, 90, 0])
            pipe_40_20_2(bottom_frame_length)
            echo("frame_bottom_length_1=", bottom_frame_length);
            ;

            // vertical holes to connect to front frame
            translate([12, 0, -21])
                cylinder(h = 42, r = 4);
                
            translate([20, 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 4);
                    /*
                // mark for first bar
            translate([752, 10, -21])
                cylinder(h = 42, r = 4);
                // mark for second bar
            translate([1153, 10, -21])
                cylinder(h = 42, r = 4);
                */
            // hole for wheel hub back
            echo("hole for wheel hub back", (wheel_radius_back + 62 - 20));
            translate([bottom_frame_length - (wheel_radius_back + 62 - 20), 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 7);
                    
            echo("hole for lateral", (second_bottom_bar_at + 10));
            translate([second_bottom_bar_at + 10, 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 4);
            // back frame hole
            translate([bottom_frame_length - 10, 0, -21])
                cylinder(h = 42, r = 4);
                
                

                /*
// 1st            // long
            translate([first_bottom_bar_at + 39, -0, 0]) // 650+39 = 689
                rotate([-90, 0, 0])
                    cylinder(h = 32, r = 16);
// short
            translate([first_bottom_bar_at + 33, -0, 0]) // 650+39 = 683
                rotate([90, 0, 0])
                    cylinder(h = 32, r = 16);
// 2nd long
            translate([second_bottom_bar_at + 57, 0, 0])  // 1467
                rotate([-90, 0, 0])
                    cylinder(h = 32, r = 16);
// 2nd short
            translate([second_bottom_bar_at + 50, 0, 0]) // 1460
                rotate([90, 0, 0])
                    cylinder(h = 32, r = 16);
                    */
    }
/*
    translate([wheels_front_back_distance - wheel_radius_front + 100, 0, 0])    
        rotate([0, 0, -frame_bottom_rotation_angle]){
            difference(){
                rotate([0, 90, 0])
                    pipe_40_20_2(2 * wheel_radius_front + 43);
                    // hole for wheel hub
                    translate([wheel_radius_back - 4, -16, 0])
                        rotate([-90, 0, 0])
                            cylinder(h = 22, r = 7);
                    // back frame hole
                    translate([2 * wheel_radius_front + 50 - 20, 0, -21])
                        cylinder(h = 42, r = 4);
                        
                    translate([84, -16, 0])
                    rotate([-90, 0, 0])
                        cylinder(h = 32, r = 4);
            }
        }
        */
}
//---------------------------------------------------------------------------------------
module frame_top()
{
// frame top, front
    translate([0, -0, frame_height_front - 41]) 
        rotate([0, 90 + 38.8, 0])
                pipe_20_20_2(954);
    
// frame top front-back
    translate([735, -0, -85]) 
        rotate([0, 90, 0])
            pipe_30_20_2(290);

// frame top, back - center
    translate([wheels_front_back_distance + wheel_radius_front + 19, -0, frame_height_back + 11]) 
        rotate([0, -(90+37.2), 0])
                pipe_20_20_2(1120);
}
//---------------------------------------------------------------------------------------
module seat()
{
    color("Green"){
        cube([250, 450, 40]);
        translate([250, 25, 40])
            rotate([0, human_angle, 0]) 
                cube([30, 400, 600]);
    }
}
//---------------------------------------------------------------------------------------
module pipe_panel_suport_center(_length, top_cut_angle, top_dist_to_holes)
{
    difference(){
        rotate([0, 0, 90])
            pipe_30_20_2(length = _length);
            
// holes for screws
/*
        translate([-11, -8, _length - 20])
            rotate([0, 90, 0])
                cylinder(h = 22, r = 4);
        translate([-11, 8, _length - 20])
            rotate([0, 90, 0])
                cylinder(h = 22, r = 4);
                */
        // cut top angle
        translate([-26, -15, _length])
            rotate([-top_cut_angle, 0, 0])
                cube([52, 59, 30]);
    }
    
    // screws
    translate([0, 0, _length - top_dist_to_holes * cos(top_cut_angle) - tan(top_cut_angle) * (15 - 8)])
    translate([-30, -8, 0])
        rotate([0, 90, 0])
            cylinder(h=60, r = 4);
            
    translate([0, 0, _length - top_dist_to_holes * cos(top_cut_angle) - tan(top_cut_angle) * (15 + 8)])
    translate([-30, 8, 0])
        rotate([0, 90, 0])
            cylinder(h=60, r = 4);
}
//---------------------------------------------------------------------------------------
module handle_bar()
{
    translate([0, -handle_bar_length / 2, 0])
        rotate([-90, 0, 0])
            pipe_30_20_2(handle_bar_length);
            
    translate([0, -handle_bar_length / 2 + 13, 0])
        rotate([0, -handle_bar_arm_angle, 0])
            cylinder_1_2(handle_bar_arm_height);
            
    translate([0, handle_bar_length / 2 - 13, 0])
        rotate([0, -handle_bar_arm_angle, 0])
            cylinder_1_2(handle_bar_arm_height);
}
//---------------------------------------------------------------------------------------
module crank_with_tail(length)
{
    crank(crank_arm_length, crank_angle);
    
    translate([-length, -0, 0])
        rotate([0, 90, 0])
            rotate([0, 0, 90])
                pipe_40_20_2(length);
}
//---------------------------------------------------------------------------------------
module chain_deviation()
{
    
}
//---------------------------------------------------------------------------------------
module trike()
{
/*
// debug for Ackerman angles
    translate([-0, -wheels_front_distance / 2, wheel_radius_front]) 
        rotate([0, 0, 20.5])
        translate([-120, 0, -0])
        rotate([0, 90, 0])
            cylinder(h = 2000, r = 10);
            ;
*/
  
//wheels, front
    translate ([0, wheels_front_distance / 2, wheel_radius_front]) 
            mirror([0, 1, 0])
            wheel_with_front_support(angle_wheel_1)
            ;
    translate ([0, -wheels_front_distance / 2, wheel_radius_front]) 
            wheel_with_front_support(-angle_wheel_2)
            ;
            
//wheel, back
    translate([wheels_front_back_distance -0, 0, wheel_radius_back])
        rotate([90, 0, 0])
            wheel_with_gears(wheel_radius_back, wheel_thick, 7, 2, 45, wheel_hub_small_back);

// frame between wheels, front
    translate ([-0, -0, wheel_radius_front - 62])
        frame_front_with_direction_control()
       ;
                    
// crank
    translate([human_pos_X + crank_arm_length - 10, 0, crank_y])
        rotate ([90, 0, 0]) 
                crank_with_tail(150);    
                    

//translate([0, 0, -20])
//        rotate([0, -0.70, 0]){
// frame bottom left
    translate([-19, -30, wheel_radius_front]) 
        rotate([0, 0, frame_bottom_rotation_angle])
            frame_bottom()
            ;
            
// frame bottom right
    translate([-19, 30, wheel_radius_front])
        //    mirror([0, 1, 0])
        rotate([0, 0, -frame_bottom_rotation_angle])
                frame_bottom()
            ;

            
//back frame
     translate([wheels_front_back_distance + wheel_radius_front + 46, -0, wheel_radius_front - 23])
              frame_back()
/*                ;
// frame top      
    translate([12.5, -0, wheel_radius_front])
        frame_top();
    
// FIRST shaft between frames, bottom 1
        translate ([first_bottom_bar_at, 289, wheel_radius_front + 1])
        rotate([0, 90, 0])
            rotate([90, 0, 0])
                pipe_30_30_2(578)
                ;
*/
// SECOND
// horizontal bar
    translate ([1084, 161, wheel_radius_front + 1])
        rotate([0, 90, 0])
            rotate([90, 0, 0])
            pipe_20_20_2(322)
            ;         
//  solar panels, second support; internal
    translate([second_bottom_bar_at, -94, wheel_radius_front + 12])
        mirror([0, 1, 0])
            rotate([-15, 0, 0])
                pipe_panel_suport_center(705, top_cut_angle = 35, top_dist_to_holes = 22)
                    ;

//  solar panels, second support; internal
    translate([second_bottom_bar_at, 94, wheel_radius_front + 12])
            rotate([-15, 0, 0])
                pipe_panel_suport_center(705, top_cut_angle = 35, top_dist_to_holes = 22)
                ;

//  solar panels, second support; external
    translate([second_bottom_bar_at, -73, wheel_radius_front - 1])
        //rotate([0, 0, frame_bottom_rotation_angle])
            rotate([65, 0, 0])
            //rotate([0, 0, 90])
                pipe_panel_suport_center (615, top_cut_angle=15, top_dist_to_holes = 15)
                ;

//  solar panels, second support; external
    translate([second_bottom_bar_at, 74, wheel_radius_front - 1])
        //rotate([0, 0, frame_bottom_rotation_angle])
            mirror([0, 1 , 0])
            rotate([65, 0, 0])
            //rotate([0, 0, 90])
                pipe_panel_suport_center(615, top_cut_angle=15, top_dist_to_holes = 15)
                ;

//seat
    translate([human_pos_X + 700, -225, wheel_radius_front + 25])
            seat();   

// handle bar            
    translate([940, -0, wheel_radius_front - 45])
        rotate([0, 0, -handle_bar_arm_angle])
        handle_bar();
        
// direction shaft        
    translate([0, -65, wheel_radius_front - 105])
        rotate([0, 0, -90])
            direction_control_shaft(bar_length = 865);

//amortizor  
    translate([first_bottom_bar_at, -330, wheel_radius_front + 25])
        //rotate([0, 0, frame_bottom_rotation_angle])
            rotate([1, 0, 0])
               // color("black")cylinder (h = 320, r = 10)
                ;
}
//---------------------------------------------------------------------------------------
module trike_with_panels()
{
    trike();
// front 
    translate([wing_front_offset_X, -0, wing_front_offset_Y]) 
        rotate([0, -wing_front_ramp_angle, 0]) 
            solar_wing(wing_front_fly_angle, solar_panel_front_size, angle2 = wing_front_crack_angle, space = 20, open_door_angle = door_angle, offset_bottom = 45, offset_top = 100, $show_panels = true);
            
           
// back 
    
    translate([solar_panel_front_size[0] + solar_panel_back_size[0] + wing_back_offset_X, 0, wing_back_offset_Y])
        rotate([0, wing_back_ramp_angle, 0]) 
        mirror([1, 0, 0])
            solar_wing(wing_back_fly_angle, solar_panel_back_size, angle2 = wing_back_crack_angle, space = 20, offset_bottom = 40, offset_top = 90, open_door_angle = 0,
            $show_panels = true);
}
//---------------------------------------------------------------------------------------
module trike_with_panels_frame()
{
    trike();
// front 
    translate([wing_front_offset_X, -0, wing_front_offset_Y]) 
        rotate([0, -wing_front_ramp_angle, 0]) 
            solar_wing(wing_front_fly_angle, solar_panel_front_size, angle2 = wing_front_crack_angle, space = 20, open_door_angle = door_angle, offset_bottom = 45, offset_top = 100, $show_panels = false);
            
           
// back 
    
    translate([solar_panel_front_size[0] + solar_panel_back_size[0] + wing_back_offset_X, 0, wing_back_offset_Y])
        rotate([0, wing_back_ramp_angle, 0]) 
        mirror([1, 0, 0])
            solar_wing(wing_back_fly_angle, solar_panel_back_size, angle2 = wing_back_crack_angle, space = 20, offset_bottom = 40, offset_top = 90, open_door_angle = 0,
            $show_panels = false);
}
//---------------------------------------------------------------------------------------
module trike_with_panels_and_human()
{
    trike_with_panels();
// human 
    translate([human_pos_X, 0, human_pos_Y])
    rotate([0, 90, 0])
        human(human_angle);
}
//---------------------------------------------------------------------------------------
module trike_with_human()
{
    trike();
// human 
    translate([human_pos_X, 0, 400])
        rotate([0, 90, 0])
            human(human_angle);
}
//---------------------------------------------------------------------------------------
trike_with_panels_and_human();
//trike_with_human();
//trike_with_panels();
//trike_with_panels_frame();
//trike();

//solar_panel_with_support(solar_panel_front_size);
//solar_panel_with_support_and_balamale(solar_panel_front_size);
//solar_wing(wing_front_opening_angle, solar_panel_front_size, 10);
//solar_panel_with_enhanced_frame_and_support(solar_panel_front_size, 0, 0);
//solar_panel_with_enhanced_frame_and_support_and_hinges(solar_panel_front_size);

//pipe_panel_suport_center(200, 20, 4);
//pipe_panel_suport_center(705, top_cut_angle = 35, top_dist_to_holes = 27);

//wheel_front_support();
//wheel_with_front_support(angle_wheel_1);

//frame_front();
//frame_front_with_direction_control();
//frame_back();
//frame_bottom();

//handle_bar();

//direction_control_shaft(200);

//direction_control_corner();

//solar_panel_hinge_bar(length = 100, top = 10, bottom = 20, angle_top = 45, angle_bottom = 45);

//crank_with_tail(200);