// Clamp for belt on X-carriage.  
// Print 2.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

belt_clamp();

module belt_clamp()
{
    // Holes for belt clamp bolts
    linear_extrude(height=5)
    difference()
    {
      union()
      {
        translate([-misc_nut_r,0]) square([misc_nut_r*2,belt_w*2 + belt_sep + misc_nut_r*2]);
        polycircle(r=misc_nut_r,a=360/12);
        translate([0,belt_w*2+belt_sep+misc_nut_r*2]) polycircle(r=misc_nut_r,a=360/12);
      }
      polycircle(r=misc_bolt_r,a=360/12);
      translate([0,belt_w*2+belt_sep+misc_nut_r*2]) polycircle(r=misc_bolt_r,a=360/12);
    }


    
    //for(y=[x_rod_sep + belt_above_x - misc_nut_r,x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r])
    //for(z=[belt_clamp_w/2,x_carriage_l-belt_clamp_w/2])
    //  translate([-huge/2,y,z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);
}


