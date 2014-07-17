include <vars.scad>

// Reduce radius of holes intended to hold bolts by threads.
// 0.86603 * p = nominal depth of threads.  1/3-1/2 of that is about right.
function smallhole(r,p) = r - ((p*0.86603)/3);
module polyhole(r,h,v=6,a=0)
{
  rotate([0,0,a]) cylinder( h = h, r = r  / cos( 180 / v ), $fn = v );
}
module polycircle(r,v=6,a=0)
{
  rotate([0,0,a]) circle(r = r  / cos( 180 / v ), $fn = v );
}

module bolt(bolt_r = misc_bolt_r,bolthead_r = misc_bolthead_r,bolt_len = huge,v=6,a=0)
{
  translate([0,0,-bolt_len]) polyhole(r=bolt_r,h=bolt_len+1,v=v,a=a);
  polyhole(r=bolthead_r,h=huge,v=v,a=a);
}

module ring(inner=5,outer=10,v=32)
{
  difference()
  {
    circle(r=outer);
    polycircle(r=inner,v=v);
  }
} 

module roundsquare(dim=[50,50],r=5)
{
  translate([0,r]) square([dim[0], dim[1] - r*2]);
  translate([r,0]) square([dim[0] - r*2, dim[1]]);
  for(x=[r,dim[0]-r])
  for(y=[r,dim[1]-r])
    translate([x,y]) circle(r=r);
}

module maketabs(l=100,w=5,num=10)
{
  tablength=l/(num * 2);
  for(x=[tablength/2:tablength*2:l])
    translate([x,0]) square([tablength,w]);
}

