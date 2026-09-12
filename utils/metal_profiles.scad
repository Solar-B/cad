// Solar-Bear
// A solar-hybrid trike
// https://github.com/solar-b

// Maker: Mihai Oltean
// https://mihaioltean.github.io
// License: MIT

// last update 2026.07.10
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
module pipe_40_20_2(length)
{
    translate([-20, -10, 0])
        difference(){
            color("DarkSlateGray")
                cube([40, 20, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([36, 16, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_40_10_1_5(length)
{
    translate([-20, -5, 0])
        difference(){
            color("DarkSlateGray")
                cube([40, 10, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([36, 7, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_30_20_2(length)
{
    translate([-15, -10, 0])
        difference(){
            color("DarkSlateGray")
                cube([30, 20, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([26, 16, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_20_20_2(length)
{
    translate([-10, -10, 0])
        difference(){
            color("DarkSlateGray")
                cube([20, 20, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([16, 16, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_15_15_1_5(length)
{
    translate([-7.5, -7.5, 0])
        difference(){
            color("DarkSlateGray")
                cube([15, 15, length]);
            translate([1.5, 1.5, -2])
            color("DarkSlateGray")
                cube([12, 12, length + 4]);
        }
}
//---------------------------------------------------------------------------------------
module pipe_30_30_2(length)
{
    translate([-15, -15, 0])
        difference(){
            color("DarkSlateGray")
                cube([30, 30, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([26, 26, length + 4]);
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
module pipe_40_30_2(length)
{
    translate([-20, -15, 0])
        difference(){
            color("DarkSlateGray") cube([40, 30, length]);
            translate([2, 2, -2])
            color("DarkSlateGray")
                cube([36, 26, length + 4]);
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
module corner_30_23_3(length)
{
    difference(){
        color("DarkSlateGray")
            cube([30, length, 23]);
        translate([3, -3, 3])
            color("DarkSlateGray")
                cube([28, length + 6, 21]);
    }
}
//---------------------------------------------------------------------------------------
module corner_23_30_3(length)
{
    difference(){
        color("DarkSlateGray")
            cube([23, length, 30]);
        translate([3, -3, 3])
            color("DarkSlateGray")
                cube([24, length + 6, 28]);
    }
}
//---------------------------------------------------------------------------------------
module corner_25_25_3(length)
{
    difference(){
        color("DarkSlateGray")
            cube([25, length, 25]);
        translate([3, -3, 3])
            color("DarkSlateGray")
                cube([23, length + 6, 23]);
    }
}
//---------------------------------------------------------------------------------------
module corner_40_30_3(length)
{
    difference(){
        color("DarkSlateGray")
            cube([40, length, 30]);
        translate([3, -3, 3])
            color("DarkSlateGray")
                cube([38, length + 6, 28]);
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
                cube([length + 4, 40, 40]);
    }
}
//---------------------------------------------------------------------------------------
module corner_angled_40_40_4(length, angle = 90)
{
    color("DarkSlateGray"){
        cube([length, 4, 40]);
        translate([0, 0, 4])
            rotate([-angle, 0, 0])
                cube([length, 4, 40]);
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

//corner_50_50_5(100);
//corner_23_30_3(100);

corner_angled_40_40_4(length = 100, angle = 100);
