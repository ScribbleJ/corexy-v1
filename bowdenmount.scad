include <common.scad>
mount_dist = 30;
total_dist = 50;

brace();

module brace()
{
  difference()
  {
    linear_extrude(height=tslot_w) 2dbracket();

    translate([total_dist+corner_thick+tslot_w/2,-1,tslot_w/2]) rotate([-90,0,0]) polyhole(r=tslot_bolt_r,h=huge);


    #translate([total_dist - mount_dist,corner_thick,tslot_w/2])
      translate([bolt_sep_x/2,0,bolt_sep_z/2]) rotate([-90,0,0]) bolt();
  }
}

module 2dbracket()
{
  difference()
  {
    tri();

    translate([corner_thick*3,corner_thick]) 
    scale([tslot_w/(tslot_w+corner_thick*2),tslot_w/(tslot_w+corner_thick*2)])
      tri();
  }

  translate([total_dist,0]) difference()
  {
    square([tslot_w+corner_thick,tslot_w+corner_thick*2]);
    translate([corner_thick,corner_thick]) square([tslot_w,tslot_w]);
  }
}


module tri()
{
  difference()
  {
    square([total_dist,tslot_w+corner_thick*2]);
    translate([0,corner_thick]) rotate(atan((tslot_w+corner_thick*2)/total_dist)) square([huge,huge]);
  }
}
