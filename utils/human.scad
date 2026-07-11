// Solar-Bear
// A hybrid trike: powered by Sun and muscles!
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2026.07.01

//---------------------------------------------------------------------------------------
module human(hip_angle, shoulder_angle, elbow_angle, head_angle)
{
    color("blue"){
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
            rotate([0, -(hip_angle), 0]) {
                translate ([-100, -180, 0]) 
                    cube([200, 360, 650]);
                    
// hands                
                translate ([-10, 250, 600]) 
                mirror([0, 0, 1])
                rotate([0, -shoulder_angle, 0]){
                    cylinder(h = 350, r = 35);
                    translate ([0, 0, 300]) 
                        rotate([0, -elbow_angle, 0])
                            cylinder(h = 350, r = 35);
                }
                // other hand
                translate ([-10, -250, 600]) 
                mirror([0, 0, 1])
                rotate([0, -shoulder_angle, 0]){
                    cylinder(h = 350, r = 35);
                    translate ([0, 0, 300]) 
                        rotate([0, -elbow_angle, 0])
                            cylinder(h = 350, r = 35);
                }
                /*
                translate ([-10, -220, 300]) 
                        translate ([0, 0, -300]) 
                            cylinder(h = 350, r = 35);
                        translate ([-10, -220, 00]) 
                            rotate([0, -elbow_angle, 0])
                            cylinder(h = 350, r = 35)
                            ;
                    }

                    translate ([-10, 220, 300]) 
                    cylinder(h = 350, r = 35);
                    
                translate ([-10, 220, 300]) 
                rotate([0, -elbow_angle, 0])
                    cylinder(h = 350, r = 35);
                    */
        // head
                
                translate ([0, 0, 700]) 
                    rotate([0, head_angle, 0])
                        translate ([0, 0, 150]) 
                            sphere(r = 140);
            }
    }
}
//---------------------------------------------------------------------------------------
human(hip_angle = 0, shoulder_angle = 90, elbow_angle = 90, head_angle = 20);
