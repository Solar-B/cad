// Solar Bear
// A solar trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2026.9.6.2
//---------------------------------------------------------------------------------------
module solar_panel(panel_size)
{
    color("silver")
        cube(panel_size);
        
    translate([10, 10, panel_size[2]])
        color("black")
            cube([panel_size[0], panel_size[1], 2] - [20, 20, 0]);
            
// electric contact
    translate([panel_size[0] - 100 - 25 - 25, panel_size[1] / 2 - 50, panel_size[2] - 20])
        color("black")
            cube([100, 100, 20]);
}
//---------------------------------------------------------------------------------------
module solar_panel_with_support(
    panel_size, 
    bar_offset_left_bottom = 0, 
    bar_offset_left_top = 0, 
    bar_offset_right_bottom = 0, 
    bar_offset_right_top = 0, 
    show_panels = true)
{
    if (show_panels == true)
        translate([0, 0, 12.5])
			solar_panel(panel_size);        
    
// frame, on length

    translate([25, 0, 0])
        rotate([0, 90, 0])
        color("Silver") 
            cylinder(h = panel_size[0] - 50, r = 12.5)
        ;
// other length
    translate([25, panel_size[1] - 25, 0])
        rotate([0, 90, 0])
        color("Silver") 
            cylinder(h = panel_size[0] - 50, r = 12.5);
    
// frame on width    
// left side
    translate ([12.5, -bar_offset_left_bottom, 0]) 
    rotate([-90, 0, 0])
            cylinder(h = panel_size[1] + bar_offset_left_bottom + bar_offset_left_top, r = 12.5);//30, 25, 50, 50)// these values are hard-coded
    ;
// right side        
    translate ([panel_size[0]-12.5, -bar_offset_right_bottom, 0]) 
        mirror([1, 0, 0])
            difference(){
            rotate([-90, 0, 0])
                cylinder(h = panel_size[1] + bar_offset_right_bottom + bar_offset_right_top, r = 12.5);
                
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
module solar_panel_with_support_as_door(
                        panel_size, 
                        _door_angle = 0, 
                        bar_offset_left_bottom = 0, 
                        bar_offset_left_top = 0, 
                        bar_offset_right_bottom = 0, 
                        bar_offset_right_top = 0, 
                        show_panels = true)
{
    rotate([0, -_door_angle, 0])
        solar_panel_with_support(
            panel_size, 
            bar_offset_left_bottom, 
            bar_offset_left_top, 
            bar_offset_right_bottom, 
            bar_offset_right_top, 
            show_panels);           
}
//---------------------------------------------------------------------------------------
module solar_wing(
    angle_fly, 
    panel_size, 
    angle_crack, 
    space_between_panels, 
    open_door_angle, 
    offset_top, 
    offset_bottom, 
    show_panels = true)
{
    rotate([0, 0, angle_crack])
        rotate([-angle_fly, 0, 0])
            translate([0, space_between_panels, 0]) 
        
                solar_panel_with_support(
                    panel_size, 
                    bar_offset_left_bottom = offset_top, //52
                    bar_offset_left_top = offset_bottom, //100, 
                    bar_offset_right_bottom = 0, 
                    bar_offset_right_top = 0, 
                    show_panels);
        
    rotate([0, 0, -angle_crack])
        rotate([angle_fly, 0, 0])
            translate([0, - space_between_panels, 0])
            mirror([0, 1, 0])
                solar_panel_with_support_as_door(
                    panel_size,
                    open_door_angle,
                    bar_offset_left_bottom = offset_top, //52, 
                    bar_offset_left_top = offset_bottom, //100, 
                    bar_offset_right_bottom = 0, 
                    bar_offset_right_top = 0, 
                    show_panels);
}
//---------------------------------------------------------------------------------------
//solar_panel(solar_panel_front_size);

/*
solar_panel_with_support(panel_size = [1485, 668, 30], 
    _door_angle = 20, 
    bar_offset_left_bottom = 45, 
    bar_offset_left_top = 61, 
    bar_offset_right_bottom = 30, 
    bar_offset_right_top = 40);
*/
  
solar_wing(angle_fly = 50, 
            panel_size=[1485, 668, 3], 
            angle_crack = 8, 
            space_between_panels = 20, 
            open_door_angle = 0, 
            offset_top = 45,  
            offset_bottom = 61, 
            show_panels = true);