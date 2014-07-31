// 'Front' Corners with mounts for bearings.  
// Print 1 of bearing_corner(true) and 1 of mirror([1,0,0]) bearing_corner(false);
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <corner.scad>
use <bearing_mount.scad>

translate([-corner_thick*2 -5 ,0,0])
mirror([1,0,0]) bearing_corner(false);
bearing_corner();


module bearing_corner(left=true)
{
  difference()
  {
    union()
    {
      display_corner();

      translate([0,calc_corner_above_x-y_above_x-corner_thick,calc_corner_from_y_rod+corner_thick]) rotate([-90,0,0]) rotate([0,90,0]) y_holder();

      if(left)
      {
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) translate([-y_bearing_sep_y,0,0]) display_bearing_mount(v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) support();
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) translate([y_bearing_sep_y,0,0]) rotate([0,asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) support(l=bearing_mount_base+bearing_mount_extra+calc_retainer_b_off,extra=bearing_mount_base,extra_l=bearing_mount_support_tweak);
      }
      else
      {
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,0,0]) display_bearing_mount(v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) support(l=bearing_mount_base+bearing_mount_extra+calc_retainer_b_off,extra=bearing_mount_base);
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) translate([y_bearing_sep_y,0,0]) rotate([0,asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) support();
      }
    }

    // Clear bearing holes
    translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,1,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) translate([-y_bearing_sep_y,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
    translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,1,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));

  }
  
}


