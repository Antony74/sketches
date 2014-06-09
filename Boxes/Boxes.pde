
float nDistance = 1000;
float nRotation = 0;

PVector ptA;

PVector getRandomPoint()
{
  return new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400)); 
}

void setup()
{
  size(900, 600, P3D);
  ptA = getRandomPoint();
}

void draw()
{
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), 0, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  fill(255, 0, 0, 128);
  noStroke();
  doVertex(new PVector(0, 0, 0));
  doVertex(ptA);

  float theta = atan2(ptA.y, ptA.x);
  float xyHypotenuse = sqrt( (ptA.x * ptA.x) + (ptA.y * ptA.y) );
  float phi = atan2(ptA.z, xyHypotenuse);

  noFill();
  stroke(0);

  pushMatrix();

//  doBox(ptA);

  rotateZ(theta);

//  doBox(ptA);

  rotateY(-phi);

  doBox(ptA);

  popMatrix();
}

void doVertex(PVector pt)
{
  pushMatrix();
 
  translate(pt.x, pt.y, pt.z);
  box(50);

  popMatrix();

//  if (pt.z != 0)
//  {
//    doVertex(new PVector(pt.x, pt.y, 0));
//  }
}

void doBox(PVector pt)
{
  pushMatrix();
  translate( pt.mag()/2, pt.mag()/2, pt.mag()/2);
  box(pt.mag());
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
    ptA = getRandomPoint();
  } 

  loop();
}


