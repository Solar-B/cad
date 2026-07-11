// Solar Bear
// A hybrid Sun/muscle-powered trike

// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io

// License: MIT

//---------------------------------------------------------------------------------------
// Version: 28.1
// last update: 2026.07.11.0
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
solar_panel_front_size = [1510, 665, 3];
solar_panel_rear_size = [540, 665, 3]; // actually it is [540, 610, 3]
//---------------------------------------------------------------------------------------
wing_front_fly_angle = 50;
wing_front_ramp_angle = 8;
wing_front_crack_angle = 8;

wing_rear_fly_angle = 46.4;
wing_rear_ramp_angle = 21.0;
wing_rear_crack_angle = 24.0;
//---------------------------------------------------------------------------------------
wing_front_offset_X = -10;
wing_front_offset_Y = 765;

wing_rear_offset_X = wing_front_offset_X -130;
wing_rear_offset_Y = 807;
//---------------------------------------------------------------------------------------

wheel_radius_front = 270;// 20"
wheel_radius_rear = 335; // 26"
wheel_thick = 50;
wheel_hub_small_front = 112;
wheel_hub_small_rear = 127 +3;
//---------------------------------------------------------------------------------------

wheels_front_distance = 1400;
dist_bearing_to_wheel = 27;
wheels_front_rear_distance = 1570;
bottom_frame_length = wheels_front_rear_distance + wheel_radius_rear + 48;

frame_front_distance_between_bottom_frames = 468;

//---------------------------------------------------------------------------------------
wing_support_dist_to = 1470;
//---------------------------------------------------------------------------------------
human_hip_angle = 45;
human_pos_X = wing_front_offset_X + 30;
human_pos_Y = 380;
//---------------------------------------------------------------------------------------
frame_front_height = 570;

frame_rear_height = 585;
frame_rear_length = 970;

frame_bottom_rotation_angle = -1.53;
//---------------------------------------------------------------------------------------
handle_bar_pos = 940;
handle_bar_length = 800;
handle_bar_arm_height = 300;
handle_bar_arm_angle = 30;

//---------------------------------------------------------------------------------------
//angle_direction_control = 30;

offset_wheel = 16.75;
r = sqrt(155*155 + offset_wheel * offset_wheel);
angle_initial = atan(offset_wheel/ 105);

//echo(angle_initial = angle_initial);

angle_wheel_1 = 0;//angle_initial + handle_bar_arm_angle;
angle_wheel_2 = 0;//handle_bar_arm_angle+angle_initial;

//---------------------------------------------------------------------------------------
crank_arm_length = 170;
crank_pedal_angle = -90;
crank_y = wheel_radius_front + 45;
//---------------------------------------------------------------------------------------
door_angle = 0;
fork_stick_radius = 14.26;// 1 1/8 inch
//---------------------------------------------------------------------------------------
castor_angle = 10;
//---------------------------------------------------------------------------------------
module wheel_front_support()
{
    difference(){
// corner
        union(){
            translate([-100, -M14_nut_key_size / 2 - 10 - 4 + 2, -0])
                corner_angled_40_40_4(220, 90);
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
            screw_M14_hexa(280);
        
        // direction
    translate([-100 - 3, -M14_nut_key_size / 2 - 10 - 4 - 28, -0]){
        difference(){
            corner_30_30_3(70);
            translate([15, 15, -1]) 
                cylinder (h = 7, r = 5);
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
        
        rotate([0, castor_angle, 0])
            translate([0, 0, -( 4 + M14_nut_thick + 12.5)]) 
                //mirror([0, 0, 1])
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
module frame_front_wheel_connector(extension_length)
{
    aa = 35;
    rr = 24.1;
    
    echo("bearing center y=",dist_bearing_to_wheel);
    difference(){
        translate([0, - dist_bearing_to_wheel, 0])
            rotate([-90, 0, 0])
                pipe_40_40_2(2 * dist_bearing_to_wheel + extension_length);
                
            // holes for wheels support
        translate([0, -wheels_front_distance / 2, -21])
            cylinder(h = 42, r = 12);
        translate([0, wheels_front_distance / 2, -21])
            cylinder(h = 42, r = 12);

        echo("screw pos x (from edge)= ",20-sin(aa) * rr);
        echo("screw pos y (from center)= ",cos(aa) * rr);
        
        echo("screw pos y1 (from edge) = ",dist_bearing_to_wheel+cos(aa) * rr);
        echo("screw pos y2 (from edge) = ",dist_bearing_to_wheel-cos(aa) * rr);
        // bearings
        translate([0, -wheels_front_distance / 2, 0]){
            translate([0, 0, 15])
                bearing_conic_30202();
        
            translate([0, 0, -15 - 11])
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

    translate([0, 0, 20])
        bearing_conic_30202();
     translate([0, 0, -20 - 11])
            bearing_conic_30202();

}
//---------------------------------------------------------------------------------------
module frame_front()
{
    echo ("horizontal bar length = ", wheels_front_distance - 2 * dist_bearing_to_wheel);
    difference(){
        translate([0, -wheels_front_distance / 2 + dist_bearing_to_wheel, 0])
        rotate([-90, 0, 0])
            cylinder(h = wheels_front_distance - 2 * dist_bearing_to_wheel, r = 17);            
            
            
// holes for connecting solar wing
echo(frame_front_distance_between_bottom_frames = frame_front_distance_between_bottom_frames);
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
//    
    // screws for solar wing
    translate([-26, - frame_front_distance_between_bottom_frames, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);
            
    translate([-26, + frame_front_distance_between_bottom_frames, -0])
        rotate([0, 90, 0])
            screw_M8_hexa(60);

    // frame wheel-connectors
    translate([0, -wheels_front_distance / 2 + dist_bearing_to_wheel +150, 0])
            translate([0, -dist_bearing_to_wheel -150, 0])
                frame_front_wheel_connector(150);
                
    translate([0, wheels_front_distance / 2 - dist_bearing_to_wheel -50, 0])
            translate([0, dist_bearing_to_wheel +50, 0])
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
        // base       
        translate([10, 40, 0])
            rotate([0, 0, 180])
                corner_30_23_3(80);
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
module frame_rear()
{      
// horizontal
echo(frame_rear_length = frame_rear_length);

echo("holes for connecting bottom frame to front-rear =", [15, 148/2 + 20]);
    difference(){
        translate([0, -frame_rear_length / 2, 0])
            rotate([0, -90, 0])
                corner_25_25_3(frame_rear_length);
// holes for connecting bottom frame to front-rear
        translate([-15, - (130/2 + 19), -11])
            cylinder(h = 42, r = 4);
        translate([-15, + (130/2 + 19), -11])
            cylinder(h = 42, r = 4);
            
// hole for connecting wing to bottom side
echo("hole for connecting wing to bottom side (from end-bottom)", [18, 11]);
        translate([1, frame_rear_length / 2 - 18, 11])
            rotate([0, -90, 0])
            cylinder(h = 50, r = 4);
    }
            // screws for connecting to bottom side
        translate([-15, - (130/2 + 19), -11])
            cylinder(h = 60, r = 4);
        translate([-15, + (130/2 + 19), -11])
            cylinder(h = 60, r = 4);

            // screws for connecting wing to rear side, bottom
    translate([6, frame_rear_length / 2 - 18, 11])
        rotate([0, -90, 0])
        screw_M8_hexa(30);
    translate([6, -(frame_rear_length / 2 - 18), 11])
        rotate([0, -90, 0])
        screw_M8_hexa(30);
    
// vertical part
echo(frame_rear_height = frame_rear_height);
echo("frame_rear_vertical holes from top", 33);
    translate([-13, 0, 3]){
        translate([-3, 0, 3])
            difference(){
                rotate([0, 0, 90])
                    pipe_40_20_2(frame_rear_height);
                
    // holes for connecting solar wing, top side
                translate([0, -10, frame_rear_height - 33])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
                translate([0, 10, frame_rear_height - 33])
                rotate([0, 90, 0])
                cylinder (h = 22, r = 4, center = true);
            }
        translate([10, 40, 0])
            rotate([0, 0, 180])
                corner_23_30_3(80);
    }
}
//---------------------------------------------------------------------------------------
module frame_bottom(_thin = false)
{
    echo(bottom_frame_length = bottom_frame_length);

    difference(){    
        rotate([0, 90, 0])
            difference(){
                pipe_30_20_2(bottom_frame_length);
                if (_thin){ // this is required because the space between pedal and gear is too small
                    translate([-16, 0, 30])
                        cube([32, 11, 400]);
                    
                }
            }

// vertical holes to connect to front frame
            echo("hole to connect to front frame(vertical)=", 12);
            translate([12, 0, -21])
                cylinder(h = 42, r = 4);
                echo("hole to connect to front frame(horizontal)=", 20);
            translate([20, 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 4);

// hole for wheel hub rear
            echo("hole for wheel rear", (wheel_radius_rear + 27));
            translate([bottom_frame_length - (wheel_radius_rear + 27), 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 5);
                    
// hole for wing support   
            echo("hole for wing support", (wing_support_dist_to + 25 + 20));
            translate([wing_support_dist_to + 25 + 20, 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 4);
            echo("hole for wing support", (wing_support_dist_to - 25 + 20));
            translate([wing_support_dist_to -25 + 20, 11, 0])
                rotate([90, 0, 0])
                    cylinder(h = 22, r = 4);
                    
// rear frame hole
            echo("hole for rear frame(vertical)-from end", (wheel_radius_rear + 27));
            translate([bottom_frame_length - 12, 0, -21])
                cylinder(h = 42, r = 4);
                
    }
}
//---------------------------------------------------------------------------------------
module pipe_panel_suport_center(_length, top_cut_angle, top_dist_to_holes)
{
    difference(){
        rotate([0, 0, 90])
            pipe_15_15_1_5(length = _length);
            
// holes for screws

        // cut top angle
        translate([-26, -15, _length])
            rotate([-top_cut_angle, 0, 0])
                cube([52, 59, 30]);
    }
    
    // screws
    translate([0, 0, _length - top_dist_to_holes * cos(top_cut_angle) - tan(top_cut_angle) * (10 - 8)])
    translate([-40, -0, 0])
        rotate([0, 90, 0])
            cylinder(h=80, r = 4);
/*
    translate([0, 0, _length - top_dist_to_holes * cos(top_cut_angle) - tan(top_cut_angle) * (15 + 8)])
    translate([-30, 8, 0])
        rotate([0, 90, 0])
            cylinder(h=60, r = 4);
*/
}
//---------------------------------------------------------------------------------------
module solar_wings_support()
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
    echo("internal pipe_panel_suport_center (length = 693, base_cut angle:  37, top_cut_angle : 37, top_dist_to_holes : 30)");
    
    translate([0, 12.1, 22.1])
        rotate([-15, 0, 0])
            pipe_panel_suport_center(693, top_cut_angle = 37, top_dist_to_holes = 30)
                ;
//  solar panels, second support; external
    
    echo("external pipe_panel_suport_center(lenght = 598, base_cut_angle = 23, top_cut_angle = 17, top_dist_to_holes = 15)");
        translate([0, -1.2, 12])
            mirror([0, 1 , 0])
            rotate([67.2, 0, 0])
            //rotate([0, 0, 90])
                pipe_panel_suport_center(598, top_cut_angle=17, top_dist_to_holes = 15)
                ;

}
//---------------------------------------------------------------------------------------
module handle_bar()
{
// horizontal
    translate([0, -handle_bar_length / 2, 0])
        rotate([-90, 0, 0])
            pipe_30_20_2(handle_bar_length);
            
// hand bars            
    translate([0, -handle_bar_length / 2 + 13, 0])
        rotate([0, -handle_bar_arm_angle, 0])
            cylinder_1_2(handle_bar_arm_height);
            
    translate([0, handle_bar_length / 2 - 13, 0])
        rotate([0, -handle_bar_arm_angle, 0])
            cylinder_1_2(handle_bar_arm_height);
}
//---------------------------------------------------------------------------------------
module motor_with_crank_and_chain(connector_length)
{
    motor_with_crank(connector_length);
    translate([0, 50, -70])
        cube([1500, 10, 10]);
    translate([0, -60, -70])
        cube([1500, 10, 10]);
}
//---------------------------------------------------------------------------------------
module chain_deviation()
{
    cylinder(h = 40, r = 20);
}
//---------------------------------------------------------------------------------------
module frame_front_with_wheels()
{
//wheels, front
    translate ([0, wheels_front_distance / 2, wheel_radius_front]) 
        mirror([0, 1, 0])
            wheel_with_front_support(angle_wheel_1);
            
    translate ([0, -wheels_front_distance / 2, wheel_radius_front]) 
        wheel_with_front_support(-angle_wheel_2) ;

// frame between wheels, front
    translate ([-17, 0, wheel_radius_front -58])
            rotate([0, castor_angle, 0])
            frame_front_with_direction_control()   ;
}
//---------------------------------------------------------------------------------------
module trike_base()
{
    frame_front_with_wheels();
       
//wheel, rear
    translate([wheels_front_rear_distance, 0, wheel_radius_front - 5])
        rotate([90, 0, 0])
            wheel_with_gears(wheel_radius_rear, wheel_thick, 7, 2, 45, wheel_hub_small_rear);

                    
// motor with crank
    translate([human_pos_X + crank_arm_length - 10, -20, crank_y])
    rotate ([0, 90, 0]) 
        rotate ([90, 0, 0]) 
                motor_with_cranks(arm_length = 170, arm_pos_angle = 0, disk_radius = 60);

// frame bottom left
    translate([-19, -30, wheel_radius_front - 5]) 
        rotate([0, 0, frame_bottom_rotation_angle])
            frame_bottom(_thin = false);
            
// frame bottom right
    translate([-19, 30, wheel_radius_front - 5])
        rotate([0, 0, -frame_bottom_rotation_angle])
                frame_bottom(_thin = true);
            
//rear frame
     translate([wheels_front_rear_distance + wheel_radius_rear + 31, -0, wheel_radius_front - 23])
              frame_rear();

//wings support            
      translate([wing_support_dist_to, 80, wheel_radius_front - 20])
      rotate([0, 0, -frame_bottom_rotation_angle])
        solar_wings_support()
        ;
        
        translate([wing_support_dist_to, -80, wheel_radius_front - 20])
        rotate([0, 0, frame_bottom_rotation_angle])
        mirror([0, 1, 0])
        solar_wings_support()
        ;
        
// horizontal bar to connect solar wings supports

    translate ([wing_support_dist_to - 2, 175, wheel_radius_front + 340])
        //rotate([0, 90, 0])
            rotate([90, 0, 0])
                pipe_15_15_1_5(350)
            ;
        

//seat
    translate([human_pos_X + 700, -225, wheel_radius_front + 25])
            trike_seat(human_hip_angle);   

// handle bar support
    translate([handle_bar_pos, 45, wheel_radius_front - 5])
        rotate([90, 0, 0])
        pipe_30_30_2(100);
            
// handle bar            
    translate([handle_bar_pos, -0, wheel_radius_front - 45])
        rotate([0, 0, -handle_bar_arm_angle])
        handle_bar();
        
// direction shaft        
    translate([0, -65, wheel_radius_front - 105])
        rotate([0, 0, -90])
            direction_control_shaft(bar_length = 865);

// damper  
    //translate([first_bottom_bar_at, -330, wheel_radius_front + 25])
        //rotate([0, 0, frame_bottom_rotation_angle])
      //      rotate([1, 0, 0])
               // color("black")cylinder (h = 320, r = 10)
                ;
}
//---------------------------------------------------------------------------------------
module solar_wings(_show_panels, _show_frame)
{
// front 
echo("solar_wing_metal_support front: length = 668+45+61 = 774, angle = 50");
    translate([wing_front_offset_X, -0, wing_front_offset_Y]) 
        rotate([0, -wing_front_ramp_angle, 0]) 
            solar_wing(wing_front_fly_angle, solar_panel_front_size, angle2 = wing_front_crack_angle, space = 20, open_door_angle = door_angle, offset_top = 45, offset_bottom = 61, $show_panels = _show_panels, $show_frame = _show_frame);
            
           
// rear    
echo("solar_wing_metal_support rear: length = 668+40+58 = 766, angle = 46");
    translate([solar_panel_front_size[0] + solar_panel_rear_size[0] + wing_rear_offset_X, 0, wing_rear_offset_Y])
        rotate([0, wing_rear_ramp_angle, 0]) 
        mirror([1, 0, 0])
            solar_wing(wing_rear_fly_angle, solar_panel_rear_size, angle2 = wing_rear_crack_angle, space = 20, offset_top = 40, offset_bottom = 58, open_door_angle = 0,
            $show_panels = _show_panels, $show_frame = _show_frame);
}
//---------------------------------------------------------------------------------------
module trike_with_solar_panels()
{
    trike_base();
    solar_wings(true, true);
}
//---------------------------------------------------------------------------------------
module trike_with_solar_panels_frame()
{
    trike_base();
    
    solar_wings(false, true);
}
//---------------------------------------------------------------------------------------
module trike_with_solar_panels_support()
{
    trike_base();
    solar_wings(false, false);
}
//---------------------------------------------------------------------------------------
module trike_base_with_human()
{
    trike_base();
// human 
    translate([human_pos_X, 0, human_pos_Y])
        rotate([0, 90, 0])
            human(human_hip_angle, shoulder_angle = 90, elbow_angle = 90, head_angle = 20);
}
//---------------------------------------------------------------------------------------
module trike_with_solar_panels_and_human()
{
    trike_with_solar_panels();
// human 
    translate([human_pos_X, 0, human_pos_Y])
    rotate([0, 90, 0])
        human(human_hip_angle, shoulder_angle = 0, elbow_angle = 45, head_angle = 20);
}
//---------------------------------------------------------------------------------------
trike_with_solar_panels_and_human();

//trike_with_solar_panels();
//trike_with_solar_panels_frame();

//trike_with_solar_panels_support();

//trike_base();

//solar_panel_with_support(solar_panel_front_size);
//solar_panel_with_support_and_balamale(solar_panel_front_size);
//solar_wing(wing_front_opening_angle, solar_panel_front_size, 10);
//solar_panel_with_enhanced_frame_and_support(solar_panel_front_size, 0, 0);
//solar_panel_with_enhanced_frame_and_support_and_hinges(solar_panel_front_size);

//pipe_panel_suport_center(200, 20, 4);
//pipe_panel_suport_center(705, top_cut_angle = 35, top_dist_to_holes = 27);

//wheel_front_support();
//wheel_with_front_support(20);

//frame_front();
//frame_front_wheel_connector(extension_length = 50);
//frame_front_with_direction_control();
//frame_front_with_wheels();

//frame_rear();
//frame_bottom(true);

//handle_bar();

//direction_control_shaft(200);

//direction_control_corner();

//solar_panel_hinge_bar(length = 100, top = 10, bottom = 20, angle_top = 45, angle_bottom = 45);

//crank_with_connector(200);

//solar_wings_support();

//solar_wings();