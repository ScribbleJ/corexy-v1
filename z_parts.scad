// Assembly of Z axis.
//See used files files for printing instructions.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>
use <lm8uu_z_holder.scad>
use <liftnut_z_holder.scad>
use <z_rod_holder.scad>
use <z_motor_mount.scad>
use <z_end.scad>
use <platform.scad>

display_z_assembly();

//lm8uu_retainer();
//z_rod_holder();
//z_motor_mount();
//z_end();

module display_z_bottom()
{
  z_rod_holder();
  translate([z_rod_sep,0,0]) z_rod_holder();
  rotate([-90,0,0]) translate([-motor_w/2-corner_thick+z_rod_sep/2,-motor_w-corner_thick,-motor_h+corner_thick+tslot_w/2]) z_motor_mount();
}



module display_z_assembly()
{
  for(m=[0,1])
  {
    mirror([0,m,0])
    translate([0,m*(platform_l-laser_mat_thick*2-laser_mat_margin*2-bed_box_r*2),0])
    {
      // Z top
      translate([-z_rod_sep/2,motor_w/2 + corner_thick,printer_h-tslot_w]) rotate([90,0,0]) z_end();
      // Z bottom
      rotate([0,0,180]) translate([-z_rod_sep/2,-(motor_w/2+corner_thick),tslot_w]) rotate([-90,0,0]) display_z_bottom();

      // Display rods
      for(x=[z_rod_sep/2,-z_rod_sep/2])
        translate([x,0,0]) %cylinder(r=rod_r,h=printer_h);
    }
  }

  // Platform
  translate([0,0,printer_h/2]) display_platform_assembly();
}
  




