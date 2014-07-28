include <common.scad>

bolt_sep = 85;
bolt_z   = 4.75;
segments = 32;

crescent();

module mount()
{
  difference()
  {
    union()
    {
      cube([tslot_w+corner_thick*2,tslot_w+corner_thick*4,tslot_w]);
      translate([0,bolt_sep/2 + corner_thick*2+tslot_w,0])
        polyhole(r=bolt_sep/2 + corner_thick*2,h=tslot_w,v=segments);
    }
    translate([corner_thick,-1,-1]) cube([tslot_w,tslot_w+1,huge]);
    translate([-1,tslot_w/2,tslot_w/2]) rotate([0,90,0]) polyhole(r=tslot_bolt_r, h=huge,a=360/12);

    translate([0,bolt_sep/2 + corner_thick*2+tslot_w,0])
    {
      translate([0,0,-1]) polyhole(r=bolt_sep/2 + corner_thick,h=huge,v=segments);
      // Mounting holes
      rotate([0,0,45]) translate([0,0,tslot_w/2]) rotate([-90,0,0]) bolt(a=360/12);
      rotate([0,0,60]) translate([0,0,tslot_w/2]) rotate([-90,0,0]) bolt(a=360/12);

      translate([-huge,-huge/2,-1]) cube([huge,huge,huge]);
      rotate([0,0,-25]) translate([-huge/2,0,-1]) cube([huge,huge,huge]);
    }
  }

}
module crescent()
{
  difference()
  {
    polyhole(r=bolt_sep/2 + corner_thick,h=tslot_w,v=segments);
    translate([0,0,-1]) cylinder(r=bolt_sep/2 - corner_thick,h=huge,$fn=segments);

    // Remove one half
    translate([-huge,-huge/2,-1]) cube([huge,huge,huge]);
    // Trim down one end
    translate([-huge + bolt_z, -huge, -1]) cube([huge,huge,huge]);

    // Display attachment bolts
    for(z=[corner_thick,tslot_w-corner_thick])
    {
      #translate([corner_thick, bolt_sep/2,z]) rotate([0,90,0]) bolt(a=360/12);
      #translate([corner_thick+bolt_z, -bolt_sep/2,z]) rotate([0,90,0]) bolt(a=360/12);
    }

    // Mounting holes
    for(a=[15:15:180-15])
      rotate([0,0,a]) translate([0,0,tslot_w/2]) rotate([-90,0,0]) bolt(a=360/12);

  }
}
