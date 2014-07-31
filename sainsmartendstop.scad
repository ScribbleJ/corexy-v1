// Mounting clamp for SainSmart Endstop on smooth rod.
// Print 6.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

endstop();

bolt_sep = 19;

module endstop()
{
  difference()
  {
    cube([bolt_sep+misc_nut_r*2,misc_nut_r*2+1,rod_r-1+3]);
    translate([bolt_sep/2+misc_nut_r,-1,rod_r+3]) rotate([-90,0,0]) polyhole(r=rod_r,h=huge,v=32);
    for(x=[bolt_sep/2,-bolt_sep/2])
      translate([bolt_sep/2+misc_nut_r+x,misc_nut_r+0.5,-1]) polyhole(r=misc_bolt_r,h=huge);
  }
}
