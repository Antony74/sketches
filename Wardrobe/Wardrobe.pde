
final int PAGE_UP = 33;
final int PAGE_DOWN = 34;

float nDistance = 1000;
float nRotation = PI/10;
float nElevation = 300;

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
 }
}

void draw()
{
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), -nElevation, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  // The real work starts here
  
  box(200,300,400);
}


