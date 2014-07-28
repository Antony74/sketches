
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

  fill(255, 255, 255, 128);

  drawRoom();

  dombas.draw();
}

void drawRoom()
{
  // Let's look somewhere roughly central
  translate(xStart + xEnd / -2.0, -yEaves * 1.3, 0);

  backWall.draw();
  rightWall.draw();
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

  bathroomDoor.draw();
  popMatrix();

  // Move the y-axis onto the eaves in order to draw them
  pushMatrix();
  translate(0, yEaves, 0);
  rotateX(0.75 * PI);  

  eaves.draw();

  popMatrix();

}


