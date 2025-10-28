// Solar Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Version: 23.7
// since: 2025.10.28
// last update: 2025.10.28

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

//---------------------------------------------------------------------------------------
use <utils\metal_components.scad>
use <utils\bike_parts.scad>
use <utils\solar_panels.scad>
use <utils\human.scad>
//---------------------------------------------------------------------------------------
solar_panel_front_size = [1485, 668, 30];//[1485, 668, 30];//[1250, 668, 30];//[1030, 668, 30];
solar_panel_back_size = [1030, 668, 30];//[1030, 668, 30];
solar_panel_distance_between_holes = [1234, 1090];
//---------------------------------------------------------------------------------------
wing_front_fly_angle = 34.3;
wing_front_ramp_angle = 13;
wing_front_crack_angle = 9;

wing_back_fly_angle = 33;
wing_back_ramp_angle = 18.8;
wing_back_crack_angle = 13.0;

//---------------------------------------------------------------------------------------
wheel_radius_front = 270;
wheel_radius_back = 270; //330;
wheel_thick = 60;
wheel_hub_small = 112;
//---------------------------------------------------------------------------------------

wheels_front_distance = 1440;
wheels_front_back_distance = 2040;
//front_back_length = wheels_front_back_distance + 265;

//frame_top_distance = 0;
frame_bottom_distance = 465;
//frame_bottom_length = wheels_back_distance;

panel_front_offset_X = -20;
panel_front_offset_Y = 665;

panel_back_offset_X = -150;
panel_back_offset_Y = 670;

//---------------------------------------------------------------------------------------
first_bottom_bar_at = 650;
second_bottom_bar_at = 1410;
//third_bottom_bar_at = 1900;

human_angle = 40;
human_pos_X = 60;
human_pos_Y = 380;

//---------------------------------------------------------------------------------------
frame_height_front = 405;
frame_height_back = 560;

frame_bottom_rotation_angle = 12.3;
//---------------------------------------------------------------------------------------
angle_wheel = 30;
//---------------------------------------------------------------------------------------
handle_bar_length = 800;
handle_bar_height = 250;
//---------------------------------------------------------------------------------------
crank_arm_length = 170;
crank_angle = 0;
//---------------------------------------------------------------------------------------
module wheel_front_support()
{
//pipe from bike fork
    translate([0, 0, -135])
        cylinder(h = 135, r = 15);
// wheel 10mm thick support
    translate([-25, -11, 4])
        cube([50, 10, 40]);
        
// corner
    translate([-120, -15, -0])
        //rotate([0, 180, 0])
        //rotate([0, 0, 90])
        difference(){
            corner_40_40_4(240);
            // holes for direction control bar
            translate([15, 25, -1]) cylinder (h = 6, r = 5);
        }
}
//---------------------------------------------------------------------------------------
module wheel_with_front_support(_angle_Z)
{   
    rotate([0, 0, _angle_Z]){
        translate([0, -wheel_hub_small / 2 - 15, 0]) 
            rotate([90, 0, 0]){
            wheel_with_break_disk(wheel_radius_back, wheel_thick, shaft_thick = 7, break_disk_radius = 80);
            }
        
        //rotate([0, _angle_V, 0])
        translate([0, 0, -4 - 13]) 
            wheel_front_support();
    }
}
//---------------------------------------------------------------------------------------
module direction_control_shaft(bar_length)
{
// bar
    translate([0, 17, 0])
        rotate([-90, 0, 0])
            cylinder(h = bar_length, r = 5);
// bearing1 
    difference(){
        cylinder(h = 10, r = 17, center = true);
        cylinder(h = 12, r = 5, center = true);
    }
    
// bearing2
    translate([0, bar_length + 2 * 17, 0])
        difference(){
            cylinder(h = 10, r = 17, center = true);
            cylinder(h = 12, r = 5, center = true);
        }
}
//---------------------------------------------------------------------------------------
module direction_control_corner()
{
    difference(){
        union(){
            translate([0, 25, 0])
            rotate([90, 0, 0]) 
                pipe_50_30(120 + 25)
                ;

            rotate([0, 0, -90]) 
            translate([0, 25, 0]){
                rotate([90, 0, 0]) 
                    pipe_50_30(120 + 25)
                    ;
            }
        }
        // middle hole
        translate([-0, -0, -16])
            cylinder (h = 100, r = 5);
    }
    // screws
    translate([-105, -16, -15])
        cylinder (h = 110, r = 5);
    translate([-105, +16, -15])
        cylinder (h = 110, r = 5);    
}
//---------------------------------------------------------------------------------------
module frame_front()
{
    difference(){
        translate([0, -wheels_front_distance / 2, 0])
        rotate([-90, 0, 0])
            pipe_40_40(wheels_front_distance);
                        
            // holes for wheels support
        translate([0, -wheels_front_distance / 2, -21])
            cylinder(h = 42, r = 17);
        translate([0, wheels_front_distance / 2, 1])
            cylinder(h = 42, r = 17);
            
            // holes for connecting bottom frame
        translate([0, - frame_bottom_distance, -21])
            cylinder(h = 42, r = 4);
        translate([0, + frame_bottom_distance, -21])
            cylinder(h = 42, r = 4);
    }
    
    translate([0, wheels_front_distance / 2 + 12,  -35])
        cylinder (h = 110, r = 22, center = true)
        ;
        
    translate([0, -wheels_front_distance / 2 - 12, -35])
        cylinder (h = 110, r = 22, center = true);
      
        // vertical
    translate([5, 0, 20])
              pipe_50_30(frame_height_front)
                ;        
                
// direction control corner
    translate([0, 0, -38])
    rotate([0, 0, -angle_wheel])
        direction_control_corner();
        
// direction control shaft
    translate ([-cos(angle_wheel) * 105, sin(angle_wheel) * 105 + 16, +25])
        direction_control_shaft(bar_length = wheels_front_distance / 2 - 47) ;
    
    translate ([-cos(angle_wheel) * 105, sin(angle_wheel) * 105 + 15 - wheels_front_distance / 2 - 18, +25])
        direction_control_shaft(bar_length = wheels_front_distance / 2 - 47) ;
// screws for connecting the bottom frame
    translate([0,  -frame_bottom_distance, -21])
        cylinder(h = 112, r = 4);
    translate([0, +frame_bottom_distance, -21])
        cylinder(h =112, r = 4);   
        
// screws for connecting the bottom frame
    translate([0, 0, -100])
        cylinder(h = 100, r = 4);
}
//---------------------------------------------------------------------------------------
module frame_back()
{      
// horizontal
    difference(){
        translate([0, -wheels_front_distance / 2, 0])
            rotate([-90, 0, 0])
                pipe_40_40(wheels_front_distance);
            // holes for connecting bottom frame
        translate([0, - 75, -21])
            cylinder(h = 42, r = 4);
        translate([0, + 75, -21])
            cylinder(h = 42, r = 4);
            
    }
    
// vertical        
    translate([-5, 0, 20])
        pipe_50_30(frame_height_back)
                ;        
}
//---------------------------------------------------------------------------------------
module seat()
{
    color("Green"){
        cube([250, 500, 40]);
        translate([250, 50, 40])
            rotate([0, human_angle, 0]) 
                cube([30, 400, 600]);
    }
}
//---------------------------------------------------------------------------------------
module pipe_panel_suport_center(_length, angle)
{
    difference(){
        pipe_50_30 (length = _length);
        translate([-26, -15, _length])
            rotate([-(90-angle), 0, 0])
                cube([52, 59, 30]);
    }
}
//---------------------------------------------------------------------------------------
module frame_bottom()
{
    difference(){    
        rotate([0, 90, 0])
            pipe_50_30(1850);
/*
            translate([-26, -18, -11])
                rotate([frame_bottom_rotation_angle, 0, 0])
                    cube([52, 38, 10]);
*/
                    // vertical holes to connect to front frame
            translate([20, 0, -26])
                cylinder(h = 52, r = 4);
                
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
    }
    
    translate([1847, 0, 0])    
        rotate([0, 0, -frame_bottom_rotation_angle]){
            difference(){
                rotate([0, 90, 0])
                    pipe_50_30(2 * wheel_radius_back + 50);
                    // hole for wheel hub
                    translate([wheel_radius_back - 15, -16, 0])
                        rotate([-90, 0, 0])
                            cylinder(h = 32, r = 7);
                    translate([2 * wheel_radius_back + 50 - 20, 0, -26])                            
                        cylinder(h = 52, r = 4);
            }    
        }
}
//---------------------------------------------------------------------------------------
module frame_top()
{
// center front

}
//---------------------------------------------------------------------------------------
module handle_bar()
{
    translate([0, -handle_bar_length / 2, 0])
        rotate([-90, 0, 0])
            pipe_50_30(handle_bar_length);
            
    translate([0, -handle_bar_length / 2 + 20, 0])
    rotate([0, -20, 0])
        cylinder_32(handle_bar_height);
    translate([0, handle_bar_length / 2 - 20, 0])
    rotate([0, -20, 0])
        cylinder_32(handle_bar_height);
}
//---------------------------------------------------------------------------------------
module crank_with_tail(length)
{
    crank(crank_arm_length, crank_angle);
    
    translate([-length, -0, 0])
        rotate([0, 90, 0])
            rotate([0, 0, 90])
                pipe_50_30(length);
}
//---------------------------------------------------------------------------------------
module solar_wing(angle, panel_size, angle2, space)
{
    rotate([0, 0, angle2])
        rotate([-angle, 0, 0])
        translate([0, space, 0]) 
            solar_panel_with_enhanced_frame_and_support_with_bar(panel_size);
        
    rotate([0, 0, -angle2]) 
        rotate([angle, 0, 0]) 
            translate([0, - space, 0]) 
            mirror([0, 1, 0])
                solar_panel_with_enhanced_frame_and_support_with_bar(panel_size);
}
//---------------------------------------------------------------------------------------
module solar_wing_with_hinges(angle, panel_size, angle2, space)
{
    rotate([0, 0, angle2])
        rotate([-angle, 0, 0])
        translate([0, space, 0]) 
            solar_panel_with_enhanced_frame_and_support_with_hinge_bar(panel_size);
        
    rotate([0, 0, -angle2]) 
        rotate([angle, 0, 0]) 
            translate([0, - space, 0]) 
                mirror([0, 1, 0])
                solar_panel_with_enhanced_frame_and_support_with_hinge_bar(panel_size);
}
//---------------------------------------------------------------------------------------
module trike()
{
  
//wheels, front
    translate ([0, wheels_front_distance / 2 + 12, wheel_radius_back]) 
            mirror([0, 1, 0])
            wheel_with_front_support(angle_wheel)
            ;
    translate ([0, -wheels_front_distance / 2 - 12, wheel_radius_back]) 
            wheel_with_front_support(-angle_wheel)
            ;
            
// frame between wheels, front
    translate ([-0, -0, wheel_radius_back - 37 - 11])
        frame_front()
       ;
                                
// frame bottom left
    translate([-20, -frame_bottom_distance - 4, wheel_radius_front]) 
        rotate([0, 0, frame_bottom_rotation_angle])
            frame_bottom();
            
// frame bottom right
    translate([-20, frame_bottom_distance + 4, wheel_radius_front])
            mirror([0, 1, 0])
        rotate([0, 0, frame_bottom_rotation_angle])
                frame_bottom()
            ;

//wheel, back
    translate([wheels_front_back_distance, 0, wheel_radius_front])
        rotate([90, 0, 0])
            wheel(wheel_radius_front, wheel_thick, 7);
            
//back frame
     translate([wheels_front_back_distance + wheel_radius_front + 42, -0, wheel_radius_front - 45])
              frame_back()
                ;
                  
// frame top, front
    translate([16.5, -0, wheel_radius_front + 356]) 
        rotate([0, 90 + 29.3, 0])
            difference(){
                pipe_50_30(903);
                translate ([0, -1, 727])
                    rotate([-90, 0, 0])
                        cylinder(r = 17, h = 52, center = true);
                /*
                rotate([0, 30, 0])
                    pipe_50_30(90);
                    */
            }
    
// frame top front-back
    translate([787, -0, wheel_radius_front -85]) 
        rotate([0, 90, 0])
            pipe_50_30(500);

// frame top, back - center
    translate([wheels_front_back_distance + wheel_radius_front + 24, -0, wheel_radius_front + 513]) 
        rotate([0, -(90+29), 0])
            difference(){
                pipe_50_30(1228);
                translate ([0, -1, 1057])
                    rotate([-90, 0, 0])
                        cylinder(r = 17, h = 52, center = true);
                /*
                rotate([0, 30, 0])
                    pipe_50_30(90);
                    */
            }
            ;
// FIRST shaft between frames, bottom 1
        translate ([first_bottom_bar_at, 320, wheel_radius_back])
            rotate([90, 0, 0])
                cylinder_27 (640);

// SECOND
// horizontal bar
    translate ([second_bottom_bar_at, 252, wheel_radius_back])
        rotate([90, 0, 0])
            cylinder_32 (504)
            ;         
//  solar panels, second support; internal
    translate([second_bottom_bar_at, -268, wheel_radius_back - 16])
        //rotate([0, 0, frame_bottom_rotation_angle])
            mirror([0, 1, 0])
                pipe_panel_suport_center(715, 55)
                ;

//  solar panels, second support; internal
    translate([second_bottom_bar_at, 268, wheel_radius_back - 16])
        //rotate([0, 0, frame_bottom_rotation_angle])
            //mirror([0, 1 , 0])
                pipe_panel_suport_center(715, 55)
                ;

//  solar panels, second support; external
    translate([second_bottom_bar_at, -275, wheel_radius_back - 3.5])
        //rotate([0, 0, frame_bottom_rotation_angle])
            rotate([57, 0, 0])
                pipe_panel_suport_center (610, 65)
                ;

//  solar panels, second support; external
    translate([second_bottom_bar_at, 275, wheel_radius_back - 3.5])
        //rotate([0, 0, frame_bottom_rotation_angle])
            mirror([0, 1 , 0])
            rotate([57, 0, 0])
                pipe_panel_suport_center(610, 65)
                ;
// crank
    translate([human_pos_X + crank_arm_length, 0, 350])
        rotate ([90, 0, 0]) 
                crank_with_tail(200);    

//seat
    translate([human_pos_X + 700, -250, wheel_radius_back + 25])
            seat();   

// handle bar            
    translate([900, -0, wheel_radius_front - 45])
        handle_bar();
        
// direction shaft        
    translate([0, -100, wheel_radius_front - 105])
        rotate([0, 0, -90])
            direction_control_shaft(bar_length = 865);

//amortizor  
    translate([first_bottom_bar_at, -330, wheel_radius_back + 25])
        //rotate([0, 0, frame_bottom_rotation_angle])
            rotate([1, 0, 0])
                color("black")cylinder (h = 320, r = 10)
                ;
}
//---------------------------------------------------------------------------------------
module trike_with_panels()
{
    trike();
// front 
    translate([panel_front_offset_X, -0, panel_front_offset_Y]) 
        rotate([0, -wing_front_ramp_angle, 0]) 
            solar_wing_with_hinges(wing_front_fly_angle, solar_panel_front_size, angle2 = wing_front_crack_angle, space = 30);
            
           
// back 
    
    translate([solar_panel_front_size[0] + solar_panel_back_size[0] + panel_back_offset_X, 0, panel_back_offset_Y])
        rotate([0, wing_back_ramp_angle, 0]) 
        mirror([1, 0, 0])
            solar_wing(wing_back_fly_angle, solar_panel_back_size, angle2 = wing_back_crack_angle, space = 30);
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
//trike_with_panels_and_human();
//trike_with_human();
trike_with_panels();
//trike();

//solar_panel_with_support(solar_panel_front_size);
//solar_panel_with_support_and_balamale(solar_panel_front_size);
//solar_wing(wing_front_opening_angle, solar_panel_front_size, 10);
//solar_panel_with_enhanced_frame_and_support(solar_panel_front_size, 0, 0);
//solar_panel_with_enhanced_frame_and_support_and_hinges(solar_panel_front_size);

//pipe_panel_suport_center(200);

//wheel_front_support();
//wheel_with_front_support(angle_wheel);

//frame_front();
//frame_back();
//frame_bottom();

//handle_bar();

//direction_control_shaft(200);

//direction_control_corner();

//solar_panel_hinge_bar(length = 100, top = 10, bottom = 20, angle_top = 45, angle_bottom = 45);

//crank_with_tail(200);