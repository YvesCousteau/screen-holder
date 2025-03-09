screen_height = 109;
screen_width = 164;
screen_depth = 7;
screen_border_width = 5;
screen_border_height = 8;

case_border_offset = 5; 
case_base_lenght = 120;
case_base_height = 20;

pcb_height = 53;
pcb_width = 113;
pcb_depth = 6;
pcb_border_offset = 4; 
pcb_total_hole_height = 7;
pcb_hole_size = 4.5;

rpi_height = 56;
rpi_width = 85;
rpi_depth = 6;
rpi_total_hole_height = 7;
rpi_hole_size = 5;

module screen_case() {
    color("gray")
    difference() {
        cube([screen_depth + case_border_offset ,screen_width + case_border_offset * 2, screen_height + case_border_offset * 2], center=true);
        translate([2, 0, 0])
        cube([ screen_depth + 6, screen_width, screen_height], center=true);
        translate([0, 0, 1.5])
        cube([screen_depth + 6, screen_width - screen_border_width * 2, screen_height - screen_border_height * 2], center=true);
    }
}


module screen_base() {
    color("gray")
    difference() {
        rotate([0,180,180])
        translate([-6, -screen_width/2 - case_border_offset, screen_height/2 + case_border_offset - case_border_offset])
        hull() {
            translate([0,0,0]) cube([1,screen_width + case_border_offset * 2,1]);
            translate([0,0,0]) cube([1,screen_width + case_border_offset * 2, case_base_height]);
            translate([0,0,0]) cube([case_base_lenght,screen_width + case_border_offset * 2,1]);
        }
        translate([50, 20, -screen_height/2 + pcb_depth/2])
        pcb_hole_cylinders();
        translate([60, -50, -screen_height/2 + pcb_depth/2])
        rpi_hole_cylinders();
    }
}


module pcb_hole_cylinders() {
    translate([ pcb_height/2 - 4,pcb_width/2 - 4, 0])
    cylinder(h=pcb_total_hole_height, r=pcb_hole_size, center=true, $fn=6);
    
    translate([ pcb_height/2 - 4,-pcb_width/2 + 4, 0])
    cylinder(h=pcb_total_hole_height, r=pcb_hole_size, center=true, $fn=6);
    
    translate([ -pcb_height/2 + 4,-pcb_width/2 + 4, 0])
    cylinder(h=pcb_total_hole_height, r=pcb_hole_size, center=true, $fn=6);
    
    translate([  -pcb_height/2 + 4,pcb_width/2 - 4,0])
    cylinder(h=pcb_total_hole_height, r=pcb_hole_size, center=true, $fn=6);
}

module screen_pcb() {
    color("purple")
    difference() {
        union(){
            translate([50, 20, -screen_height/2 + pcb_depth/2 + 0])
            color("pink")
            cube([  pcb_height + pcb_border_offset*2,pcb_width + pcb_border_offset*2,pcb_depth], center=true);
            translate([60, -50, -screen_height/2 + pcb_depth/2])
            cube([ rpi_width + pcb_border_offset*2,rpi_height + pcb_border_offset*2, rpi_depth], center=true);
        }
        translate([50, 20, -screen_height/2 + pcb_depth/2 + 0])
        pcb_hole_cylinders();
        translate([60, -50, -screen_height/2 + pcb_depth/2])
        rpi_hole_cylinders();
    }
}

module rpi_hole_cylinders() {
    translate([ rpi_width/2 - 24,rpi_height/2 - 3, 0])
    cylinder(h=rpi_total_hole_height, r=rpi_hole_size, center=true, $fn=6);
    
    translate([ -rpi_width/2 + 3,rpi_height/2 - 3, 0])
    cylinder(h=rpi_total_hole_height, r=rpi_hole_size, center=true, $fn=6);
    
    translate([ -rpi_width/2 + 3,-rpi_height/2 + 3, 0])
    cylinder(h=rpi_total_hole_height, r=rpi_hole_size, center=true, $fn=6);
    
    translate([ rpi_width/2 - 24, -rpi_height/2 + 3,0])
    cylinder(h=rpi_total_hole_height, r=rpi_hole_size, center=true, $fn=6);
}


union() {
    screen_case();
    screen_base();
    screen_pcb();
}
