
float nDistance = 1000;
float nRotation = 0;

Box oBox = new Box();

PVector getRandomPoint()
{
  return new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400)); 
}

void initRandomBox()
{
  oBox.pt0 = getRandomPoint();
  oBox.pt1 = getRandomPoint();
  oBox.pt2 = getRandomPoint();
  oBox.pt3 = getRandomPoint();

  oBox.calc();
}

void setup()
{
  size(900, 600, P3D);
  initRandomBox();
}

void draw()
{
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), 0, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  // Draw vertices
  noStroke();
  fill(128, 128);

  doVertex(oBox.pt0_out);
  doVertex(oBox.pt1_out);
  doVertex(oBox.pt2_out);
  doVertex(oBox.pt3_out);
  // Done drawing vertices

  stroke(0);
  noFill();

  oBox.draw();
}

void doVertex(PVector pt)
{
  pushMatrix();
 
  translate(pt.x, pt.y, pt.z);
  box(50);

  popMatrix();
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
  }

  if (key == ' ')
  {
    initRandomBox();
  } 
}


