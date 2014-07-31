include <common.scad>
use <z_parts.scad>
use <standardextruder.scad>

display_assembly();

//retainer();
//translate([35,0,0]) retainer(false);
//y_carriage();
//translate([-45,0,0]) mirror([1,0,0]) y_carriage(true);
//mirror([1,0,0]) bearing_corner(false);
//bearing_corner();
//translate([0,35,0]) display_bearing_mount(v=6);
//x_carriage();
//rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();
//mirror([1,0,0]) rotate([0,-90,0]) translate([corner_thick,corner_thick,0]) motor_corner();
//bearing_mount_cap();
//motor_bracket(true);
//translate([-45,0,0]) mirror([1,0,0]) motor_bracket(true);
//belt_clamp();
//z_end(false);
//corner();

//lm8uu_retainer();

module lm8uu_retainer()
{
  difference()
  {
    union()
    {
      cylinder(r=lm8uu_r + corner_thick,h=bed_box_h);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+misc_bolt_r]) cylinder(r=misc_nut_r,h=bed_box_h);
    }
    translate([0,0,-1])
    {
      polyhole(r=lm8uu_r,h=huge,v=16);
      for(a=[0:120:240])
        rotate([0,0,a]) translate([0,lm8uu_r+corner_thick+misc_bolt_r]) polyhole(r=misc_bolt_r,h=huge);
    }
  }
}

/*
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
  

module z_end(motor=false)
{
  rod_holder_r = motor_w/2 + bushing_material_thick + corner_thick + rod_r;
  difference()
  {
    union()
    {
      cube([z_rod_sep,tslot_w,corner_thick]);
      scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick);
      translate([z_rod_sep,0,0]) scale([0.5,1,1]) rotate([-90,0,0]) cylinder(r=rod_holder_r, h=tslot_w+corner_thick);
    }
    translate([-huge/2,-huge/2,-huge]) cube([huge,huge,huge]);

    // Rod holders
    translate([0,-1,corner_thick + motor_w/2])
    {
      rotate([-90,0,0])
      {
        polyhole(r=rod_r,h=tslot_w + 1,v=8,a=360/16);
        translate([z_rod_sep,0,0]) polyhole(r=rod_r,h=tslot_w + 1,v=8,a=360/16);
      }
    }

    // Tslot bolts
    for(x=[rod_holder_r/2 - tslot_bolthead_r,z_rod_sep - rod_holder_r/2 + tslot_bolthead_r])
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

*/

module y_holder()
{
  part_width = bushing_r*2+bushing_material_thick*2;
  difference()
  {
    union()
    {
      translate([-part_width/2,0,tslot_w+2]) cube([part_width,calc_corner_from_y_rod+corner_thick,tslot_w-2]);

      cylinder(r=part_width/2, h=tslot_w*2, $fn=6);
      translate([0,0,-corner_thick]) cylinder(r=part_width/2, h=corner_thick, $fn=6);
    }
    
    translate([-huge/2,calc_corner_above_x + x_rod_sep/2 -tslot_w,-1]) cube([huge,tslot_w+1,tslot_w+1]);
    translate([calc_corner_from_y_rod - tslot_w,-huge/2,-1]) cube([tslot_w+1,huge,tslot_w+1]);
    translate([0,0,-1]) polyhole(r=rod_r,h=tslot_w*2+2,v=8,a=360/16);
  }
}

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

module motor_bracket(motor1=false)
{
  motornum = motor1 ? calc_motor1_above_x : calc_motor2_above_x;
  motorpos = -calc_corner_above_x + motornum + corner_thick;

  difference()
  {
    union()
    {
      // T-slot 'corner'
      translate([-tslot_w+1,0,0]) cube([tslot_w+corner_thick,corner_thick,motor_bracket_wide]);
      translate([0,-tslot_w+1,0]) cube([corner_thick,tslot_w+corner_thick,motor_bracket_wide]);

      // Motor Arm
      translate([-tslot_w/2,0,0]) cube([tslot_w/2+motor_bracket_thick+motor_bracket_len+corner_thick,motor_bracket_thick+motorpos,motor_bracket_wide]);

      // Spacer
      translate([0,-tslot_w/2,0]) cube([motor_bracket_thick+corner_thick+motor_bracket_len,tslot_w/2+motor_bracket_thick,motor_bracket_wide]);
    }

    // T-slot Bolt Holes
    translate([-tslot_w/2,corner_thick,motor_bracket_wide/2]) rotate([-90,0,0]) bolt(tslot_bolt_r,tslot_bolthead_r);
    translate([corner_thick,-tslot_w/2,motor_bracket_wide/2]) rotate([0,90,0]) rotate([0,0,360/12]) bolt(tslot_bolt_r,tslot_bolthead_r);

    // Motor Bolt Holes
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset+motor_bolt_sep,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);

    // Motor cutout
    translate([motor_bracket_thick+corner_thick,-huge + motorpos,-1]) cube([huge,huge,huge]);
  }

}

module bearing_corner(left=true)
{
  difference()
  {
    union()
    {
      display_corner();

      translate([0,calc_corner_above_x-y_above_x-corner_thick,calc_corner_from_y_rod+corner_thick]) rotate([-90,0,0]) rotate([0,90,0]) y_holder();

      if(left)
      {
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) translate([-y_bearing_sep_y,0,0]) display_bearing_mount(v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) support();
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) translate([y_bearing_sep_y,0,0]) rotate([0,asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) support(l=bearing_mount_base+bearing_mount_extra+calc_retainer_b_off,extra=bearing_mount_base,extra_l=bearing_mount_support_tweak);
      }
      else
      {
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,0,0]) display_bearing_mount(v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) support(l=bearing_mount_base+bearing_mount_extra+calc_retainer_b_off,extra=bearing_mount_base);
        translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r-bearing_bolt_r-bearing_bolt_holder_thick]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) translate([y_bearing_sep_y,0,0]) rotate([0,asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) support();
      }
    }

    // Clear bearing holes
    translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,1,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) translate([-y_bearing_sep_y,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));
    translate([tslot_w+bearing_bolt_r+bearing_bolt_holder_thick,1,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6,a=-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y));

  }
  
}



module motor_corner(ehole=motor_corner_extra_hole_pos)
{
  translate([0,calc_corner_from_y_rod,calc_corner_above_x-y_above_x]) rotate([180,0,0]) rotate([0,90,0]) y_holder();
  difference()
  {
    display_corner();

    // Gaps for motor mounts
    rotate([0,0,0]) translate([-corner_thick-1,calc_corner_from_y_rod-calc_motor_from_y_rod-motor_w/2-1,-1]) 
    difference()
    {
      cube([tslot_w+corner_thick+1,motor_w+2,tslot_w+corner_thick+1]);
      translate([-huge/2,motor_bracket_wide+2,-huge/2]) cube([huge,-2+motor_w-motor_bracket_wide*2,huge]);
    }

    // Extra hole
    translate([0,ehole,tslot_w/2+corner_thick]) rotate([0,90,0]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);

    translate([tslot_w/2,ehole,tslot_w/2+corner_thick]) translate([0,0,-huge/2]) polyhole(r=tslot_bolt_r,h=huge);

  }
}

module motor()
{
  translate([-motor_w/2,-motor_w/2,-motor_w]) cube([motor_w,motor_w,motor_w]);
  cylinder(r=motor_flange_r,h=5);
  translate([0,0,motor_pulley_h]) cylinder(r=motor_pulley_r,h=belt_w);
  for(x=[motor_bolt_sep/2,-motor_bolt_sep/2])
  for(y=[motor_bolt_sep/2,-motor_bolt_sep/2])
    translate([x,y,0]) cylinder(r=motor_bolt_r,h=20);
}


module display_assembly()
{

  // Z assembly
  translate([-tslot_w-motor_w/2-corner_thick,printer_w/2,-printer_h+tslot_w]) rotate([0,0,-90]) display_z_assembly();
  // X Carriage
  translate([-printer_l/2,printer_w/2+x_carriage_l/2,-x_rod_sep]) rotate([90,0,0]) x_carriage();
  //translaste([-printer_l/2,printer_w/2+x_carriage_l/2,-x_rod_sep]) 
  //translate([-printer_l/2-bushing_r-bushing_material_thick,printer_w/2+x_mount_sep_x/2+corner_thick,x_mount_offset+corner_thick]) rotate([0,90,180]) extruder_standard();

  // Bottom Corners
  translate([0,0,-printer_h-corner_thick+tslot_w])
  {
    rotate([0,0,90]) display_corner();
    translate([-printer_l,0,0]) display_corner();
    translate([-printer_l,printer_w,0]) rotate([0,0,-90])display_corner();
    translate([0,printer_w,0]) rotate([0,0,180]) display_corner();
  }

  // Reference Smooth Rods
  // X rods
  %translate([-printer_l/2,printer_w-tslot_w-2-corner_thick,0]) rotate([90,0,0]) cylinder(r=rod_r,h=printer_w-(tslot_w+2+corner_thick)*2);
  %translate([-printer_l/2,printer_w-tslot_w-2-corner_thick,-x_rod_sep]) rotate([90,0,0]) cylinder(r=rod_r,h=printer_w-(tslot_w+2+corner_thick)*2);
  // Y rods
  %translate([-printer_l,calc_corner_from_y_rod,y_above_x]) rotate([0,90,0]) cylinder(r=rod_r,h=printer_l);
  %translate([-printer_l,printer_w-calc_corner_from_y_rod,y_above_x]) rotate([0,90,0]) cylinder(r=rod_r,h=printer_l);

  for(i=[0:1])
  {
    mirror([0,i,0])
    {
      translate([0,(-i*printer_w)+calc_corner_from_y_rod,0])
      {
        // Y Carriages
        translate([-printer_l/2,bushing_r+bushing_material_thick,-x_rod_sep]) rotate([90,0,0]) y_carriage(i);
        // Motor Corner
        translate([0,-calc_corner_from_y_rod,calc_corner_above_x]) rotate([0,180,0]) motor_corner();
        // Bearing Corner
        translate([-printer_l,-calc_corner_from_y_rod-corner_thick,calc_corner_above_x-corner_thick]) rotate([-90,0,0]) bearing_corner(i?0:1);

        // Reference Motor
        %translate([corner_thick + motor_w/2 + motor_bracket_thick,
                    bushing_r + bushing_material_thick - bearing_bolt_holder_thick - bearing_bolt_r - calc_retainer_or - motor_pulley_r,
                    belt_above_x - motor_pulley_h + belt_w + belt_sep - (i * (belt_w + belt_sep))]) motor(); 

        // Motor Brackets
        translate([0,-calc_motor_from_y_rod + motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) motor_bracket(i);
        translate([0,-calc_motor_from_y_rod - motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) mirror([0,0,1]) motor_bracket(i);

      }
    }
  }
}

module print_y_carriages()
{

translate([bushing_r*2 + bushing_material_thick*2 + 5,0,0]) y_carriage();
mirror([1,0,0]) y_carriage(true);

}

module y_carriage(left = false)
{
  part_width = bushing_r*2+bushing_material_thick*2;

  // Bearing Mount
  if(left)
  {
    translate([y_bearing_offset + y_bearing_sep_y, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,180,0]) display_bearing_mount(v=6);
  }
  else
  {
    translate([y_bearing_offset, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) display_bearing_mount(v=6);
  }

  difference()
  {
    union()
    {
      // X-rod holders
      linear_extrude(height = part_width/2 + x_rod_past_bearing + corner_thick)
      {
        translate([-part_width/2,0]) square([part_width, x_rod_sep + belt_above_x - belt_above_bearing_mount + bearing_mount_base]);
        circle(r=part_width/2);
      }

      // Y-rod passthrough
      translate([0,x_rod_sep+y_above_x,0]) 
      rotate([0,90,0])
//      linear_extrude(height = y_bearing_sep_y + y_bearing_offset)
      linear_extrude(height = y_carriage_len-part_width/2)
      {
        translate([-part_width/2,0]) circle(r=part_width/2);
        //translate([-part_width,0]) circle(r=misc_nut_r);
        translate([-part_width/2,-part_width/2]) 
          square([part_width/2, part_width/2 + belt_above_y - belt_above_bearing_mount + bearing_mount_base]);
      }
    }

    // X-rod holes
    translate([0,0,-1]) linear_extrude(height = part_width/2 + x_rod_past_bearing + 1)
    {
      polycircle(r=rod_r,v=8); 
      translate([0,x_rod_sep]) polycircle(r=rod_r,v=8);
    }

    // Y-rod hole
    translate([-huge/2,x_rod_sep+y_above_x,part_width/2]) rotate([0,90,0]) polyhole(r=bushing_r,h=huge,v=8,a=22.5);
    //translate([-huge/2,y_above_x,part_width]) rotate([0,90,0]) polyhole(r=smallhole(misc_bolt_r,misc_bolt_pitch),h=huge,v=8,a=22.5);

    // Clear bearing mount holes
    translate([y_bearing_offset + y_bearing_sep_y, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6);
    translate([y_bearing_offset, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) polyhole(r=smallhole(bearing_hole_r,bearing_bolt_pitch),h=huge,v=6);

  }
}

module display_bearing_mount(x_sep=y_bearing_sep_y,z_sep=y_bearing_sep_z,base_height=bearing_mount_base,extra_height=bearing_mount_extra,v=32,a=0)
{
  translate([0,0,5+2])
  {
    %display_retainer();
    %translate([x_sep,0,z_sep]) display_retainer();
  }
  bearing_mount(x_sep,z_sep,v=v,a=a);
}

module bearing_mount(x_sep=y_bearing_sep_y,z_sep=y_bearing_sep_z,base_height=bearing_mount_base,extra_height=bearing_mount_extra,v=32,a=0)
{
  difference()
  {
    union()
    {
      rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick,h=calc_retainer_b_off+base_height+extra_height,$fn=v);
      translate([x_sep,0,0]) rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick, h=calc_retainer_b_off+z_sep+base_height+extra_height,$fn=v);
      translate([0,-(bearing_bolt_r+bearing_bolt_holder_thick),0]) cube([x_sep,(bearing_bolt_r+bearing_bolt_holder_thick)*2,base_height]);
    }

    translate([0,0,-1])
    {
      polyhole(r=smallhole(bearing_bolt_r,bearing_bolt_pitch),h=calc_retainer_b_off+base_height+extra_height+2,v=v,a=a);
      translate([x_sep,0,0]) polyhole(r=smallhole(bearing_bolt_r,bearing_bolt_pitch), h=calc_retainer_b_off+z_sep+base_height+extra_height+2,v=v,a=a);
    }


  }
}

module x_carriage()
{
  x_len = x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r*2.5;
  difference()
  {
    // Shape
    linear_extrude(height=x_carriage_l)
    {
      circle(r=bushing_r+bushing_material_thick);
      //translate([0,x_len]) circle(r=bushing_r+bushing_material_thick);
      translate([-(bushing_r+bushing_material_thick), 0]) square([2*(bushing_r+bushing_material_thick),x_len]);
    }

    // Bushing/Rod Channels
    for(x=[0,x_rod_sep])
      translate([0,x,-1]) polyhole(r=bushing_r,h=x_carriage_l+2,v=8);

    // Belt Passthrough
    translate([-huge/2,x_rod_sep + belt_above_x,belt_clamp_w]) cube([huge,belt_w*2+belt_sep,x_carriage_l-belt_clamp_w*2]);

    // Holes for belt tensioner
    for(y=[x_rod_sep+belt_above_x+belt_w/2,x_rod_sep+belt_above_x+belt_w+belt_sep+belt_w/2])
    {
      translate([0,y,-1]) polyhole(r=misc_bolt_r,h=belt_clamp_w+2);
      translate([0,y,belt_clamp_w - 2]) polyhole(r=misc_nut_r,h=belt_clamp_w+2,v=6);
    }

    // Holes for belt clamp bolts
    for(y=[x_rod_sep + belt_above_x - misc_nut_r,x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r])
    for(z=[belt_clamp_w/2,x_carriage_l-belt_clamp_w/2])
      translate([-huge/2,y,z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);

    // Hole for bushing cap
    //translate([0,x_rod_sep/2,-1]) polyhole(r=smallhole(misc_bolt_r,misc_bolt_pitch),h=huge);

    // Mounting holes for extruder
    for(y=[x_mount_offset,x_rod_sep - x_mount_offset])
    for(z=[x_mount_sep_x/2,-x_mount_sep_x/2])
      translate([-huge/2,y,x_carriage_l/2+z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);
  }
}

module belt_clamp()
{
    // Holes for belt clamp bolts
    linear_extrude(height=5)
    difference()
    {
      union()
      {
        translate([-misc_nut_r,0]) square([misc_nut_r*2,belt_w*2 + belt_sep + misc_nut_r*2]);
        polycircle(r=misc_nut_r,a=360/12);
        translate([0,belt_w*2+belt_sep+misc_nut_r*2]) polycircle(r=misc_nut_r,a=360/12);
      }
      polycircle(r=misc_bolt_r,a=360/12);
      translate([0,belt_w*2+belt_sep+misc_nut_r*2]) polycircle(r=misc_bolt_r,a=360/12);
    }


    
    //for(y=[x_rod_sep + belt_above_x - misc_nut_r,x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r])
    //for(z=[belt_clamp_w/2,x_carriage_l-belt_clamp_w/2])
    //  translate([-huge/2,y,z]) rotate([0,90,0]) polyhole(r=misc_bolt_r,h=huge,v=6,a=360/12);
}


module display_corner()
{
  corner();
  translate([0,0,corner_thick])
  {
    // Display T-slot Reference
    %cube([tslot_w,tslot_w,printer_l]);
    %cube([tslot_w,printer_l,tslot_w]);
    %cube([printer_l,tslot_w,tslot_w]);
  }
}

module corner()
{
  translate([0,0,corner_thick]) 
  {
    translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();
    mirror([0,1,0]) rotate([90,0,0])   translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();
    mirror([1,0,0]) rotate([0,-90,0])   translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();

  }
}

module corner_part()
{
  difference()
  {
    translate([-corner_thick,-corner_thick]) square([corner_thick+corner_length,corner_thick+corner_length]);
    translate([corner_length,tslot_w]) rotate(45) square([huge,huge]);
    for(d=[tslot_w*1.5:tslot_w:corner_length])
    {
      translate([d,tslot_w/2]) polycircle(r=tslot_bolt_r);
      translate([tslot_w/2,d]) polycircle(r=tslot_bolt_r);
    }


  }
}


module display_retainer()
{
  $fn = 64;
  retainer();
  translate([0,0,retainer_lip_thick + belt_w + retainer_lip_thick]) rotate([180,0,0]) retainer(false);
  %color("grey") translate([0,0,calc_retainer_b_off]) linear_extrude(height=bearing_w)
    ring(bearing_hole_r,bearing_r);
}


module retainer(inner=true)
{
  $fn = 64;
  difference()
  {
    union()
    {
      linear_extrude(height=retainer_lip_thick) ring(bearing_r - retainer_inner_width, bearing_r + retainer_shell_thick*2 + retainer_shell_sep+belt_thick);
      if(inner)
      {
        linear_extrude(height=calc_retainer_b_off + bearing_w) ring(bearing_r, bearing_r+retainer_shell_thick);
      }
      else
      {
        linear_extrude(height=retainer_lip_thick + belt_w) ring(bearing_r+retainer_shell_thick+retainer_shell_sep, bearing_r+retainer_shell_thick*2 + retainer_shell_sep);
      }
    }
    if(inner)
      translate([0,0,calc_retainer_b_off]) cylinder(r=bearing_r,h=bearing_w);
    else
      translate([0,0,calc_retainer_b_off]) cylinder(r=bearing_r+retainer_shell_thick+retainer_shell_sep,h=bearing_w);
  }
}


module bearing_mount_cap(x_sep=y_bearing_sep_y,z_sep=y_bearing_sep_z,base_height=bearing_mount_base,extra_height=bearing_mount_extra,v=32,a=0)
{
  difference()
  {
    union()
    {
      rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick,h=calc_retainer_b_off+base_height+extra_height,$fn=v);
      translate([x_sep,0,0]) rotate([0,0,a]) polyhole(r=bearing_bolt_r+bearing_bolt_holder_thick, h=calc_retainer_b_off+z_sep+base_height+extra_height,$fn=v);
      translate([0,-(bearing_bolt_r+bearing_bolt_holder_thick),0]) cube([x_sep,(bearing_bolt_r+bearing_bolt_holder_thick)*2,base_height]);
    }

    translate([0,0,-1])
    {
      polyhole(r=bearing_bolt_r,h=calc_retainer_b_off+base_height+extra_height+2,v=v,a=a);
      translate([x_sep,0,0]) polyhole(r=bearing_bolt_r, h=calc_retainer_b_off+z_sep+base_height+extra_height+2,v=v,a=a);
    }


  }
}


