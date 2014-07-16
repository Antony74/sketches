
// All measurements in millimeters.  It's not a single coordinate-system - different matrices are applied to some CompositeShapes before drawing

float xStart      =       0.0;
float xEnd        =    2700.0;
float yFloor      =       0.0;
float yEaves      =   -1020.0;
float zWall       =       0.0;
float yCeiling    =   -2670.0;
float nDoorWidth  =     685.0;
float nDoorHeight =   -1970.0;
float zWallToDoor =    1030.0;
float nMargin     =     100.0;
float nWindowWidth =    760.0;
float nWindowHeight =   765.0;
float xWindowOffset =   980.0;
float yWindowOffset =   100.0;

float yEavesToCeiling = abs(yCeiling) - abs(yEaves);
float nEavesLength = sqrt(2) * yEavesToCeiling;

CompositeShape leftWall = (new CompositeShape())
                              .vertex(new Vertex("A", xStart, yFloor,      zWall))
                              .vertex(new Vertex("B", xStart, yEaves,      zWall))
                              .vertex(new Vertex("C", xStart, yCeiling,    yEavesToCeiling))
                              .vertex(new Vertex("D", xStart, yCeiling,    zWallToDoor + nDoorWidth + nMargin))
                              .vertex(new Vertex("E", xStart, yFloor,      zWallToDoor + nDoorWidth + nMargin))
                              .vertex(new Vertex("F", xStart, yFloor,      zWallToDoor + nDoorWidth))
                              .vertex(new Vertex("G", xStart, nDoorHeight, zWallToDoor + nDoorWidth))
                              .vertex(new Vertex("H", xStart, nDoorHeight, zWallToDoor))
                              .vertex(new Vertex("I", xStart, yFloor,      zWallToDoor))
                              .outline("ABCDEFGHI")
                              .fill("ABHI")
                              .fill("BCH")
                              .fill("CDGH")
                              .fill("DEFG");

CompositeShape backWall = (new CompositeShape())
                              .vertex(new Vertex("A", xStart, yFloor, zWall)) 
                              .vertex(new Vertex("B",   xEnd, yFloor, zWall))
                              .vertex(new Vertex("C",   xEnd, yEaves, zWall))
                              .vertex(new Vertex("D", xStart, yEaves, zWall))
                              .outline("ABCD")
                              .fill("ABCD");

CompositeShape rightWall = (new CompositeShape())
                              .vertex(new Vertex("A", xEnd, yFloor,   zWall))
                              .vertex(new Vertex("B", xEnd, yEaves,   zWall))
                              .vertex(new Vertex("C", xEnd, yCeiling, yEavesToCeiling))
                              .vertex(new Vertex("D", xEnd, yFloor,   yEavesToCeiling))
                              .outline("ABCD")
                              .fill("ABCD");

CompositeShape bathroomDoor = (new CompositeShape())
                              .vertex(new Vertex("A", 0, 0,           0))
                              .vertex(new Vertex("B", 0, nDoorHeight, 0))
                              .vertex(new Vertex("C", 0, nDoorHeight, nDoorWidth))
                              .vertex(new Vertex("D", 0, 0,           nDoorWidth))
                              .outline("ABCD")
                              .fill("ABCD");
                              
CompositeShape eaves = (new CompositeShape())
                              .vertex(new Vertex("A", xStart, 0,            0))
                              .vertex(new Vertex("B", xStart, nEavesLength, 0))
                              .vertex(new Vertex("C", xEnd,   nEavesLength, 0))
                              .vertex(new Vertex("D", xEnd,   0,            0))
                              .vertex(new Vertex("E", xStart + xWindowOffset, nEavesLength - yWindowOffset, 0))
                              .vertex(new Vertex("F", xStart + xWindowOffset + nWindowWidth, nEavesLength - yWindowOffset, 0))
                              .vertex(new Vertex("G", xStart + xWindowOffset + nWindowWidth, nEavesLength - yWindowOffset - nWindowHeight, 0))
                              .vertex(new Vertex("H", xStart + xWindowOffset, nEavesLength - yWindowOffset - nWindowHeight, 0))
                              .outline("ABCD")
                              .outline("EFGH")
                              .fill("ABEH")
                              .fill("BCFE")
                              .fill("CDGF")
                              .fill("DAHG");


