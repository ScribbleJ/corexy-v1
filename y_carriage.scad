include <common.scad>
use <bearing_mount.scad>

module print_y_carriages()
{

translate([bushing_r*2 + bushing_material_thick*2 + 5,0,0]) y_carriage();
mirror([1,0,0]) y_carriage(true);

}

module y_carriage(left = false)
{
  part_width = bushing_r*2+bushing_material_thick*2;

  // Bearing Mount
  if(left)
  {
    translate([y_bearing_offset + y_bearing_sep_y, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,180,0]) display_bearing_mount(v=6);
  }
  else
  {
    translate([y_bearing_offset, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) display_bearing_mount(v=6);
  }

  difference()
  {
    union()
    {
      // X-rod holders
      linear_extrude(height = part_width/2 + x_rod_past_bearing + corner_thick)
      {
        translate([-part_width/2,0]) square([part_width, x_rod_sep + belt_above_x - belt_above_bearing_mount + bearing_mount_base]);
        circle(r=part_width/2);
      }

      // Y-rod passthrough
      translate([0,x_rod_sep+y_above_x,0]) 
      rotate([0,90,0])
//      linear_extrude(height = y_bearing_sep_y + y_bearing_offset)
      linear_extrude(height = y_carriage_len-part_width/2)
      {
        translate([-part_width/2,0]) circle(r=part_width/2);
        //translate([-part_width,0]) circle(r=misc_nut_r);
        translate([-part_width/2,-part_width/2]) 
          square([part_width/2, part_width/2 + belt_above_y - belt_above_bearing_mount + bearing_mount_base]);
      }
    }

    // X-rod holes
    translate([0,0,-1]) linear_extrude(height = part_width/2 + x_rod_past_bearing + 1)
    {
      polycircle(r=rod_r,v=8); 
      translate([0,x_rod_sep]) polycircle(r=rod_r,v=8);
    }

    // Y-rod hole
    translate([-huge/2,x_rod_sep+y_above_x,part_width/2]) rotate([0,90,0]) polyhole(r=bushing_r,h=huge,v=8,a=22.5);
    //translate([-huge/2,y_above_x,part_width]) rotate([0,90,0]) polyhole(r=smallhole(misc_bolt_r,misc_bolt_pitch),h=huge,v=8,a=22.5);

    // Clear bearing mount holes
    translate([y_bearing_offset + y_bearing_sep_y, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6);
    translate([y_bearing_offset, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6);

  }
}


