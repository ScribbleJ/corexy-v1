include <common.scad>

module display_retainer()
{
  $fn = 64;
  retainer();
  translate([0,0,retainer_lip_thick + belt_w + retainer_lip_thick]) rotate([180,0,0]) retainer(false);
  %color("grey") translate([0,0,calc_retainer_b_off]) linear_extrude(height=bearing_w)
    ring(bearing_hole_r,bearing_r);
}


module retainer(inner=true)
{
  $fn = 64;
  difference()
  {
    union()
    {
      linear_extrude(height=retainer_lip_thick) ring(bearing_r - retainer_inner_width, bearing_r + retainer_shell_thick*2 + retainer_shell_sep+belt_thick);
      if(inner)
      {
        linear_extrude(height=calc_retainer_b_off + bearing_w) ring(bearing_r, bearing_r+retainer_shell_thick);
      }
      else
      {
        linear_extrude(height=retainer_lip_thick + belt_w) ring(bearing_r+retainer_shell_thick+retainer_shell_sep, bearing_r+retainer_shell_thick*2 + retainer_shell_sep);
      }
    }
    if(inner)
      translate([0,0,calc_retainer_b_off]) cylinder(r=bearing_r,h=bearing_w);
    else
      translate([0,0,calc_retainer_b_off]) cylinder(r=bearing_r+retainer_shell_thick+retainer_shell_sep,h=bearing_w);
  }
}


