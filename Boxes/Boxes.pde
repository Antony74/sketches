
float nDistance = 1000;
float nRotation = 0;

PVector pt0 = new PVector(0, 0, 0);
PVector ptA, ptB;

PVector getRandomPoint()
{
  return new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400)); 
}

void setup()
{
  size(900, 600, P3D);
  ptA = getRandomPoint();
  ptB = getRandomPoint();
}

void draw()
{
  PMatrix3D hi = new PMatrix3D();

  // Boxes are exclusively right-angled, so project B onto the plane defined by the origin and the vector A  
  PVector pvN = PVector.sub(ptA, pt0);
  pvN.normalize();
  PVector ptB_proj = PVector.sub(ptB, PVector.mult(pvN, PVector.sub(ptB, pt0).dot(pvN)));
  
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), 0, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  // Draw vertices
  noStroke();
  fill(128, 128);

  doVertex(new PVector(0, 0, 0));
  doVertex(ptA);
  doVertex(ptB_proj);
  // Done drawing vertices

  float theta = atan2(ptA.y, ptA.x);
  float xyHypotenuse = sqrt( (ptA.x * ptA.x) + (ptA.y * ptA.y) );
  float phi = atan2(ptA.z, xyHypotenuse);

  noFill();
  stroke(0);

  pushMatrix();
  hi.rotateZ(theta);
  hi.rotateY(-phi);

  applyMatrix(hi.m00, hi.m01, hi.m02, hi.m03,
              hi.m10, hi.m11, hi.m12, hi.m13,
              hi.m20, hi.m21, hi.m22, hi.m23,
              hi.m30, hi.m31, hi.m32, hi.m33);

  hi.invert();

  PVector ptB_again = new PVector();
  hi.mult(ptB_proj, ptB_again);

  float angleB = atan2(ptB_again.z, ptB_again.y);

  rotateX(angleB);
  doBox(ptA.mag(), ptB_proj.mag(), 100);

  popMatrix();
 
}

void doVertex(PVector pt)
{
  pushMatrix();
 
  translate(pt.x, pt.y, pt.z);
  box(50);

  popMatrix();
}

void doBox(float x, float y, float z)
{
  pushMatrix();
  translate(x/2, y/2, z/2);
  box(x, y, z);
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


