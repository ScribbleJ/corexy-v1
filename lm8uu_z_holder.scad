// Various parts for Z Assembly.
// Print 4 of lm8uu_retainer(), 4 of z_rod_holder(), 2 of z_motor_mount, 2 of z_end()
// TODO: Should be broken out to separate files eventually.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <platform.scad>





//lm8uu_retainer();
//translate([40,0,0]) 
    liftNut_retainer();

module lm8uu_retainer()
{
  difference()
  {
    union()
    {
      cylinder(r=lm8uu_r + corner_thick,h=bed_box_h);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) cylinder(r=lm8uu_nut_r,h=bed_box_h);
    }
    translate([0,0,-1])
    {
      polyhole(r=lm8uu_r,h=huge,v=16);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) polyhole(r=lm8uu_bolt_r,h=huge);
    }
  }
}

module liftNut_retainer()
{
  difference()
  {
    union()
    {
      cylinder(r=lm8uu_r + corner_thick,h=liftNutRetainer_h);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) cylinder(r=lm8uu_nut_r,h=liftNutRetainer_h);
    }
    translate([0,0,-1])
    {
      polyhole(r=liftNut_od/2*1.05,h=liftNut_h*0.6,v=6);
      polyhole(r=liftNut_d/2 * 1.4 ,h=huge,v=16);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) polyhole(r=lm8uu_bolt_r,h=huge);
    }
  }
}