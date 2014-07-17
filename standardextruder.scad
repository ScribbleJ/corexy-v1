include <common.scad>

extruder_standard();

module mount()
{
  difference()
  {
    difference()
    {
      polyhole(r=25+corner_thick*2,h=huge,a=360/12);
      translate([0,0,-1]) rotate([0,0,360/12]) cylinder(r=25-corner_thick,h=huge,$fn=6);
      //ring(outer=25+corner_thick*2,inner=25-corner_thick,$fn=6);
    }

    for(a=[0:45:360])
      rotate([0,0,a]) translate([25,0,corner_thick])  bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
  }

}

module extruder_standard()
{
  difference()
  {
    union()
    {
      cube([x_rod_sep + corner_thick*2,x_mount_sep_x+corner_thick*2,corner_thick]);
      translate([x_rod_sep/2,x_mount_sep_x/2+corner_thick,25+corner_thick*2]) rotate([0,90,0]) mount();
    }

    translate([x_rod_sep/2+corner_thick,x_mount_sep_x/2+corner_thick,0])
    {
      for(x=[x_rod_sep/2,-x_rod_sep/2])
      for(y=[x_mount_sep_x/2,-x_mount_sep_x/2])
        translate([x,y,corner_thick]) bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
    }

    translate([x_rod_sep+corner_thick*2,-huge/2,-1]) cube([huge,huge,huge]);
    translate([x_rod_sep+corner_thick*2,-huge/2,corner_thick]) rotate([0,-atan((x_rod_sep/2)/50),0]) cube([huge,huge,huge]);
  }
}
