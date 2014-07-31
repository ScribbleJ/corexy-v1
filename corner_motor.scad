// 'Back' Corners with space to mount motors.
// Print 1 of motor_corner() and 1 of mirror([1,0,0]) motor_corner();
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <corner.scad>

translate([-5,0,0]) 
rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();
mirror([1,0,0]) rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();

module motor_corner(ehole=motor_corner_extra_hole_pos)
{
  translate([0,calc_corner_from_y_rod,calc_corner_above_x-y_above_x]) rotate([180,0,0]) rotate([0,90,0]) y_holder();
  difference()
  {
    display_corner();

    // Gaps for motor mounts
    rotate([0,0,0]) translate([-corner_thick-1,calc_corner_from_y_rod-calc_motor_from_y_rod-motor_w/2-1,-1]) 
    difference()
    {
      cube([tslot_w+corner_thick+1,motor_w+2,tslot_w+corner_thick+1]);
      translate([-huge/2,motor_bracket_wide+2,-huge/2]) cube([huge,-2+motor_w-motor_bracket_wide*2,huge]);
    }

    // Extra hole
    translate([0,ehole,tslot_w/2+corner_thick]) rotate([0,90,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);

    translate([tslot_w/2,ehole,tslot_w/2+corner_thick]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);

  }
}

