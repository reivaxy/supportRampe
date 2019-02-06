
innerDiam = 6.1;
outerDiam = 9;
glass = 6;
tolerance = 0.1;
innerY = glass + tolerance;
innerZ = 20;
wall = 3;

x = 8;
y = innerY + 2*wall ;
z = innerZ + wall;
clipZ = 4;


cableClip();

module cableClip() {
  openingWidth = innerDiam + 3;
  difference() {
    cube([x, y, z]);
    translate([-1, y - innerY - wall, wall])
      cube([x+2, innerY, innerZ]);
    translate([-1, y - innerY - wall + 1, z - 10])
      cube([x+2, y, 10]);
  }
  clipWall = outerDiam - innerDiam;
  translate([x/2, -outerDiam/2 + 1, 0]) {
    difference() {
      cylinder(d=outerDiam, h=clipZ, $fn=80);
      translate([0, -clipWall/2 , 0])
        cylinder(d=innerDiam, h=clipZ, $fn=80);
      color("red")
        translate([-openingWidth/2, -innerDiam/2 - 3, 0])
          cube([openingWidth, 3, clipZ]);
    }
  }

}
