// Solar-Bear
// A hybrid trike: powered by Sun and muscles!
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io

// License: MIT

// last update 2026.07.10
//---------------------------------------------------------------------------------------
module wheel(radius, thick, shaft_thick = 7, small_hub_length = 112)
{
    color("blue"){
    // wheel
        difference(){
            cylinder(h = thick, r = radius, center = true);
            translate ([0, 0, -1])
                cylinder(h = thick + 4, r = radius - 50, center = true);
        }
        // hub big
        cylinder(h = 85, r = 17.5, center = true);
        // hub
        cylinder(h = small_hub_length, r = 11, center = true);
        //ax
        cylinder(h = 180, r = shaft_thick, center = true);
        
//spokes
        for (i=[0:20])
            rotate([0, 0, i*18])
                rotate([0, 90, 0])
                    cylinder(h = radius, r = 2);
    }
}
//---------------------------------------------------------------------------------------
module wheel_with_gears(radius, thick, _shaft_thick = 7, gear_thick = 2, gear_radius = 45, hub_length = 112)
{
    wheel(radius, thick, _shaft_thick, hub_length);
    translate([0, 0, -45])
        cylinder(h = gear_thick, r = gear_radius);
}
//---------------------------------------------------------------------------------------
module wheel_with_break_disk(radius, thick, shaft_thick = 7, break_disk_radius = 80, _hub_length = 112)
{
    wheel(radius, thick, shaft_thick, _hub_length);
    // break
    translate([0, 0, -43]) 
        cylinder(r = break_disk_radius, h = 2);
}
//---------------------------------------------------------------------------------------
module crank(arm_length, arm_pos_angle, disk_radius = 60)
{
    color("Magenta"){
        rotate([0, 0, arm_pos_angle]){
            cylinder(h = 70, r = 30, center = true);
//arms
        translate([0, 0, -80])
            rotate([-90, 0, 0])
                cylinder(h = arm_length, r = 10);
                
            translate([0, 0, 80])
            rotate([90, 0, 0])
                cylinder(h = arm_length, r = 10);
                
        // pedals
            translate([-25, arm_length, -165])
                cube([50, 10, 95]);
                
            translate([-25, -arm_length, 75])
                cube([50, 10, 95]);
        }
        // shaft
        cylinder(h = 160, r = 19.5, center = true);
        // disk 
        translate([0, 0, -65])
        cylinder(h = 3, r = disk_radius);
    }
}

//---------------------------------------------------------------------------------------
module Bafang_M820()
{
    // pedal shaft
    difference(){
        cylinder(h = 148, r = 15, center = true);
        cylinder(h = 152, r = 10, center = true);
    }
    cylinder(h = 100, r = 30, center = true);
    
    // holes support
    translate([45, 0, 0])
        difference(){
            cylinder(h = 44, r = 10, center = true);
            cylinder(h = 46, r = 5, center = true);
        }
        
        
    rotate([0, 0, 81])
    translate([68.5, 0, 0])
        difference(){
            cylinder(h = 44, r = 10, center = true);
            cylinder(h = 46, r = 5, center = true);
        }
        
    rotate([0, 0, 133])
    translate([112.3, 0, 0])
        difference(){
            cylinder(h = 44, r = 10, center = true);
            cylinder(h = 46, r = 5, center = true);
        }
        
// motor        
    rotate([0, 0, 133])
    translate([65, 0, 0])
        cylinder(h = 100, r = 35, center = true);
}
//---------------------------------------------------------------------------------------
module motor_with_cranks(arm_length, arm_pos_angle, disk_radius = 60)
{

    Bafang_M820();
    
    //arms
    translate([0, 0, -80])
        rotate([-90, 0, 0])
            cylinder(h = arm_length, r = 10);
            
        translate([0, 0, 80])
        rotate([90, 0, 0])
            cylinder(h = arm_length, r = 10);
            
    // pedals
        translate([-25, arm_length, -165])
            cube([50, 10, 95]);
            
        translate([-25, -arm_length, 75])
            cube([50, 10, 95]);
    
    // shaft
    cylinder(h = 160, r = 19.5, center = true);
    // disk 
    translate([0, 0, -65])
        cylinder(h = 3, r = disk_radius);
        
}
//---------------------------------------------------------------------------------------
module trike_seat(angle)
{ // not the real one
    color("Green"){
        cube([250, 450, 40]);
        translate([250, 25, 40])
            rotate([0, angle, 0]) 
                cube([30, 400, 600]);
    }
}
//---------------------------------------------------------------------------------------


//wheel(radius = 270, 50, 10, 130);

//wheel_with_gears(radius = 270, thick = 50, _shaft_thick = 7, gear_thick = 2, gear_radius = 45, hub_length = 130);

//Bafang_M820();

motor_with_cranks(arm_length = 170, arm_pos_angle = 0, disk_radius = 60);

//crank(100, 10, 60);