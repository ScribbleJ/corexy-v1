// Bracket to attach motors at proper height on corner_motor.
// Print 1 motor_bracket(true), 1 mirror([1,0,0]) motor_bracket(true), 1 motor_bracket(false), 1 mirror([1,0,0]) motor_bracket(false)
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

motor_bracket(true);
translate([-45,0,0]) mirror([1,0,0]) motor_bracket(true);
translate([0,45,0])
{
  motor_bracket(false);
  translate([-45,0,0]) mirror([1,0,0]) motor_bracket(false);
}


module motor_bracket(motor1=false)
{
  motornum = motor1 ? calc_motor1_above_x : calc_motor2_above_x;
  motorpos = -calc_corner_above_x + motornum + corner_thick;

  difference()
  {
    union()
    {
      // T-slot 'corner'
      translate([-tslot_w+1,0,0]) cube([tslot_w+corner_thick,corner_thick,motor_bracket_wide]);
      translate([0,-tslot_w+1,0]) cube([corner_thick,tslot_w+corner_thick,motor_bracket_wide]);

      // Motor Arm
      translate([-tslot_w/2,0,0]) cube([tslot_w/2+motor_bracket_thick+motor_bracket_len+corner_thick,motor_bracket_thick+motorpos,motor_bracket_wide]);

      // Spacer
      translate([0,-tslot_w/2,0]) cube([motor_bracket_thick+corner_thick+motor_bracket_len,tslot_w/2+motor_bracket_thick,motor_bracket_wide]);
    }

    // T-slot Bolt Holes
    translate([-tslot_w/2,corner_thick,motor_bracket_wide/2]) rotate([-90,0,0]) bolt(tslot_bolt_r,tslot_bolthead_r);
    translate([corner_thick,-tslot_w/2,motor_bracket_wide/2]) rotate([0,90,0]) rotate([0,0,360/12]) bolt(tslot_bolt_r,tslot_bolthead_r);

    // Motor Bolt Holes
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset+motor_bolt_sep,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);

    // Motor cutout
    translate([motor_bracket_thick+corner_thick,-huge + motorpos,-1]) cube([huge,huge,huge]);
  }

}


