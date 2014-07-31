// X-carriage mount for standard 50mm reprap extruders.
// Optional.  Print 1.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

extruder_standard();

module mount()
{
  difference()
  {
    difference()
    {
      rotate([0,0,360/12]) cylinder(r=25+corner_thick*2,h=huge,a=360/12,$fn=6);
      translate([0,0,-1]) rotate([0,0,360/12]) cylinder(r=25-corner_thick,h=huge,$fn=6);
      //ring(outer=25+corner_thick*2,inner=25-corner_thick,$fn=6);
    }

    for(a=[0:60:360])
      rotate([0,0,a]) translate([25,0,corner_thick])  rotate([0,0,360/12]) bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
    for(a=[90,-90])
      rotate([0,0,a]) translate([25,0,corner_thick])  bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
  }

}

module extruder_standard()
{
  difference()
  {
    union()
    {
      // Mounting Wall
      cube([x_rod_sep - x_mount_offset*2 + corner_thick*2,x_mount_sep_x+corner_thick*2,corner_thick]);
      // Extruder PLatform
      translate([x_rod_sep/2-x_mount_offset+corner_thick,x_mount_sep_x/2+corner_thick,25+corner_thick*2]) rotate([0,90,0]) mount();
    }

    // X-carriage bolts
    translate([x_rod_sep/2 - x_mount_offset +corner_thick,x_mount_sep_x/2+corner_thick,0])
    {
      for(x=[x_rod_sep/2 - x_mount_offset,-x_rod_sep/2 + x_mount_offset])
      for(y=[x_mount_sep_x/2,-x_mount_sep_x/2])
        translate([x,y,corner_thick]) bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
    }

    translate([x_rod_sep-x_mount_offset*2+corner_thick*2,-huge/2,-1]) cube([huge,huge,huge]);
    translate([x_rod_sep - x_mount_offset*2 + corner_thick*2,-huge/2,corner_thick]) rotate([0,-atan((x_rod_sep/2 - x_mount_offset - corner_thick)/(50)),0]) cube([huge,huge,huge]);
  }
}
