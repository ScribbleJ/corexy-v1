// Common functions used in various places throughout.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <vars.scad>

// Reduce radius of holes intended to hold bolts by threads.
// 0.86603 * p = nominal depth of threads.  1/3-1/2 of that is about right.
function smallhole(r,p) = r - ((p*0.86603)/3);

// Polyhole derived from Nophead's Polyhole work: http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(r,h,v=6,a=0)
{
  rotate([0,0,a]) cylinder( h = h, r = r  / cos( 180 / v ), $fn = v );
}
// 2D version of Polyhole
module polycircle(r,v=6,a=0)
{
  rotate([0,0,a]) circle(r = r  / cos( 180 / v ), $fn = v );
}
// Cutout for bolthole
module bolt(bolt_r = misc_bolt_r,bolthead_r = misc_bolthead_r,bolt_len = huge,v=6,a=0)
{
  translate([0,0,-bolt_len]) polyhole(r=bolt_r,h=bolt_len+1,v=v,a=a);
  polyhole(r=bolthead_r,h=huge,v=v,a=a);
}
// 2D ring
module ring(inner=5,outer=10,v=32)
{
  difference()
  {
    circle(r=outer);
    polycircle(r=inner,v=v);
  }
} 
// 2D Rounded square
module roundsquare(dim=[50,50],r=5)
{
  translate([0,r]) square([dim[0], dim[1] - r*2]);
  translate([r,0]) square([dim[0] - r*2, dim[1]]);
  for(x=[r,dim[0]-r])
  for(y=[r,dim[1]-r])
    translate([x,y]) circle(r=r);
}
// Lasercutting Tabs
module maketabs(l=100,w=5,num=10)
{
  tablength=l/(num * 2);
  for(x=[tablength/2:tablength*2:l])
    translate([x,0]) square([tablength,w]);
}
// Support for printing bearing mount
module support(l=bearing_mount_base+bearing_mount_extra+y_bearing_sep_z+calc_retainer_b_off,w=bearing_hole_d * tan(180/6) *2,extra=0,extra_l=0)
{
  translate([-w/2,0,-l]) 
  {
    difference()
    {
      rotate([45,0,0]) cube([w,huge/2,huge/2]);
      translate([-huge/2,0,0]) cube([huge,huge,huge]);
      translate([-huge/2,-huge/2,l]) cube([huge,huge,huge]);
    }
    translate([0,-extra,-extra_l/2]) cube([w,extra,extra_l]);
  }

}

