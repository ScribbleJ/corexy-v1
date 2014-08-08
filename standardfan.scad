// 'Standardextruder' addon for fan and probe
// Optional.  Print 1.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

fan_bolt_sep = 33;
fan_bolt_r = 23.33;
fan_holder_thick = misc_nut_r*2-0.5;
fan_holder_h = 3;

holder_from_bolt = 5;

// Illustrative fan
%translate([0,0,-10]) difference() { translate([-20,-20,0]) cube([40,40,10]); translate([0,0,-1]) cylinder(r=39/2,h=huge); }
fan_holder();

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
}
