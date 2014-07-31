include <common.scad>

module bearing_mount_cap(x_sep=y_bearing_sep_y,z_sep=y_bearing_sep_z,base_height=bearing_mount_base,extra_height=bearing_mount_extra,v=32,a=0)
{
  difference()
  {
    union()
    {
      rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick,h=calc_retainer_b_off+base_height+extra_height,$fn=v);
      translate([x_sep,0,0]) rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick, h=calc_retainer_b_off+z_sep+base_height+extra_height,$fn=v);
      translate([0,-(bearing_bolt_r+bearing_bolt_holder_thick),0]) cube([x_sep,(bearing_bolt_r+bearing_bolt_holder_thick)*2,base_height]);
    }

    translate([0,0,-1])
    {
      polyhole(r=bearing_bolt_r,h=calc_retainer_b_off+base_height+extra_height+2,v=v,a=a);
      translate([x_sep,0,0]) polyhole(r=bearing_bolt_r, h=calc_retainer_b_off+z_sep+base_height+extra_height+2,v=v,a=a);
    }


  }
}


