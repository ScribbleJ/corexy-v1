// Variables used throughout design.
// Yes, these could use some commenting.
// (c) 2014, Christopher "ScribbleJ" Jansen

// Printer outside dimensions are actually this + corner_thick*2.
printer_w = 400;
printer_l = 400;
printer_h = 400;

// Used wherever I need something arbitrarily large.
huge=500;

// 608 Bearings
bearing_w = 7;
bearing_d = 22;
bearing_r = bearing_d/2;
bearing_hole_d = 8;
bearing_hole_r = bearing_hole_d/2;

// Miscellaneous bolts, M3
misc_bolt_d = 3.2;
misc_bolt_r = misc_bolt_d/2;
misc_nut_r  = misc_bolt_d;
misc_bolt_pitch = 0.5;
misc_bolthead_d = misc_bolt_d*2;
misc_bolthead_r = misc_bolthead_d/2;

// Bearing retainers
retainer_shell_thick = 0.5;
retainer_shell_sep   = 0.25;
retainer_lip_thick   = 2;
retainer_inner_width = 1;

// GT2, 2mm belting
belt_w    = 6;
belt_thick= 2;
belt_sep  = retainer_lip_thick*2 + 2;

// Some calculated info about the bearing retainers.
calc_retainer_h  = retainer_lip_thick*2 + belt_w;
calc_retainer_ir = bearing_r + retainer_shell_thick*2 + retainer_shell_sep;
calc_retainer_or = calc_retainer_ir + belt_thick;
calc_retainer_b_off = retainer_lip_thick - (bearing_w-belt_w)/2;

// 20mm Tslot and associated bolt dimensions
tslot_w = 20;
tslot_bolt_d = 5;
tslot_bolt_r = tslot_bolt_d/2;
tslot_bolt_l = 4;
tslot_bolthead_d = 10;
tslot_bolthead_r = tslot_bolthead_d/2;

// This variable is called corner_thick, but it's used pretty much everywhere something needs to be sturdy but thin, not
// just on the corners.
// TODO: Anywhere it's used that's not a corner, I should make a new variable for that thing.
corner_thick = 5;
corner_length = tslot_w*3;

// 8mm Smooth Rod dimensions
rod_d=8;
rod_r=rod_d/2;

// Named because they were originally bronze bushings, now expects to be LM8UU.
bushing_d=15;
bushing_r=bushing_d/2;
bushing_l=10;
bushing_flange_r = bushing_r+3;
bushing_flange_w = 1;
bushing_material_thick = 5;

// X Axis dimensions
x_rod_sep = 50;
x_carriage_l = 50;
x_mount_sep_x = x_carriage_l - misc_bolthead_r*2*2 - misc_bolt_r*2;
x_mount_offset = bushing_r + misc_bolt_r * 2;
belt_above_x = bushing_r+misc_nut_r*2;
belt_clamp_w = 7;
x_rod_past_bearing = 20;

// Y Axis dimensions
belt_above_y = 45;
y_above_x = belt_above_x-belt_above_y;


// The standoffs for the belt idler bearings.
bearing_mount_base = corner_thick;
bearing_mount_extra = 2;
belt_above_bearing_mount = bearing_mount_base + bearing_mount_extra + retainer_lip_thick;
bearing_mount_support_tweak = 30;
y_bearing_offset = bushing_r+bushing_material_thick-calc_retainer_ir;
y_bearing_sep_y = calc_retainer_ir*2+belt_thick;
y_bearing_sep_z = belt_w+belt_sep;
bearing_bolt_r  = 4;
bearing_bolt_pitch = 1.25;
bearing_bolt_holder_thick = 4;

// Gap between Y carriage and T-slot
y_carriage_from_tslot = 2;

// 50mm Y-carriage length fits 2 LM8UU
y_carriage_len = 50;

// NEMA17 Motor Dimensions
motor_w = 42.3;
motor_h = motor_w;
motor_bolt_sep = 31.0;
motor_bolt_r   = 1.5;
// Dimensions of pulleys on X/Y Motors
motor_pulley_d = 10;
motor_pulley_r = motor_pulley_d/2;
motor_pulley_h = 5.3;  // This is the distance the pulley is above the motor body, not the height of the pulley itself.
motor_flange_d = 23;
motor_flange_r = motor_flange_d/2;
// This creates an extra hole in the motor corner for T-slot mounting, because the spaces for the motor mounts may coincide 
// with one of the standard holes.
motor_corner_extra_hole_pos = tslot_bolt_r+3;

// Some useful precalculated values
calc_corner_from_y_rod = x_rod_past_bearing+corner_thick+y_carriage_from_tslot+tslot_w;
calc_corner_above_x = belt_above_x - belt_above_bearing_mount + bearing_mount_base;
calc_motor1_above_x  = belt_above_x - motor_pulley_h;
calc_motor2_above_x  = belt_above_x - motor_pulley_h + belt_w + belt_sep;
calc_motor_from_y_rod = -bushing_r - bushing_material_thick + bearing_bolt_holder_thick + bearing_bolt_r + calc_retainer_or + motor_pulley_r;

// Motor bracket thick is 12 because I'm using M3x16 to mount the motors and the bolts can fit about 4mm into a NEMA17.
motor_bracket_thick = 12;
motor_bracket_wide = (motor_w - motor_flange_d) / 2;
motor_bracket_len  = motor_w;
motor_bolt_offset  = (motor_w - motor_bolt_sep) / 2;

// How far apart the Z smooth rods should be
z_rod_sep = 150;
z_motor_off = motor_h - tslot_w - corner_thick;

// Very important to set this for your lasercut Z, the thickness of the material you are lasering.
laser_mat_thick = 4.75;
// Laser mat margin is how much material is required outside of a tabslot.
laser_mat_margin = laser_mat_thick;
// Distance between heated bed holes, 209 is standard for a reprap heated bed
bed_mount_sep   = 209;
// Bed mounting holes will be created centered on the Z platform, and another set offset at this distance from the smooth rod:
bed_from_z      = 60;
// bed_box_r and bed_box_h here will exactly fir the lm8uu holders.  Decrease at your own peril.
bed_box_r       = 25;
bed_box_h       = 50;
z_ends_sep = printer_l - tslot_w*2 - corner_thick*2 - motor_w;
platform_l      =  laser_mat_margin*2 + laser_mat_thick*2 + bed_box_r*2 + z_ends_sep;
platform_w      = bed_mount_sep + misc_bolt_r*2 + laser_mat_margin*2;
// These settings for the leadscrew fit the leadscrews sold by MakersToolWorks
z_leadscrew_passthrough_r = 12/2;
leadscrew_bolt_offset = 22/2;
leadscrew_bolt_r = 3.2/2;
laser_bushing_fudge = 0.1; // No longer used since the change to lm8uu


// LM8UU bearing dimensions
lm8uu_d=15;
lm8uu_r=lm8uu_d/2;
lm8uu_l=24;
// The nut and bolt here refer to the ones used in the Z axis' four LM8UU holders.
lm8uu_bolt_r=5/2;
lm8uu_nut_r=10/2;

arduino_width=60;

