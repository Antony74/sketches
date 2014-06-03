
float nDistance = 1000;
float nRotation = 0;

PVector ptA = new PVector(0,   0,   0);
PVector ptB = new PVector(500, 0,   0);
PVector ptC = new PVector(0,   0, 400);
PVector ptD = new PVector(0,  300,  0);

void setup()
{
  size(900, 600, P3D);
}

void draw()
{
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), 0, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  doVertex(ptA);
  doVertex(ptB);
  doVertex(ptC);
  doVertex(ptD);
  
  PVector pvAB = ptB.get();
  pvAB.sub(ptA);

  PVector pvAC = ptC.get();
  pvAC.sub(ptA);

  PVector pvAD = ptD.get();
  pvAD.sub(ptA);

  PVector pvThirdDimension = pvAB.cross(pvAC);  // Find the perpendicular to the plane ABC
  PVector pvSecondDimension = pvAB.cross(pvThirdDimension); // And the perpendicular to that and AB
  // And the box's first dimension is just the vector AB
  
  pvThirdDimension.normalize();
  pvSecondDimension.normalize();

  float nFirstDimension = pvAB.mag();
  float nSecondDimension = abs(pvAC.dot(pvSecondDimension));
  float nThirdDimension = abs(pvAD.dot(pvThirdDimension));

  pushMatrix();
  stroke(0);
  noFill();

  translate(0.5 * nFirstDimension, 0.5 * nThirdDimension, 0.5 * nSecondDimension);
  box(nFirstDimension, nThirdDimension, nSecondDimension);
  popMatrix();
}

void doVertex(PVector pt)
{
  pushStyle();
  pushMatrix();

  noStroke();
  fill(255, 0, 0, 128);
  
  translate(pt.x, pt.y, pt.z);
  box(50);

  popMatrix();
  popStyle();
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

  loop();
}


