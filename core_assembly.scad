include <common.scad>
use <z_parts.scad>
use <standardextruder.scad>
use <corner.scad>
use <bearing_mount.scad>
use <bearing_retainer.scad>
use <x_carriage.scad>
use <y_carriage.scad>
use <corner_motor.scad>
use <corner_bearing.scad>
use <motor_bracket.scad>

display_assembly();

//retainer();
//translate([35,0,0]) retainer(false);
//y_carriage();
//translate([-45,0,0]) mirror([1,0,0]) y_carriage(true);
//mirror([1,0,0]) bearing_corner(false);
//bearing_corner();
//translate([0,35,0]) display_bearing_mount(v=6);
//x_carriage();
//rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();
//mirror([1,0,0]) rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();
//bearing_mount_cap();
//motor_bracket(true);
//translate([-45,0,0]) mirror([1,0,0]) motor_bracket(true);
//belt_clamp();
//z_end(false);
//corner();

//lm8uu_retainer();


module display_assembly()
{

  // Z assembly
  translate([-tslot_w-motor_w/2-corner_thick,printer_w/2,-printer_h+corner_thick]) rotate([0,0,-90]) display_z_assembly();
  // X Carriage
  translate([-printer_l/2,printer_w/2+x_carriage_l/2,-x_rod_sep]) rotate([90,0,0]) x_carriage();

  // Bottom Corners
  translate([0,0,-printer_h])
  {
    rotate([0,0,90]) display_corner();
    translate([-printer_l,0,0]) display_corner();
    translate([-printer_l,printer_w,0]) rotate([0,0,-90])display_corner();
    translate([0,printer_w,0]) rotate([0,0,180]) display_corner();
  }

  // Reference Smooth Rods
  // X rods
  %translate([-printer_l/2,printer_w-tslot_w-2-corner_thick,0]) rotate([90,0,0]) cylinder(r=rod_r,h=printer_w-(tslot_w+2+corner_thick)*2);
  %translate([-printer_l/2,printer_w-tslot_w-2-corner_thick,-x_rod_sep]) rotate([90,0,0]) cylinder(r=rod_r,h=printer_w-(tslot_w+2+corner_thick)*2);
  // Y rods
  %translate([-printer_l,calc_corner_from_y_rod,y_above_x]) rotate([0,90,0]) cylinder(r=rod_r,h=printer_l);
  %translate([-printer_l,printer_w-calc_corner_from_y_rod,y_above_x]) rotate([0,90,0]) cylinder(r=rod_r,h=printer_l);

  for(i=[0:1])
  {
    mirror([0,i,0])
    {
      translate([0,(-i*printer_w)+calc_corner_from_y_rod,0])
      {
        // Y Carriages
        translate([-printer_l/2,bushing_r+bushing_material_thick,-x_rod_sep]) rotate([90,0,0]) y_carriage(i);
        // Motor Corner
        translate([0,-calc_corner_from_y_rod,calc_corner_above_x]) rotate([0,180,0]) motor_corner();
        // Bearing Corner
        translate([-printer_l,-calc_corner_from_y_rod-corner_thick,calc_corner_above_x-corner_thick]) rotate([-90,0,0]) bearing_corner(i?0:1);

        // Reference Motor
        %translate([corner_thick + motor_w/2 + motor_bracket_thick,
                    bushing_r + bushing_material_thick - bearing_bolt_holder_thick - bearing_bolt_r - calc_retainer_or - motor_pulley_r,
                    belt_above_x - motor_pulley_h + belt_w + belt_sep - (i * (belt_w + belt_sep))]) motor(); 

        // Motor Brackets
        translate([0,-calc_motor_from_y_rod + motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) motor_bracket(i);
        translate([0,-calc_motor_from_y_rod - motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) mirror([0,0,1]) motor_bracket(i);

      }
    }
  }
}

module motor()
{
  translate([-motor_w/2,-motor_w/2,-motor_w]) cube([motor_w,motor_w,motor_w]);
  cylinder(r=motor_flange_r,h=5);
  translate([0,0,motor_pulley_h]) cylinder(r=motor_pulley_r,h=belt_w);
  for(x=[motor_bolt_sep/2,-motor_bolt_sep/2])
  for(y=[motor_bolt_sep/2,-motor_bolt_sep/2])
    translate([x,y,0]) cylinder(r=motor_bolt_r,h=20);
}


