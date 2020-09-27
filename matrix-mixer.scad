// Diamètre vis pot: 9mm
// Diamètre vis mute rouge: 10mm
// Diamètre vis minijack: 6mm
// Distance pot: 30mm

n = 6;
m = 4;

boardThickness = 3;
backBoardThickness = 2;
backHeight = 30;
potScrew = 9;
redMuteScew = 10;
minijackScew = 6;
potDistance = 30;
potScrewHeight = 7;
margin = 30;

h = potDistance * m + margin * 2;
w = potDistance * n + margin * 2;

/*
difference() {
    square([potDistance * n + margin * 2, potDistance * m + margin * 2]);
    projection(cut = true) translate([0, 0, boardThickness / 2]) components();
}
*/

board();
components();
back();
side();

module board() {
    translate([0, 0, -boardThickness])
    color("Peru")
    cube([w, h, boardThickness]);
}

module back() {
    translate([0, h - backBoardThickness, -backHeight -boardThickness])
    color("BurlyWood")
    cube([w, backBoardThickness, backHeight]);
}

module side() {
    translate([0, backBoardThickness, -backHeight -boardThickness])
    color("NavajoWhite")
    cube([backBoardThickness, h - 2 * backBoardThickness, backHeight]);
}

module components() {
    translate([margin, margin, 0]) {
        for (i = [0:n], j = [0:m]) {
            translate([i * potDistance, j * potDistance, 0]) {
                if (i == 0 && j == m) {}
                else if (i == 0 || j == m) {
                    muteButton();
                    
                    if (i == 0) {
                        translate([- margin + backBoardThickness, 0,  -boardThickness - backHeight / 2])
                        rotate([0, -90, 0])
                        minijack();
                    }
                    else if (j == m) {
                        translate([0, margin - backBoardThickness,  -boardThickness - backHeight / 2])
                        rotate([-90, 0, 0])
                        minijack();
                    }
                } else {
                    pot();
                }
            }
        }
    }
}

module pot() {
    color([0.8, 0.8, 0.8])
    potScrew();

    translate([0, 0, potScrewHeight - boardThickness]) {
        potCap();
    }


    translate([-5.5, -5.5, -9 - boardThickness]) {
        color([0, 0.6, 0.3])
        cube([11, 11, 9]);
        
        // Contacts
        translate([2.4, -3, 2]) {
            for (i = [0:2], j = [0:1]) {
                translate([i * 2.5, 0, 3 * j])
                color([1, 1, 1])
                cube([1, 3, 0.1]);
            }
        }
    }
}

module potCap() {
    potCapHeight = 15;
    potBaseDiameter = 15;
    potTopDiameter = 14;
    color([0.2, 0.2, 0.2])
    cylinder(potCapHeight, d1=potBaseDiameter, d2=potTopDiameter, false, $fn=40);

    rotate([0, 0, rands(-270, 0, 1)[0] + 150])
    color([0.0, 0.5, 0.0])
    translate([-0.5, 0, 0])
    cube([1, potBaseDiameter / 2 + 0.3, potCapHeight + 0.3]);
}

module potScrew() {
    translate([0, 0, - boardThickness])
    cylinder(potScrewHeight, d=potScrew, true, $fn=40);
    cylinder(2, d=12.5, false, $fn=6);
}

module muteButton() {
    height = 3.5;
    redDiameter = 7;
    blackDiameter = 12.5;
    screwHeight = 18.5;
    
    color([0, 0, 0])
    cylinder(height, d=blackDiameter, false, $fn=40);

    translate([0, 0, height])
    color([1, 0, 0])
    cylinder(height, d=redDiameter, false, $fn=40);
    
    translate([0, 0, -screwHeight])
    color([0, 0, 0])
    cylinder(screwHeight, d=redMuteScew, false, $fn=40);
    
    // Contacts
    translate([0, 2, -screwHeight - 3])
    color([1, 1, 1])
    cube([1, 0.1, 3]);
    translate([0, -2, -screwHeight - 3])
    color([1, 1, 1])
    cube([1, 0.1, 3]);
}

module minijack() {
    screwHeight = 4;
    jackHeight = 12;
    jackDiameter = 8;
    nutHeight = 2;
    // Screw
    color("Gold")
    cylinder(screwHeight, d=minijackScew, false, $fn=40);
    // Body
    color("Black")
    translate([0, 0, - jackHeight])
    cylinder(jackHeight, d=jackDiameter, false, $fn=40);
    // Nut
    color("Gold")
    translate([0, 0, backBoardThickness])
    cylinder(nutHeight, d=jackDiameter, false, $fn=40);
    // Contacts
    translate([0, 2, - jackHeight - 6.5])
    color([1, 1, 1])
    cube([1, 0.1, 6.5]);
    // Hole
    color("Black")
    cylinder(screwHeight + 0.1, d=3.5, false, $fn=40);
}
