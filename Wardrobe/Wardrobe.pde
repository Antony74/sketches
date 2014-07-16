
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
  background(128,128,255);
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
  float nWindowWidth =    760.0;
  float nWindowHeight =   765.0;
  float xWindowOffset =   980.0;
  float yWindowOffset =   100.0;
  
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

  leftWall.draw();

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

  drawWallWithWindow(xStart, 0.0, xEnd, nEavesLength, xWindowOffset, yWindowOffset, nWindowWidth, nWindowHeight);

  popMatrix();

}

void drawWallWithWindow(float xStart, float yStart, float xEnd, float yEnd, float xWindowOffset, float yWindowOffset, float nWindowWidth, float nWindowHeight)
{
  pushStyle();
  noStroke();

  beginShape();
  vertex(xStart, yStart, 0);
  vertex(xStart, yEnd,   0);
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset - nWindowHeight, 0);
  vertex(xStart + xWindowOffset + nWindowWidth, yEnd - yWindowOffset - nWindowHeight, 0);
  vertex(xEnd,   yStart, 0);
  endShape(CLOSE);

  beginShape();
  vertex(xEnd,   yEnd,   0);
  vertex(xStart, yEnd,   0);
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset + nWindowWidth, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset + nWindowWidth, yEnd - yWindowOffset - nWindowHeight, 0);
  vertex(xEnd,   yStart,   0);
  endShape(CLOSE);

  popStyle();

  pushStyle();
  noFill();
  
  beginShape();
  vertex(xStart, yStart, 0);
  vertex(xStart, yEnd,   0);
  vertex(xEnd,   yEnd,   0);
  vertex(xEnd,   yStart, 0);
  endShape(CLOSE);

  beginShape();
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset + nWindowWidth, yEnd - yWindowOffset, 0);
  vertex(xStart + xWindowOffset + nWindowWidth, yEnd - yWindowOffset - nWindowHeight, 0);
  vertex(xStart + xWindowOffset, yEnd - yWindowOffset - nWindowHeight, 0);
  endShape(CLOSE);

  popStyle();
}


