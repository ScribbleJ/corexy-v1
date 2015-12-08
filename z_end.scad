// Z end rod holder
// Print 2
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <platform.scad>

z_end();

module z_end(motor=false)
{
  rod_holder_r = motor_w/2 + bushing_material_thick + corner_thick + rod_r;
  difference()
  {
    union()
    {
      cube([z_rod_sep,tslot_w,corner_thick]);
      translate([0,-corner_thick,0])
      {
        scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);
        translate([z_rod_sep,0,0]) scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);
      }
    }
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);

    // Rod holders
    translate([0,0,corner_thick + motor_w/2])
    {
      rotate([-90,0,0])
      {
        polyhole(r=rod_r,h=huge,v=8,a=360/16);
        translate([z_rod_sep,0,0]) polyhole(r=rod_r,h=huge,v=8,a=360/16);
      }
    }

    // Tslot bolts
    for(x=[rod_holder_r/2 - tslot_bolthead_r,z_rod_sep - rod_holder_r/2 + tslot_bolthead_r,
           -rod_holder_r/2 + tslot_bolthead_r,z_rod_sep + rod_holder_r/2 - tslot_bolthead_r
          ])
    {
      translate([x,tslot_w/2,corner_thick]) bolt(tslot_bolt_r,tslot_bolthead_r);
    }
  }

  if(motor)
  {
    difference()
    {
      translate([z_rod_sep/2 - motor_w/2 - corner_thick, -motor_h-motor_bracket_thick+tslot_w+corner_thick,0]) cube([motor_w + corner_thick*2, motor_h + motor_bracket_thick, motor_w + corner_thick]);

      translate([z_rod_sep/2 - motor_w/2, -motor_h + tslot_w + corner_thick, corner_thick]) cube([motor_w, motor_h+1, motor_w+1]);
      translate([0,tslot_w+corner_thick,corner_thick]) rotate([45,0,0]) cube([huge,huge,huge]);
      translate([z_rod_sep/2,0,corner_thick + motor_w/2])
      {
        rotate([90,0,0]) polyhole(r=motor_flange_r,h=huge);
        for(x=[-motor_bolt_sep/2,motor_bolt_sep/2])
        for(z=[-motor_bolt_sep/2,motor_bolt_sep/2])
        {
          translate([x,0,z]) rotate([90,0,0]) polyhole(r=misc_bolt_r,h=huge);
        }
      }
    }

  }
}
