// Solar Big Bear

// last update 2025.10.07

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

//---------------------------------------------------------------------------------------
module wheel(radius, thick, shaft_thick = 7)
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
        cylinder(h = 112, r = 11, center = true);
        //ax
        cylinder(h = 180, r = shaft_thick, center = true);
    }
}
//---------------------------------------------------------------------------------------
module crank(arm_length, arm_pos_angle, disk_radius = 60)
{
    color("Magenta"){
        rotate([0, 0, arm_pos_angle]){
            cylinder(h = 70, r = 30, center = true);
//arms
        translate([0, 0, -50])
            rotate([-90, 0, 0])
                cylinder(h = arm_length, r = 10);
                
            translate([0, 0, 50])
            rotate([90, 0, 0])
                cylinder(h = arm_length, r = 10);
                
        // pedals
            translate([-25, arm_length, -135])
                cube([50, 10, 95]);
                
            translate([-25, -arm_length, 40])
                cube([50, 10, 95]);
        }
        // shaft
        cylinder(h = 160, r = 19.5, center = true);
        // disk 
        translate([0, 0, 35])
        cylinder(h = 3, r = disk_radius);
    }
}

//---------------------------------------------------------------------------------------
//wheel(100);

crank(100, 10, 60);