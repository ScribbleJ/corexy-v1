// Because I'm stupid and cut two rods too short.
include <common.scad>

extender();
module extender()
{
  difference()
  {
    cube([tslot_w+corner_thick*2,tslot_w+corner_thick*2,tslot_w*2]);

    translate([corner_thick,corner_thick,-1]) cube([tslot_w,tslot_w,huge]);
    translate([corner_thick+tslot_w/2,0,tslot_w/2]) rotate([90,0,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);
    translate([corner_thick+tslot_w/2,0,tslot_w*1.5]) rotate([90,0,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);

    translate([0,corner_thick+tslot_w/2,tslot_w/2]) rotate([0,90,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge,a=360/12);
    translate([0,corner_thick+tslot_w/2,tslot_w*1.5]) rotate([0,90,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge,a=360/12);
  }
}
