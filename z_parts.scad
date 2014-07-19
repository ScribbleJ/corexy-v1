include <common.scad>
use <platform.scad>

//  display_platform_assembly();
//  translate([z_rod_sep/2,0,laser_mat_thick]) rotate([0,0,60]) lm8uu_retainer();
//  translate([-z_rod_sep/2,0,laser_mat_thick]) rotate([0,0,60]) lm8uu_retainer();

//z_end();

module lm8uu_retainer()
{
  difference()
  {
    union()
    {
      cylinder(r=lm8uu_r + corner_thick,h=bed_box_h);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) cylinder(r=lm8uu_nut_r,h=bed_box_h);
    }
    translate([0,0,-1])
    {
      polyhole(r=lm8uu_r,h=huge,v=16);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+lm8uu_bolt_r]) polyhole(r=lm8uu_bolt_r,h=huge);
    }
  }
}

module display_z_assembly()
{
  // Z top
  translate([-z_rod_sep/2,motor_w/2 + corner_thick,printer_h-tslot_w]) rotate([90,0,0]) z_end();
  // Z bottom
  rotate([0,0,180]) translate([-z_rod_sep/2,-(motor_w/2+corner_thick),tslot_w]) rotate([-90,0,0]) z_end(true);

  // Display rods
  for(x=[z_rod_sep/2,-z_rod_sep/2])
    translate([x,0,0]) %cylinder(r=rod_r,h=printer_h);

  // Platform
  translate([0,0,printer_h/2]) display_platform_assembly();
}
  

module z_rod_holder()
{
  rod_holder_r = motor_w/2 + bushing_material_thick + corner_thick + rod_r;

  difference()
  {
    translate([0,-corner_thick,0]) scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);

    // Garbage
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);

    // Rod Hole
    translate([0,tslot_w,corner_thick + motor_w/2])
      rotate([90,0,0])
        polyhole(r=rod_r,h=huge,v=8,a=360/16);

    // Tslot bolts
    for(x=[rod_holder_r/2 - tslot_bolthead_r,-rod_holder_r/2 + tslot_bolthead_r])
    {
      translate([x,tslot_w/2,corner_thick]) bolt(tslot_bolt_r,tslot_bolthead_r);
    }

  }

}


module z_motor_mount()
{

  difference()
  {
    union()
    {
      // Basic Bracket
      cube([motor_w + corner_thick*2, motor_w+corner_thick, motor_h+motor_bracket_thick]);
      // ORB
      translate([motor_w/2+corner_thick,motor_w+corner_thick,motor_h+motor_bracket_thick-tslot_w/2-corner_thick]) scale([motor_w+corner_thick*2+tslot_bolthead_r*4+4,(tslot_w+corner_thick)*2,(motor_h+motor_bracket_thick)*2]) sphere(r=.5,$fn=32);
    }

    // Motor Cutout
    translate([corner_thick,-1,motor_bracket_thick]) cube([motor_w,motor_w+1,motor_h+1]);
    // Angle
    translate([-huge/2,0,motor_bracket_thick]) rotate([45,0,0]) cube([huge,huge,huge]);

    // T-slot bolt holes
    // front
    translate([-tslot_bolthead_r-2,motor_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2])rotate([90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=8,a=360/16); 
    translate([motor_w+corner_thick*2+tslot_bolthead_r+2,motor_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2])rotate([90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=8,a=360/16); 
    // back
    translate([motor_w/2+corner_thick,motor_w+corner_thick*2+tslot_w,motor_h+motor_bracket_thick-corner_thick-tslot_w/2]) rotate([-90,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,bolt_len=10); 
    // top
    translate([motor_w/2+corner_thick-motor_bolt_sep/2,motor_w+corner_thick+tslot_w/2,motor_h+motor_bracket_thick-corner_thick*2-tslot_w]) rotate([180,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=4,a=360/8);
    translate([motor_w/2+corner_thick+motor_bolt_sep/2,motor_w+corner_thick+tslot_w/2,motor_h+motor_bracket_thick-corner_thick*2-tslot_w]) rotate([180,0,0]) bolt(bolt_r=tslot_bolt_r,bolthead_r=tslot_bolthead_r,v=4,a=360/8);

    // motor shaft and bolt holes
    translate([corner_thick + motor_w/2,motor_w/2,-1])
    {
      polyhole(r=motor_flange_r,h=huge);
      for(x=[-motor_bolt_sep/2,motor_bolt_sep/2])
      for(y=[-motor_bolt_sep/2,motor_bolt_sep/2])
      {
        translate([x,y,0]) polyhole(r=misc_bolt_r,h=huge);
      }
    }

    // ORB cuts
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);
    translate([-huge/2,-huge/2,motor_bracket_thick+motor_h-corner_thick]) cube([huge,huge,huge]);

    #translate([-huge/2,motor_w+corner_thick,motor_h+motor_bracket_thick-tslot_w-corner_thick]) cube([huge,tslot_w,tslot_w]);
  }
}

module z_end(motor=false)
{
  rod_holder_r = motor_w/2 + bushing_material_thick + corner_thick + rod_r;
  difference()
  {
    union()
    {
      cube([z_rod_sep,tslot_w,corner_thick]);
      translate([0,-corner_thick,0])
      {
        scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);
        translate([z_rod_sep,0,0]) scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick*2);
      }
    }
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);

    // Rod holders
    translate([0,0,corner_thick + motor_w/2])
    {
      rotate([-90,0,0])
      {
        polyhole(r=rod_r,h=huge,v=8,a=360/16);
        translate([z_rod_sep,0,0]) polyhole(r=rod_r,h=huge,v=8,a=360/16);
      }
    }

    // Tslot bolts
    for(x=[rod_holder_r/2 - tslot_bolthead_r,z_rod_sep - rod_holder_r/2 + tslot_bolthead_r,
           -rod_holder_r/2 + tslot_bolthead_r,z_rod_sep + rod_holder_r/2 - tslot_bolthead_r
          ])
    {
      translate([x,tslot_w/2,corner_thick]) bolt(tslot_bolt_r,tslot_bolthead_r);
    }
  }

  if(motor)
  {
    difference()
    {
      translate([z_rod_sep/2 - motor_w/2 - corner_thick, -motor_h-motor_bracket_thick+tslot_w+corner_thick,0]) cube([motor_w + corner_thick*2, motor_h + motor_bracket_thick, motor_w + corner_thick]);

      translate([z_rod_sep/2 - motor_w/2, -motor_h + tslot_w + corner_thick, corner_thick]) cube([motor_w, motor_h+1, motor_w+1]);
      translate([0,tslot_w+corner_thick,corner_thick]) rotate([45,0,0]) cube([huge,huge,huge]);
      translate([z_rod_sep/2,0,corner_thick + motor_w/2])
      {
        rotate([90,0,0]) polyhole(r=motor_flange_r,h=huge);
        for(x=[-motor_bolt_sep/2,motor_bolt_sep/2])
        for(z=[-motor_bolt_sep/2,motor_bolt_sep/2])
        {
          translate([x,0,z]) rotate([90,0,0]) polyhole(r=misc_bolt_r,h=huge);
        }
      }
    }

  }
}
