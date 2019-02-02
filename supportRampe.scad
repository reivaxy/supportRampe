
glass = 6;
tolerance = 0.6;
innerY = glass + tolerance;
wall = 3.5;
pillarY = 11;
innerZ = 20;
pillarDiam = 8.8;
pillarZ = 20;

y = innerY + 2*wall + pillarY + pillarDiam;
z = innerZ + pillarZ + wall;


supportRampe(150);
//translate([0, 100, 0])
//  supportRampe(80);


module supportRampe(x) {
  difference() {
    cube([x, y, z]);
    translate([-1, y - innerY - wall, 0])
      cube([x+2, innerY, innerZ]);
    translate([-1, y - innerY - wall + 1, 0])
      cube([x+2, y, 10]);

    xDiam = (x - 2*wall - pillarDiam ) + 5;
    yDiam = 2*(y - 2*wall - innerY);
    zDiam = pillarZ * 2;

    // left horizontal cylindrical cut out
    color("red")
      translate([0, 49, zDiam + wall])
        YCylinder(xDiam, 50, zDiam);
    // right horizontal cylindrical cut out
    color("yellow")
      translate([x, 49, zDiam + wall])
        YCylinder(xDiam, 50, zDiam);

    // left vertical cylindrical cut out
    translate([0, 0, 0])
      ZCylinder(xDiam, yDiam, z + pillarZ);
    // right vertical cylindrical cut out
    translate([x, 0, 0])
      ZCylinder(xDiam, yDiam, z + pillarZ);

    // back horizontal cylindrical cut out
    translate([0, y, z + pillarZ])
      XCylinder(x, y - pillarDiam , z);

    // Pillar hole
    translate([x/2, wall*2, innerZ - 12])
      cylinder(d=pillarDiam, h=z+2, $fn=100);
  }
}


// Ellipsoid on x axis
module XCylinder(x, y, z) {
  rotate(90, [0, 1, 0])
    scale([1, y/z, 1])
      cylinder(d=80, h=x, $fn=100);
}
// Ellipsoid on y axis
module YCylinder(x, y, z) {
  rotate(90, [1, 0, 0])
    scale([1, z/x, 1])
      cylinder(d=x, h=y, $fn=100);
}
// Ellipsoid on z axis
module ZCylinder(x, y, z) {
    scale([1, y/x, 1])
      cylinder(d=x, h=z, $fn=100);
}

