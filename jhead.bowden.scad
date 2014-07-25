include <common.scad>

jhead_top_h = 4.8;
jhead_top_d = 16;
jhead_top_r = jhead_top_d/2;
jhead_groove_d = 12.2;
jhead_groove_r = jhead_groove_d/2;
jhead_groove_h = 4.5;

ptc_thread_d = 4.6;
ptc_thread_r = ptc_thread_d/2;
ptc_thread_l = 3;

fan_bolt_sep = 32;
fan_bolt_off = fan_bolt_sep - (jhead_top_d+corner_thick*2);

groove_bolt_d = 3;
groove_bolt_r = groove_bolt_d/2;

xconn();
translate([corner_thick+misc_nut_r,x_mount_sep_x/2+corner_thick,corner_thick-0.01]) rotate([0,90,0]) translate([-jhead_top_d-corner_thick*2,-jhead_top_r-corner_thick,0]) jhead();

module xconn()
{
  difference()
  {
    cube([x_rod_sep + corner_thick*2,x_mount_sep_x+corner_thick*2,corner_thick]);

    translate([x_rod_sep/2+corner_thick,x_mount_sep_x/2+corner_thick,0])
    {
      for(x=[x_rod_sep/2,-x_rod_sep/2])
      for(y=[x_mount_sep_x/2,-x_mount_sep_x/2])
        translate([x,y,corner_thick]) bolt(bolt_r=misc_bolt_r,bolthead_r=misc_bolthead_r);
    }
  }
}



module jhead()
{

  difference()
  {
    union()
    {
      cube([jhead_top_d+corner_thick*2,jhead_top_d+corner_thick*2,jhead_top_h+jhead_groove_h+ptc_thread_l]);
      //translate([0,jhead_top_r+corner_thick,jhead_groove_h+jhead_top_h/2]) scale([20,20,(jhead_top_h+ptc_thread_l)/2]) sphere(r=1, $fn=32);
      translate([-corner_thick,-fan_bolt_off-misc_bolt_r,jhead_groove_h]) rotate([0,0,45]) cube([jhead_top_d,jhead_top_d,jhead_top_h+ptc_thread_l]);
      translate([-corner_thick,jhead_top_d+corner_thick*2+fan_bolt_off+misc_bolt_r,jhead_groove_h]) rotate([0,0,-45-90]) cube([jhead_top_d,jhead_top_d,jhead_top_h+ptc_thread_l]);
    }

    translate([-huge-corner_thick,-huge/2,-1]) cube([huge,huge,huge]);

    translate([jhead_top_r+corner_thick,jhead_top_r+corner_thick,-1])
    {
      // Jhead
      polyhole(r=jhead_top_r,h=jhead_top_h+jhead_groove_h+1,v=8,a=360/16);
      // PTC
      polyhole(r=ptc_thread_r,h=huge);
      // Jhead groove
      for(x=[jhead_groove_r+groove_bolt_r,-jhead_groove_r-groove_bolt_r])
        translate([x,huge/2,1+jhead_groove_h-groove_bolt_r]) rotate([90,0,0]) polyhole(r=groove_bolt_r,h=huge);
      // Fan
  #    for(y=[fan_bolt_sep/2,-fan_bolt_sep/2])
        translate([-huge/2,y,1+jhead_groove_h+(jhead_top_h+ptc_thread_l)/2]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge);
    }

    // Fan 'duct'
    translate([-5,jhead_top_r+corner_thick,jhead_groove_h+jhead_top_r/2+4-20]) sphere(r=16);
  }
}
