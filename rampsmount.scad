include <common.scad>

//brace(true);
//translate([0,tslot_w+corner_thick*3,0]) brace();

difference()
{
  union()
  {
    translate([-10,0,0]) cube([60,40,corner_thick]);
    translate([20,0,0])
    for(x=[-59/2-corner_thick,59/2])
    {
      translate([x,0,0]) cube([corner_thick,40,50]);
    }
  }

  translate([20,0,0])
  {
    for(x=[-59/2+1,59/2-1])
    {
      translate([x,0,46]) rotate([-90,0,0]) polyhole(r=2,h=40); //([1,40,2]);
    }
    for(x=[32/2,-32/2])
    for(y=[32/2,-32/2])
    {
      translate([x,y+20,-1]) polyhole(r=misc_bolt_r,h=huge);
    }
    translate([0,20,-1]) polyhole(r=36/2,h=huge,v=16);

    for(x=[50/2,-50/2])
    for(y=[32/2,-32/2])
    {
      translate([x,y+20,-1]) polyhole(r=misc_bolt_r,h=huge);
      translate([-huge/2,y+20,corner_thick+5]) rotate([0,90,0]) polyhole(r=misc_bolt_r, h=huge);
    }

  }

}

module brace(which=false)
{
  bolt_sep_z=which?96.52-90.17:13.97-15.24;
  bolt_sep_x=50.8-2.54;
  difference()
  {
    linear_extrude(height=tslot_w) 2dbracket();

    #translate([arduino_width+corner_thick+tslot_w/2,-1,tslot_w/2]) rotate([-90,0,0]) polyhole(r=tslot_bolt_r,h=huge);
    translate([arduino_width/2,-1,tslot_w/2])
    {
      translate([bolt_sep_x/2,0,bolt_sep_z/2]) rotate([-90,0,0]) polyhole(r=misc_bolt_r,h=huge);
      translate([-bolt_sep_x/2,0,-bolt_sep_z/2]) rotate([-90,0,0]) polyhole(r=misc_bolt_r,h=huge);
    }
  }
}
module 2dbracket()
{
  difference()
  {
    tri();
    translate([corner_thick*4,corner_thick]) 
    //scale([(arduino_width-corner_thick*2)/arduino_width,tslot_w/(tslot_w+corner_thick*2)]) 
      scale([tslot_w/(tslot_w+corner_thick*2),tslot_w/(tslot_w+corner_thick*2)])
      tri();
  }

  translate([arduino_width,0]) difference()
  {
    square([tslot_w+corner_thick,tslot_w+corner_thick*2]);
    translate([corner_thick,corner_thick]) square([tslot_w,tslot_w]);
  }
}


module tri()
{
  difference()
  {
    square([arduino_width,tslot_w+corner_thick*2]);
    translate([0,corner_thick]) rotate(atan((tslot_w+corner_thick*2)/arduino_width)) square([huge,huge]);
  }
}
