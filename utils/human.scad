// Solar-Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2025.10.07

//---------------------------------------------------------------------------------------
module human(body_angle)
{
    color("red"){
        // legs
        translate ([0, -100, 0]) {
            cylinder(h = 900, r = 50);
            hull(){
            // foot
                cylinder(h = 20, r = 50);
                translate([-200, 0, 0])
                    cylinder(h = 20, r = 50);
            }
        }
        translate ([0, 100, 0]) {
            cylinder(h = 900, r = 50);
            hull(){
                cylinder(h = 20, r = 50);
                translate([-200, 0, 0])
                    cylinder(h = 20, r = 50);
            }
        }
        // body
        translate ([-0, 0, 900]) 
            rotate([0, -(90-body_angle), 0]) {
                translate ([-100, -180, 0]) 
                    cube([200, 360, 650]);
                    
// hands                
                translate ([-10, -220, 300]) 
                    cylinder(h = 350, r = 35);
                translate ([-10, -220, 300]) 
                rotate([0, -145, 0])
                    cylinder(h = 350, r = 35);

                    translate ([-10, 220, 300]) 
                    cylinder(h = 350, r = 35);
                    
                translate ([-10, 220, 300]) 
                rotate([0, -140, 0])
                    cylinder(h = 350, r = 35);
        // head
                
                translate ([0, 00, 850]) 
                    //rotate([0, human_angle, 0])
                        
                            sphere(r = 140);
            }
    }
}
//---------------------------------------------------------------------------------------
//human(0);
