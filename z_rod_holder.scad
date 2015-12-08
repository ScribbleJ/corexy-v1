// Z rod holder
// Print 4
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <platform.scad>

z_rod_holder();

module z_rod_holder()
{
  rod_holder_r = motor_w/2 + bushing_material_thick + corner_thick + rod_r;

  difference()
  {
    translate([0,-corner_thick,0]) scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);

    // Garbage
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);

    // Rod Hole
    translate([0,tslot_w,corner_thick + motor_w/2])
      rotate([90,0,0])
        polyhole(r=rod_r,h=huge,v=8,a=360/16);

    // Tslot bolts
    for(x=[rod_holder_r/2 - tslot_bolthead_r,-rod_holder_r/2 + tslot_bolthead_r])
    {
      translate([x,tslot_w/2,corner_thick]) bolt(tslot_bolt_r,tslot_bolthead_r);
    }

  }

}
