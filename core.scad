include <vars.scad>

display_assembly();


module bolt(bolt_r = misc_bolt_r,bolthead_r = misc_bolthead_r,bolt_len = huge)
{
  translate([0,0,-bolt_len]) cylinder(r=bolt_r,h=bolt_len+1);
  cylinder(r=bolthead_r,h=huge);
}

module motor_bracket()
{
  difference()
  {
    union()
    {
      translate([-tslot_w+1,0,0]) cube([tslot_w+corner_thick,corner_thick,motor_bracket_wide]);
      translate([0,-tslot_w+1,0]) cube([corner_thick,tslot_w+corner_thick,motor_bracket_wide]);
      translate([-tslot_w/2,0,0]) cube([tslot_w/2+motor_bracket_thick+motor_bracket_len+corner_thick,corner_thick+motor_bracket_thick,motor_bracket_wide]);
      translate([0,-tslot_w/2,0]) cube([motor_bracket_thick+corner_thick,tslot_w/2+motor_bracket_thick,motor_bracket_wide]);
    }
    translate([-tslot_w/2,corner_thick,motor_bracket_wide/2]) rotate([-90,0,0]) bolt(tslot_bolt_r,tslot_bolthead_r,$fn=8);
    translate([corner_thick,-tslot_w/2,motor_bracket_wide/2]) rotate([0,90,0]) bolt(tslot_bolt_r,tslot_bolthead_r,$fn=8);
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);
    translate([motor_bracket_thick+corner_thick+motor_bolt_offset+motor_bolt_sep,-huge/2,motor_bolt_offset]) rotate([-90,0,0]) cylinder(r=misc_bolt_r,h=huge);
    translate([motor_bracket_thick+corner_thick,-huge - calc_corner_above_x + calc_motor2_above_x + corner_thick,-1]) cube([huge,huge,huge]);
  }

}

module bearing_corner()
{
  display_corner();
  translate([tslot_w,0,calc_corner_from_y_rod+corner_thick-calc_motor_from_y_rod+calc_retainer_ir-motor_pulley_r]) rotate([0,-asin((motor_pulley_d+belt_thick)/y_bearing_sep_y),0]) rotate([90,180,0]) translate([-y_bearing_sep_y,0,0]) display_bearing_mount();
  
}



module motor_corner()
{
  difference()
  {
    display_corner();

    //#translate([0,calc_corner_from_y_rod-calc_motor_from_y_rod,0]) cylinder(r=5,h=50);
    translate([-corner_thick-1,calc_corner_from_y_rod-calc_motor_from_y_rod-motor_w/2-1,-1]) 
    difference()
    {
      cube([tslot_w+corner_thick+1,motor_w+2,tslot_w+corner_thick+1]);
      translate([-huge/2,motor_bracket_wide+2,-huge/2]) cube([huge,-2+motor_w-motor_bracket_wide*2,huge]);
    }
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
  translate([0,50,-x_rod_sep]) rotate([90,0,0]) x_carriage();

  %translate([0,huge/2,0]) rotate([90,0,0]) cylinder(r=rod_r,h=huge);
  %translate([0,huge/2,-x_rod_sep]) rotate([90,0,0]) cylinder(r=rod_r,h=huge);
  %translate([-huge/2,0,-x_rod_sep/2]) rotate([0,90,0]) cylinder(r=rod_r,h=huge);

  translate([0,bushing_r+bushing_material_thick,-x_rod_sep]) rotate([90,0,0]) y_carriage();

  translate([tslot_w * 4,-calc_corner_from_y_rod,calc_corner_above_x]) rotate([0,180,0]) motor_corner();
  translate([-tslot_w * 4,-calc_corner_from_y_rod-corner_thick,calc_corner_above_x-corner_thick]) rotate([-90,0,0]) bearing_corner();

  %translate([tslot_w*4 + corner_thick + motor_w/2 + motor_bracket_thick,
              bushing_r + bushing_material_thick - bearing_bolt_holder_thick - bearing_bolt_r - calc_retainer_or - motor_pulley_r,
              belt_above_x - motor_pulley_h + belt_w + belt_sep]) motor(); 

  translate([tslot_w*4,-calc_motor_from_y_rod + motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) motor_bracket();
  translate([tslot_w*4,-calc_motor_from_y_rod - motor_w/2, calc_corner_above_x - corner_thick]) rotate([90,0,0]) mirror([0,0,1]) motor_bracket();
}

module print_y_carriages()
{

translate([bushing_r*2 + bushing_material_thick*2 + 5,0,0]) y_carriage();
mirror([1,0,0]) y_carriage(true);

}

module y_carriage(left = false)
{
  part_width = bushing_r*2+bushing_material_thick*2;
  if(left)
  {
    translate([y_bearing_offset + y_bearing_sep_y, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,180,0]) display_bearing_mount($fn=6);
  }
  else
  {
    translate([y_bearing_offset, x_rod_sep + belt_above_x - belt_above_bearing_mount, bearing_bolt_r+bearing_bolt_holder_thick]) rotate([-90,0,0]) display_bearing_mount($fn=6);
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
      translate([0,x_rod_sep/2,0]) rotate([0,90,0])
      linear_extrude(height = y_bearing_sep_y + y_bearing_offset)
      {
        translate([-part_width/2,0]) circle(r=part_width/2);
        translate([-part_width,0]) circle(r=misc_nut_r);
        translate([-part_width/2,-part_width/2]) 
          square([part_width/2, part_width/2 + x_rod_sep/2 + belt_above_x - belt_above_bearing_mount + bearing_mount_base]);
      }
    }

    // X-rod holes
    translate([0,0,-1]) linear_extrude(height = part_width/2 + x_rod_past_bearing + 1)
    {
      circle(r=rod_r); 
      translate([0,x_rod_sep]) circle(r=rod_r);
    }

    // Y-rod hole
    translate([-huge/2,x_rod_sep/2,part_width/2]) rotate([0,90,0]) cylinder(r=bushing_r,h=huge);
    translate([-huge/2,x_rod_sep/2,part_width]) rotate([0,90,0]) cylinder(r=misc_bolt_r,h=huge);
  }
}

module display_bearing_mount(x_sep=10,z_sep=10,base_height=5,extra_height=2)
{
  translate([0,0,5+2])
  {
    %display_retainer();
    %translate([y_bearing_sep_y,0,y_bearing_sep_z]) display_retainer();
  }
  bearing_mount(y_bearing_sep_y,y_bearing_sep_z);
}

module bearing_mount(x_sep = 10,z_sep = 10,base_height=5,extra_height=2)
{
  difference()
  {
    union()
    {
      rotate([0,0,30]) cylinder(r=bearing_bolt_r+bearing_bolt_holder_thick,h=calc_retainer_b_off+base_height+extra_height);
      translate([x_sep,0,0]) rotate([0,0,30]) cylinder(r=bearing_bolt_r+bearing_bolt_holder_thick, h=calc_retainer_b_off+z_sep+base_height+extra_height);
      translate([0,-(bearing_bolt_r+bearing_bolt_holder_thick),0]) cube([x_sep,(bearing_bolt_r+bearing_bolt_holder_thick)*2,base_height]);
    }

    translate([0,0,-1])
    {
      cylinder(r=bearing_bolt_r,h=calc_retainer_b_off+base_height+extra_height+2);
      translate([x_sep,0,0]) cylinder(r=bearing_bolt_r, h=calc_retainer_b_off+z_sep+base_height+extra_height+2);
    }


  }
}

module x_carriage()
{
  x_len = x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r*2;
  difference()
  {
    // Shape
    linear_extrude(height=x_carriage_l)
    {
      circle(r=bushing_r+bushing_material_thick);
      translate([0,x_len]) circle(r=bushing_r+bushing_material_thick);
      translate([-(bushing_r+bushing_material_thick), 0]) square([2*(bushing_r+bushing_material_thick),x_len]);
    }

    // Bushing/Rod Channels
    for(x=[0,x_rod_sep])
      translate([0,x,-1]) cylinder(r=bushing_r,h=x_carriage_l+2);

    // Belt Passthrough
    translate([-huge/2,x_rod_sep + belt_above_x,belt_clamp_w]) cube([huge,belt_w*2+belt_sep,x_carriage_l-belt_clamp_w*2]);

    // Holes for belt tensioner
    for(y=[x_rod_sep+belt_above_x+belt_w/2,x_rod_sep+belt_above_x+belt_w+belt_sep+belt_w/2])
    {
      translate([0,y,-1]) cylinder(r=misc_bolt_r,h=belt_clamp_w+2);
      translate([0,y,belt_clamp_w - 2]) cylinder(r=misc_nut_r,h=belt_clamp_w+2,$fn=6);
    }

    // Holes for belt clamp bolts
    for(y=[x_rod_sep + belt_above_x - misc_nut_r,x_rod_sep + belt_above_x + belt_w*2 + belt_sep + misc_nut_r])
    for(z=[belt_clamp_w/2,x_carriage_l-belt_clamp_w/2])
      translate([-huge/2,y,z]) rotate([0,90,0]) cylinder(r=misc_bolt_r,h=huge);

    // Hole for bushing cap
    translate([0,x_rod_sep/2,-1]) cylinder(r=misc_bolt_r,h=huge);

    // Mounting holes for extruder
    for(y=[x_mount_sep_z/2,-x_mount_sep_z/2])
    for(z=[x_mount_sep_x/2,-x_mount_sep_x/2])
      translate([-huge/2,x_rod_sep/2+y,x_carriage_l/2+z]) rotate([0,90,0]) cylinder(r=misc_bolt_r,h=huge);
  }
}

module display_corner()
{
  corner();
  translate([0,0,corner_thick])
  {
    // Display T-slot Reference
    %cube([tslot_w,tslot_w,huge]);
    %cube([tslot_w,huge,tslot_w]);
    %cube([huge,tslot_w,tslot_w]);
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
      translate([d,tslot_w/2]) circle(r=tslot_bolt_r);
      translate([tslot_w/2,d]) circle(r=tslot_bolt_r);
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

module ring(inner=5,outer=10)
{
  difference()
  {
    circle(r=outer);
    circle(r=inner);
  }
} 
