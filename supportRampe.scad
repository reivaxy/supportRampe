
glass = 6;
tolerance = 0.6;

x = 80;
innerY = glass + tolerance;
innerZ = 20;
wall = 3.5;

y = innerY + 2*wall;
z = innerZ + wall;

supportRampe();
//support();

module supportRampe() {
  pince();
  translate([0, -holeDiam - wall, 0])
    support();
}

module pince() {
  difference() {
    cube([x, y, z]);
    translate([-1, wall, 0])
      cube([x+2, innerY, innerZ]);
    translate([-1, wall + 1, 0])
      cube([x+2, y, 10]);
  }
}

holeDiam = 8.8;
holeDepth = 37;
verticalCylinderDiam = 180;
horizontalCylinderDiam = x - holeDiam - wall;
backHorizontalCylinderDiam = 100;

module support() {
  difference() {
    cube([x, holeDiam + wall + y, z*2]);

    // X horizontal cylinder
    translate([-1, backHorizontalCylinderDiam/2 + holeDiam + 2*wall, backHorizontalCylinderDiam/2]) {
      rotate(90, [0, 1, 0])
       cylinder(d=backHorizontalCylinderDiam, h=x + 2, $fn=200);
    }

    // Left horizontal cylinder
    translate([0, holeDiam + wall + y + 1, horizontalCylinderDiam/2 + z]) {
      rotate(90, [1, 0, 0])
       cylinder(d=horizontalCylinderDiam, h=z*2 + 2, $fn=200);
    }
    // rotated Left horizontal cylinder
    color("blue")
    translate([0, 3*holeDiam , 0])
    rotate(45, [0, 0, -1])
    translate([0, holeDiam + wall + y + 1, horizontalCylinderDiam/2 + z]) {
      rotate(90, [1, 0, 0])
       cylinder(d=horizontalCylinderDiam, h=z*2 + 2, $fn=200);
    }
    // right horizontal cylinder
    translate([x, holeDiam + wall + y + 1, horizontalCylinderDiam/2 + z]) {
      rotate(90, [1, 0, 0])
       cylinder(d=horizontalCylinderDiam, h=z*2 + 2, $fn=200);
    }

    // rotated right horizontal cylinder
    color("blue")
    translate([0, -holeDiam , 0])
    rotate(45, [0, 0, 1])
    translate([x, holeDiam + wall + y + 1, horizontalCylinderDiam/2 + z]) {
      rotate(90, [1, 0, 0])
       cylinder(d=horizontalCylinderDiam, h=z*20 + 2, $fn=200);
    }

    // Left vertical cylinder
    translate([-holeDiam/2 - wall, -verticalCylinderDiam/2 + holeDiam + wall, -1]) {
      cylinder(d=verticalCylinderDiam, h=z*2 + 2, $fn=200);
    }
    // right vertical cylinder
    translate([holeDiam/2 + wall + x, -verticalCylinderDiam/2 + holeDiam + wall, -1]) {
      cylinder(d=verticalCylinderDiam, h=z*2 + 2, $fn=200);
    }

    translate([-1, y - 1, -1])
      cube([x + 2, y + 1, z + 1]);

    // Trou
    color("red")
    translate([x/2, holeDiam /2 + wall, z*2 - holeDepth + 0.1]) {
      cylinder(d=holeDiam, h=holeDepth + 0.1, $fn=100);
    }
  }
}