
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

  fill(255, 0, 0, 128);
  doVertex(ptA);

  fill(0, 255, 0, 128);
  doVertex(ptB);

  fill(255, 0, 0, 128);
  doVertex(ptC);

  fill(255, 0, 0, 128);
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

  translate(ptA.x, ptA.y, ptA.z);
  rotateZ(atan2(pvAB.y, pvAB.x));
  rotateX(atan2(pvAB.y, pvAB.z));

  drawAxes();

  translate(0.5 * nFirstDimension, 0.5 * nThirdDimension, 0.5 * nSecondDimension);
  box(nFirstDimension, nThirdDimension, nSecondDimension);
  popMatrix();
}

void doVertex(PVector pt)
{
  pushStyle();
  pushMatrix();

  noStroke();
  
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

  if (key == ' ')
  {
    ptA = new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400));
    ptB = new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400));
    ptC = new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400));
    ptD = new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400));
  } 

  loop();
}

void drawAxes()
{
  pushStyle();

  strokeWeight(5);

  stroke(255,0,0);
  line(0, 0, 0, 100, 0, 0);
  stroke(0,255,0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0,0,255);
  line(0, 0, 0, 0, 0, 100);

  popStyle();
}


