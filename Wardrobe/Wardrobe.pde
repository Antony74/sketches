
final int PAGE_UP = 33;
final int PAGE_DOWN = 34;

float nDistance = 4400.0;
float nRotation = HALF_PI - 0.1;
float nElevation = 200.0;

float nDoorRotation = 0.0;
float nDoorRotationPerFrame = 0.0;

void setup()
{
  size(900, 600, P3D);
}

void keyPressed()
{
  switch(keyCode)
  {
  case LEFT:
    nRotation -= 0.03;
    break;
  case RIGHT:
    nRotation += 0.03;
    break;
  case UP:
    nElevation += 10;
    break;
  case DOWN:
    nElevation -= 10;
    break;
 case PAGE_UP:
   nDistance -= 10;
   break;
 case PAGE_DOWN:
   nDistance += 10;
   break;
 case ENTER:
   if (nDoorRotationPerFrame != 0)
   {
     nDoorRotationPerFrame *= -1;
   }
   else if (nDoorRotation > PI/4)
   {
     nDoorRotationPerFrame = -0.01;
   }
   else
   {
     nDoorRotationPerFrame = 0.01;
   }
   break;
 }
}

void draw()
{
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), -nElevation, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  drawRoom();
}

void drawRoom()
{
  // The real work starts here.  It's all in millimeters, by the way

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
  
  float yEavesToCeiling = abs(yCeiling) - abs(yEaves);
  float nEavesLength = sqrt(2) * yEavesToCeiling;

  // Let's look somewhere roughly central
  translate(xStart + xEnd / -2.0, -yEaves * 1.3, 0);

  // Draw the back wall  
  beginShape();
  vertex( xStart, yFloor, zWall); 
  vertex(   xEnd, yFloor, zWall); 
  vertex(   xEnd, yEaves, zWall); 
  vertex( xStart, yEaves, zWall); 
  endShape(CLOSE);

  // Draw the right-hand wall
  beginShape();
  vertex( xEnd, yFloor,   zWall);
  vertex( xEnd, yEaves,   zWall);
  vertex( xEnd, yCeiling, yEavesToCeiling);
  vertex( xEnd, yFloor,   yEavesToCeiling);
  endShape(CLOSE);

  // Draw the left-hand wall leaving a space for the bathroom door
  beginShape();
  vertex( xStart, yFloor,      zWall);
  vertex( xStart, yEaves,      zWall);
  vertex( xStart, yCeiling,    yEavesToCeiling);
  vertex( xStart, yCeiling, zWallToDoor + nDoorWidth + nMargin);
  vertex( xStart, yFloor, zWallToDoor + nDoorWidth + nMargin);
  vertex( xStart, yFloor, zWallToDoor + nDoorWidth);
  vertex( xStart, nDoorHeight, zWallToDoor + nDoorWidth);
  vertex( xStart, nDoorHeight, zWallToDoor);
  vertex( xStart, yFloor,      zWallToDoor);
  endShape(CLOSE);

  // Move the bathroom door
  nDoorRotation += nDoorRotationPerFrame;
  if (nDoorRotation < 0)
  {
    nDoorRotation = 0;
    nDoorRotationPerFrame = 0;
  }
  else if (nDoorRotation > HALF_PI)
  {
    nDoorRotation = HALF_PI;
    nDoorRotationPerFrame = 0;
  }
  
  // Draw the bathroom door
  pushMatrix();
  translate(xStart, yFloor, zWallToDoor);
  rotateY(nDoorRotation);

  beginShape();
  vertex( 0, 0, 0);
  vertex( 0, nDoorHeight, 0);
  vertex( 0, nDoorHeight, nDoorWidth);
  vertex( 0, 0, nDoorWidth);
  endShape(CLOSE);
  popMatrix();

  // Move the y-axis onto the eaves in order to draw them
  pushMatrix();
  translate(0, yEaves, 0);
  rotateX(0.75 * PI);  

  beginShape();
  vertex( xStart,          0.0, zWall); 
  vertex(   xEnd,          0.0, zWall); 
  vertex(   xEnd, nEavesLength, zWall); 
  vertex( xStart, nEavesLength, zWall); 
  endShape(CLOSE);
  popMatrix();
}



