// Solar-Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2025.11.3
//---------------------------------------------------------------------------------------
module pipe_50_30_2(length)
{
    translate([-25, -15, 0])
        difference(){
            color("DarkSlateGray")
                cube([50, 30, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([46, 26, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_50_20_2(length)
{
    translate([-25, -10, 0])
        difference(){
            color("DarkSlateGray")
                cube([50, 20, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([46, 16, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_40_40_2(length)
{
    translate([-20, -20, 0])
        difference(){
            color("DarkSlateGray") cube([40, 40, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([36, 36, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module cylinder_32(length) // 1 inch
{
    difference(){
        color("DarkSlateGray")
            cylinder(h= length, r = 16);
        translate([0, 0, -2])
        color("DarkSlateGray")
        cylinder(h= length + 4, r = 14);
    }
}
//---------------------------------------------------------------------------------------
module cylinder_27(length) // 3/4 inches
{
    difference(){
        color("DarkSlateGray")
            cylinder(h= length, r = 13.5);
        translate([0, 0, -2])
        color("DarkSlateGray")
        cylinder(h= length + 4, r = 11.5);
    }
}
//---------------------------------------------------------------------------------------
module cylinder_1_2(length) // 1/2 inches
{
    difference(){
        color("DarkSlateGray")
            cylinder(h= length, r = 10.6);
        translate([0, 0, -2])
        color("DarkSlateGray")
        cylinder(h= length + 4, r = 8.6);
    }
}
//---------------------------------------------------------------------------------------
module corner_30_30_3(length)
{
    difference(){
        color("DarkSlateGray")
            cube([30, length, 30]);
        translate([3, -3, 3])
            color("DarkSlateGray")
                cube([28, length + 6, 28]);
    }
}
//---------------------------------------------------------------------------------------
module corner_30_30_2_5(length)
{
    difference(){
        color("DarkSlateGray")
            cube([30, length, 30]);
        translate([2.5, -3, 2.5])
            color("DarkSlateGray")
                cube([28, length + 6, 28]);
    }
}
//---------------------------------------------------------------------------------------
module corner_40_40_4(length)
{
    difference(){
        color("DarkSlateGray")
            cube([length, 40, 40]);
        translate([-2, 4, 4])
            color("DarkSlateGray")
                cube([length + 4, 38, 38]);
    }
}
//---------------------------------------------------------------------------------------
module corner_50_50_5(length)
{
    difference(){
        color("DarkSlateGray")
            cube([length, 50, 50]);
        translate([-2, 5, 5])
            color("DarkSlateGray")
                cube([length + 4, 46, 46]);
    }
}
//---------------------------------------------------------------------------------------
module T_40_5(length)
{
    difference(){
        color("DarkSlateGray")
            translate([0, -20, 0])
                cube([length, 40, 40]);
                
        translate([-2, -21, 5])
            color("DarkSlateGray")
                cube([length + 4, 18.5, 38]);
                
        translate([-2, 2.5, 5])
            color("DarkSlateGray")
                cube([length + 4, 18.5, 38]);
    }
}
//---------------------------------------------------------------------------------------
module hinge_bar_with_nuts(length, top, bottom)
{
    color("DarkGreen") 
    rotate([-90, 0, 0])
            cylinder(h = length + top + bottom, r = 8);

   // nut; top
    translate([0, bottom+30, 0])
        rotate([-90, 0, 0])
                rotate([0, 0, 0])
                    cylinder(h = 40, r = 13.5, $fn = 6)
                    ;
   // nut; bottom
    translate([0, length - 40 - 30 + bottom, 0])
        rotate([-90, 0, 0])
                rotate([0, 0, 0])
                    cylinder(h = 40, r = 13.5, $fn = 6)
                    ;
                    /*
   // nut middle; maybe I do not need this
    translate([0, length / 2, 0])
        rotate([-90, 0, 0])
                rotate([0, 0, 0])
                    cylinder(h = 40, r = 13.5, $fn = 6);
*/                    
}
//---------------------------------------------------------------------------------------
module corner_with_bar(corner_length, top = 0, bottom = 0, bar_offset_x = 6)
{
    corner_30_30_3(corner_length);
    translate([bar_offset_x, -bottom, -6])
        rotate([-90, 0, 0])
            cylinder(corner_length + top + bottom, r = 6);
}
//---------------------------------------------------------------------------------------
module corner_with_hinge_bar(corner_length, top = 0, bottom = 0, bar_offset_x = 6)
{
    corner_30_30_3(corner_length);
            
    translate ([bar_offset_x, -bottom, - 12]) {
            hinge_bar_with_nuts(corner_length, top, bottom);
    }
}
//---------------------------------------------------------------------------------------
//corner_with_hinge_bar(corner_length = 1000, top = 20, bottom = 50, bar_offset_x = 6);

corner_50_50_5(100);