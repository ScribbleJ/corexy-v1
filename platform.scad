// Laser cut parts for Z platform.
// Some versions of OpenSCAD have difficulty displaying these parts, until after you compile and render with CGAL.
// Cut 1 of platform_base(), 2 of platform_side, 2 of platform_center, 2 of platform_rear, 2 of platform_bottom.
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

display_platform_laser();
//display_platform_assembly();


module display_platform_assembly()
{
  translate([-platform_w/2,laser_mat_thick+laser_mat_margin+bed_box_r,bed_box_h+laser_mat_thick*2]) rotate([180,0,0]) 
  {
    // Top
    linear_extrude(height=laser_mat_thick) platform_base();
    // Side Panels
    for(x=[laser_mat_thick + laser_mat_margin*2 + misc_bolt_r*2, platform_w - (laser_mat_margin*2 + misc_bolt_r*2)])
    {
      translate([x,0,laser_mat_thick]) rotate([0,-90,0]) linear_extrude(height=laser_mat_thick) platform_side();
    }
    // Center Panels
    translate([platform_w/2,laser_mat_margin+laser_mat_thick])
      for(x=[-z_rod_sep/4,z_rod_sep/4])
        translate([x+laser_mat_thick/2,0,laser_mat_thick]) rotate([0,-90,0]) linear_extrude(height=laser_mat_thick) platform_center();
    // Rear Panels
    translate([laser_mat_thick + laser_mat_margin*2 + misc_bolt_r*2, laser_mat_thick + laser_mat_margin, laser_mat_thick]) rotate([90,0,0]) linear_extrude(height=laser_mat_thick) platform_rear();
    translate([laser_mat_thick + laser_mat_margin*2 + misc_bolt_r*2, platform_l - laser_mat_margin, laser_mat_thick]) rotate([90,0,0]) linear_extrude(height=laser_mat_thick) platform_rear();
    // bottoms
    translate([laser_mat_thick + misc_bolt_r*2,0,bed_box_h + laser_mat_thick]) linear_extrude(height=laser_mat_thick) platform_bottom();
    translate([laser_mat_thick + misc_bolt_r*2,platform_l,bed_box_h + laser_mat_thick]) mirror([0,1,0]) linear_extrude(height=laser_mat_thick) platform_bottom();
  }
}





module display_platform_laser()
{
  platform_base();
  translate([-laser_mat_thick-laser_mat_margin,0]) mirror([1,0]) platform_side();
  translate([platform_w+laser_mat_thick+laser_mat_margin,laser_mat_margin+laser_mat_thick]) platform_center();
  translate([laser_mat_margin*2 + misc_bolt_r*2 + laser_mat_thick,-bed_box_h-laser_mat_thick*2]) platform_rear();
  translate([laser_mat_margin+misc_bolt_r*2,0]) 
  translate([0,platform_l+laser_mat_thick]) platform_bottom();
}

module platform_center()
{
  translate([0,platform_l/2 - laser_mat_margin - laser_mat_thick,0])
  for(m=[0,1])
  mirror([0,m,0])
  translate([0,-platform_l/2 + laser_mat_margin + laser_mat_thick,0])
  difference()
  {
    union()
    {
      square([bed_box_h,platform_l - laser_mat_margin*2 - laser_mat_thick*2]);

      // Platform tabs
      rotate(90) maketabs(platform_l - laser_mat_margin*2-laser_mat_thick*2, laser_mat_thick, 12);

      // Bottom tabs
      translate([laser_mat_thick + bed_box_h,0]) rotate(90) maketabs(bed_box_r*2,laser_mat_thick, 2);

      // Rear Tabs
      translate([laser_mat_margin,-laser_mat_thick]) maketabs(bed_box_h - laser_mat_margin*2,laser_mat_thick, 2);
    }

    // Angle Cut
    translate([bed_box_h, bed_box_r*2]) 
      rotate(atan((bed_box_h-laser_mat_margin)/(platform_l - (laser_mat_thick*2+laser_mat_margin*2+bed_box_r*2)))) square([huge,huge]);
  }


}

module platform_bottom()
{
  difference()
  {
    roundsquare([platform_w - (laser_mat_margin+misc_bolt_r*2)*2,laser_mat_margin+laser_mat_thick+bed_box_r*2],laser_mat_margin);

    // Bushings and Leadscrew
    translate([(platform_w - (laser_mat_margin+misc_bolt_r*2)*2)/2,laser_mat_margin+laser_mat_thick+bed_box_r]) 
    {
      circle(r=leadscrew_bolt_offset + misc_nut_r*2);

//      for(x=[-z_rod_sep/2,z_rod_sep/2])
//        translate([x,0]) polycircle(r=bushing_r-laser_bushing_fudge,v=32);
      for(x=[-z_rod_sep/2,z_rod_sep/2])
        translate([x,0]) 
        {
          polycircle(r=lm8uu_r - (lm8uu_r-rod_r)/2,v=32);
          for(a=[0:120:240])
            rotate(a) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) polycircle(r=lm8uu_bolt_r);
        }

    }

    // Rear Panel
    translate([laser_mat_margin+laser_mat_thick,laser_mat_margin])
      maketabs(platform_w - 2*(laser_mat_margin*2+misc_bolt_r*2+laser_mat_thick),laser_mat_thick, 10);

    // Side Panel 
    for(x=[laser_mat_margin, platform_w - (laser_mat_margin*2+misc_bolt_r*2)*2])
      translate([laser_mat_thick+x,0]) rotate(90) maketabs(laser_mat_margin+laser_mat_thick+bed_box_r*2,laser_mat_thick, 2);

    // center panels
    translate([platform_w/2 - (misc_bolt_r*2+laser_mat_thick),laser_mat_margin+laser_mat_thick])
      for(x=[-z_rod_sep/4,z_rod_sep/4])
        translate([x+laser_mat_thick/2,0]) rotate(90) maketabs(bed_box_r*2,laser_mat_thick, 2);
  }
}


module platform_rear()
{
  difference()
  {
    union()
    {
      square([platform_w - laser_mat_margin*4 - misc_bolt_r*4 - laser_mat_thick*2,bed_box_h]);
      // Side tabs
      for(x = [0,platform_w - laser_mat_margin*4 - misc_bolt_r*4 - laser_mat_thick*2 + laser_mat_thick])
      {
        translate([x,0])
        translate([0,laser_mat_margin]) rotate(90) maketabs(bed_box_h - laser_mat_margin*2,laser_mat_thick,2);
      }
      // Top/bottom tabs
      for(y=[-laser_mat_thick,bed_box_h])
      {
        translate([0,y])
          maketabs(platform_w - 2*(laser_mat_margin*2+misc_bolt_r*2+laser_mat_thick),laser_mat_thick, 10);

      }
    }
    // center panels
    translate([platform_w/2 - (laser_mat_margin*2+misc_bolt_r*2+laser_mat_thick),laser_mat_margin])
      for(x=[-z_rod_sep/4,z_rod_sep/4])
        translate([x+laser_mat_thick/2,0]) rotate(90) maketabs(bed_box_h - laser_mat_margin*2,laser_mat_thick, 2);


  }
}

module platform_side()
{
  for(m=[1,0])
  translate([0,platform_l/2,0])
  mirror([0,m,0])
  translate([0,-platform_l/2,0])
  difference()
  {
    union()
    {
      square([bed_box_h,platform_l]);
      rotate(90) maketabs(platform_l, laser_mat_thick, 10);      
      translate([bed_box_h+laser_mat_thick,0]) rotate(90) maketabs(laser_mat_margin+laser_mat_thick+bed_box_r*2,laser_mat_thick, 2);
    }

    // Rear Panel Tabs
    translate([laser_mat_margin,laser_mat_margin]) maketabs(bed_box_h - laser_mat_margin*2,laser_mat_thick,2);

    // Angle Cut
    translate([bed_box_h, laser_mat_thick+laser_mat_margin+bed_box_r*2]) 
      rotate(atan((bed_box_h-laser_mat_margin)/(platform_l - (laser_mat_thick+laser_mat_margin+bed_box_r*2)))) square([huge,huge]);
  }
}

module platform_base()
{
  difference()
  {
    roundsquare([platform_w,platform_l],laser_mat_margin);

    // Bushings and leadscrew
    for(y=[0,1])
    translate([platform_w/2,laser_mat_margin+laser_mat_thick+bed_box_r + (y*z_ends_sep)])
    {
      for(x=[-z_rod_sep/2,z_rod_sep/2])
        translate([x,0]) 
        {
          polycircle(r=lm8uu_r - (lm8uu_r-rod_r)/2,v=32);
          for(a=[0:120:240])
            rotate(a+(180*y)) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) polycircle(r=lm8uu_bolt_r);
        }


      polycircle(r=z_leadscrew_passthrough_r,v=32);

      for(a=[0:120:240])
        rotate(a+(180*y)) translate([0,leadscrew_bolt_offset]) polycircle(r=leadscrew_bolt_r);
    }

    // center panels
    translate([platform_w/2,laser_mat_margin+laser_mat_thick])
      for(x=[-z_rod_sep/4,z_rod_sep/4])
        translate([x+laser_mat_thick/2,0]) rotate(90) maketabs(platform_l - laser_mat_margin*2-laser_mat_thick*2, laser_mat_thick, 12);

    // Bed Bolts
    translate([platform_w/2,laser_mat_margin+laser_mat_thick+bed_box_r+bed_from_z+bed_mount_sep/2])
    for(x=[-bed_mount_sep/2,bed_mount_sep/2])
    for(y=[-bed_mount_sep/2,bed_mount_sep/2])
      translate([x,y]) polycircle(r=misc_bolt_r);

    // Alternate Bed Bolts
    translate([platform_w/2,platform_l/2])
    for(x=[-bed_mount_sep/2,bed_mount_sep/2])
    for(y=[-bed_mount_sep/2,bed_mount_sep/2])
      translate([x,y]) polycircle(r=misc_bolt_r);


    // Rear Panel
    for(y=[laser_mat_margin,platform_l-laser_mat_margin-laser_mat_thick])
    translate([laser_mat_margin*2+misc_bolt_r*2+laser_mat_thick,y])
      maketabs(platform_w - 2*(laser_mat_margin*2+misc_bolt_r*2+laser_mat_thick),laser_mat_thick, 10);

    // Side Panels
      translate([laser_mat_thick + laser_mat_margin*2 + misc_bolt_r*2,0]) rotate(90) maketabs(platform_l, laser_mat_thick, 10);
      translate([platform_w - laser_mat_margin*2 - misc_bolt_r*2,0]) rotate(90) maketabs(platform_l, laser_mat_thick, 10);


  }
}
