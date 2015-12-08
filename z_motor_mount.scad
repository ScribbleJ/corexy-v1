// Z motor mount
// Print 2
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <platform.scad>


z_motor_mount();

module z_motor_mount()
{

  difference()
  {
    union()
    {
      // Basic Bracket
      cube([motor_w + corner_thick*2, motor_w+corner_thick, motor_h+motor_bracket_thick]);
      // ORB
      translate([motor_w/2+corner_thick,motor_w+corner_thick,motor_h+motor_bracket_thick-tslot_w/2-corner_thick]) scale([motor_w+corner_thick*2+tslot_bolthead_r*4+4,(tslot_w+corner_thick)*2,(motor_h+motor_bracket_thick)*2]) sphere(r=.5,$fn=32);
    }

    // Motor Cutout
    translate([corner_thick,-1,motor_bracket_thick]) cube([motor_w,motor_w+1,motor_h+1]);
    // Angle
    translate([-huge/2,0,motor_bracket_thick]) rotate([45,0,0]) cube([huge,huge,huge]);

    // T-slot bolt holes
    // front
    translate([-tslot_bolthead_r-2,motor_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2])rotate([90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=8,a=360/16); 
    translate([motor_w+corner_thick*2+tslot_bolthead_r+2,motor_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2])rotate([90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=8,a=360/16); 
    // back
    translate([motor_w/2+corner_thick,motor_w+corner_thick*2+tslot_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2]) rotate([-90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,bolt_len=10); 
    // top
    translate([motor_w/2+corner_thick-motor_bolt_sep/2,motor_w+corner_thick+tslot_w/2,motor_h+motor_bracket_thick-corner_thick*2-tslot_w]) rotate([180,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=4,a=360/8);
    translate([motor_w/2+corner_thick+motor_bolt_sep/2,motor_w+corner_thick+tslot_w/2,motor_h+motor_bracket_thick-corner_thick*2-tslot_w]) rotate([180,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=4,a=360/8);

    // motor shaft and bolt holes
    translate([corner_thick + motor_w/2,motor_w/2,-1])
    {
      polyhole(r=motor_flange_r,h=huge);
      for(x=[-motor_bolt_sep/2,motor_bolt_sep/2])
      for(y=[-motor_bolt_sep/2,motor_bolt_sep/2])
      {
        translate([x,y,0]) polyhole(r=misc_bolt_r,h=huge);
      }
    }

    // ORB cuts
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);
    translate([-huge/2,-huge/2,motor_bracket_thick+motor_h-corner_thick]) cube([huge,huge,huge]);

    translate([-huge/2,motor_w+corner_thick,motor_h+motor_bracket_thick-tslot_w-corner_thick]) cube([huge,tslot_w,tslot_w]);
  }
}
