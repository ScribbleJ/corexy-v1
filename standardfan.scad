// 'Standardextruder' addon for fan and probe
// Optional.  Print 1 fan_holder and 1 probe_holder..
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

fan_bolt_sep = 33;
fan_bolt_r = 23.33;
fan_holder_thick = misc_nut_r*2-0.5;
fan_holder_h = 3;

holder_from_bolt = 5;

magnet_holder_thick = 3;
magnet_w = 5;

probe_length=5;
probe_w=20;
probe_h=5;

// Illustrative fan
%translate([0,0,-10]) difference() { translate([-20,-20,0]) cube([40,40,10]); translate([0,0,-1]) cylinder(r=39/2,h=huge); }
%fan_holder();
probe_holder();

module probe_holder()
{
  difference()
  {
    union()
    {
      polyhole(r=fan_bolt_r+fan_holder_thick/2+magnet_w+magnet_holder_thick, h=fan_holder_h,v=32);
       for(x=[fan_bolt_r+fan_holder_thick/2+magnet_w/2+0.5,-1*(fan_bolt_r+fan_holder_thick/2+magnet_w/2+0.5)])
        translate([x,magnet_w,0]) magnet_holder(3);
      // Probe holder
      translate([-probe_w/2-fan_holder_h,0,0]) cube([probe_w+fan_holder_h*2,fan_bolt_r+fan_holder_thick/2+magnet_w+magnet_holder_thick+probe_length,fan_holder_h+probe_h]);
    }
    translate([0,0,-1]) polyhole(r=fan_bolt_r+fan_holder_thick/2,h=huge,v=32);
    translate([-huge/2,magnet_w/2-huge,-1]) cube([huge,huge,huge]);
    // Probe holder
    translate([-probe_w/2,0,fan_holder_h]) cube([probe_w,huge,fan_holder_h+probe_h]);

  }
    
}

module fan_holder()
{
  // Fan part
  difference()
  {
    polyhole(r=fan_bolt_r+fan_holder_thick/2,h=fan_holder_h,v=32);
    // big center hole
    translate([0,0,-1]) polyhole(r=fan_bolt_r-fan_holder_thick/2,h=huge,v=32);
    // fan mount bolt holes
    for(a=[45:90:360]) 
      rotate([0,0,a]) translate([fan_bolt_r,0,3]) bolt(a=360/12);
    // Cut off bottom
    translate([-huge/2,-huge-20,-1]) cube([huge,huge,huge]);
  }

  // Attachment bolt
  translate([0,20,fan_holder_h])
  rotate([90,0,180]) 
  difference()
  {
    cylinder(r=misc_nut_r+5,h=fan_holder_h,$fn=32);
    translate([-huge/2,-huge-3,-1]) cube([huge,huge,huge]);
    translate([0,5,-1]) polyhole(r=misc_bolt_r,h=huge);
  }

  // Magnets
  for(x=[fan_bolt_r+fan_holder_thick/2+magnet_w/2+0.5,-1*(fan_bolt_r+fan_holder_thick/2+magnet_w/2+0.5)])
    translate([x,0,0]) magnet_holder();
}

module magnet_holder(cap=0)
{
  translate([-magnet_w/2-magnet_holder_thick,-magnet_w/2,0])
  difference()
  {
    cube([magnet_w+magnet_holder_thick*2,magnet_w+cap,magnet_w+magnet_holder_thick*2]);
    translate([magnet_holder_thick,-1,magnet_holder_thick]) cube([magnet_w,magnet_w+1.02,magnet_w]);
  }
}


