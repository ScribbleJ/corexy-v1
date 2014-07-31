include <common.scad>

module x_carriage()
{
  x_len = x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r*2.5;
  difference()
  {
    // Shape
    linear_extrude(height=x_carriage_l)
    {
      circle(r=bushing_r+bushing_material_thick);
      //translate([0,x_len]) circle(r=bushing_r+bushing_material_thick);
      translate([-(bushing_r+bushing_material_thick), 0]) square([2*(bushing_r+bushing_material_thick),x_len]);
    }

    // Bushing/Rod Channels
    for(x=[0,x_rod_sep])
      translate([0,x,-1]) polyhole(r=bushing_r,h=x_carriage_l+2,v=8);

    // Belt Passthrough
    translate([-huge/2,x_rod_sep + belt_above_x,belt_clamp_w]) cube([huge,belt_w*2+belt_sep,x_carriage_l-belt_clamp_w*2]);

    // Holes for belt tensioner
    for(y=[x_rod_sep+belt_above_x+belt_w/2,x_rod_sep+belt_above_x+belt_w+belt_sep+belt_w/2])
    {
      translate([0,y,-1]) polyhole(r=misc_bolt_r,h=belt_clamp_w+2);
      translate([0,y,belt_clamp_w - 2]) polyhole(r=misc_nut_r,h=belt_clamp_w+2,v=6);
    }

    // Holes for belt clamp bolts
    for(y=[x_rod_sep + belt_above_x - misc_nut_r,x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r])
    for(z=[belt_clamp_w/2,x_carriage_l-belt_clamp_w/2])
      translate([-huge/2,y,z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);

    // Hole for bushing cap
    //translate([0,x_rod_sep/2,-1]) polyhole(r=smallhole(misc_bolt_r,misc_bolt_pitch),h=huge);

    // Mounting holes for extruder
    for(y=[x_mount_offset,x_rod_sep - x_mount_offset])
    for(z=[x_mount_sep_x/2,-x_mount_sep_x/2])
      translate([-huge/2,y,x_carriage_l/2+z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);
  }
}

