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
    // support
// on length
    translate([25, panel_size[1] - 20 -5, 1])
        color("Silver") cube([panel_size[0] -25, 20, 20]);
        
    translate([25, 5, 1])
        color("Silver") cube([panel_size[0] -25, 20, 20]);
// screws
/*
    translate([panel_size[0] - 20, panel_size[1] + 20, 10])
        rotate([90, 0, 0])
            color("black") 
                cylinder(h = 100, r = 4);
                */
// on width
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
//---------------------------------------------------------------------------------------
//solar_panel(solar_panel_front_size);

solar_panel_with_enhanced_frame([1485, 668, 30]);