# CoreXY Beta

Instructions coming soon.

Gallery of design and construction photos here:

http://imgur.com/a/doNUN

See core_assembly.scad for full design, individual files for instructions on what parts to print.

## Non-printed parts list (Possibly Incomplete!):

Please note this list doesn't include anything for an extruder.  The design includes a standard 
50mm reprap extruder mount, as well as a non-standard bowden J-Head mount.

* 4x 400mm T-slot (20mm thick)
* 8x 360mm T-slot (20mm thick)
* 8x 608 Bearing
* 8x M8x35 Hex Bolts (if using optional bearing caps)
* 8x M8x15 Hex Bolts (if not using optional bearing caps)
* 6x 8mm rod, 400mm length (Y and Z axis)
* 2x 8mm rod, 345mm length (X axis)
* 16x LM8UU Bearing
* 2x MakersToolWorks Leadscrews ( http://store.makerstoolworks.com/motion/z-axis-lead-screw-and-nut-single/ )
* 1x Set of two MakersToolWorks shaft couplers (optional, can use vinyl tubing) ( http://store.makerstoolworks.com/motion/helical-shaft-couplers-set-of-2/ )
* LOTS T-slot Nuts, M5 Threads
* LOTS M5x10 Bolts
* 4x NEMA17 Motors (See "A Note on the Motors" Below)
* 12x M5x65 Bolts
* 12x M5 Nuts
* 16x M3x16 Bolts (for mounting motors)
* Lots of M3x25, M3x35 bolts
* Lots of M3 Nuts
* Lots of GT2 2mm belt, 6mm wide

## A Note on the Motors

I use used Sanyo-Denki motors in this build, which come with 17-tooth 2mm pitch pulleys preinstalled.  They're very similar to these:

http://www.ebay.com/itm/Lot-of-5-NEMA-17-Stepper-Motors-Mill-Robot-RepRap-Makerbot-Prusa-3D-Printer-/261235505380?pt=LH_DefaultDomain_0&hash=item3cd2d978e4

You can find other similar motors being sold used on eBay, with the pulleys included.  Some have the heat sinks, some do not (mine don't).

You can use a nutsplitter to remove the pulleys from the motors where you don't need them, or get different motors for Z and E axis, or use pulleys and motors you have purchased separately, but keep in mind you'll have to change the motor_pulley_d to suit your own pulleys in vars.scad.

Most of these motors have 4mm shafts.  This doesn't make a difference if you're using their installed pulleys for X and Y, but if you are using my recommended MakersToolWorks couplers on Z, you will need two motors with 5mm shafts for those.  In addition, your extruder may want a 5mm shaft.

## Electronics

I am using this kit for my build: http://www.amazon.com/gp/product/B00F895XO6/ It's not bad.  I do recommend using RAMPS or RAMBO, wheverever you get them.

If you use the above RAMPS, or any other RAMPS, I strongly recommend these heat sinks: http://www.amazon.com/gp/product/B004CLDIHK/ or http://www.newegg.com/Product/Product.aspx?Item=N82E16835708011 plus some thermal epoxy to apply them.  They're far better than any heat sinks that came with your motor drivers.

## Hotend / Extruder

The design includes mounting parts for any standard reprap extruder (i.e. with two mounting holes separated by 50mm). 

The design also includes mounting parts for a J-Head and a bowden extruder.

In both cases, the extruder I am using is here:  http://www.thingiverse.com/thing:112478  
You'll need to dig into the scad files to get it to output a non-bowden version for your hotend.

