
float nDistance = 1000;
float nRotation = 0;

PVector pt0 = new PVector(0, 0, 0);
PVector pt1, pt2, pt3;

PVector getRandomPoint()
{
  return new PVector(random(-400, 400),   random(-400, 400),   random(-400, 400)); 
}

void setup()
{
  size(900, 600, P3D);
  pt1 = getRandomPoint();
  pt2 = getRandomPoint();
  pt3 = getRandomPoint();
}

class Box
{
  // To use this Box class, please set these four points to be vertices of the desired box, then call calc() followed by draw()
  // There is no need to make subsequent calls to calc() until this set of points changes
  PVector pt0 = new PVector(0,0,0); // We will translate such that pt0 becomes our origin
  PVector pt1 = new PVector(1,0,0); // We will rotate such that pt1 becomes our x-axis
  PVector pt2 = new PVector(0,1,0); // Once coerced to ensure it is normal to our x-axis, we will rotate such that pt2 becomes our y-axis
  PVector pt3 = new PVector(0,0,1); // And since the above fixes our z-axis too, we only require pt3 for its magnitude relative to pt0

  float xMag, yMag, zMag;

  // The finished values for points 2 and 3 are output here, since as discussed above, the ones input may be moved to satisfy the (right-angular) properties of a box
  // Points 0 and 1 do not change, but are output for completeness
  PVector pt0_out;
  PVector pt1_out;
  PVector pt2_out;
  PVector pt3_out;

  PMatrix3D mx;
  
  void calc()
  {
    // Copy point 0
    pt0_out = pt0.get();
    
    // Calculate point 1
    PVector pt1_calc = PVector.sub(pt1, pt0);
    xMag = pt1_calc.mag();
    pt1_out = pt1.get();

    // Calculate point 2
    PVector pvUnitX = pt1_calc.get();
    pvUnitX.normalize();
    PVector pt2_temp = PVector.sub(pt2, pt0);
    // This is where we project point 2 onto the plane through the origin normal to the x-axis
    PVector pt2_calc = PVector.sub(pt2_temp, PVector.mult(pvUnitX, pt2_temp.dot(pvUnitX)));
    yMag = pt2_calc.mag();
    pt2_out = PVector.add(pt2_calc, pt0);
    
    // Calculate point 3
    PVector pt3_temp = PVector.sub(pt3, pt0);
    zMag = pt3_temp.mag();
    pt3_out = pt1_calc.cross(pt2_calc);
    pt3_out.normalize();
    pt3_out.mult(zMag);
    
    // Calculate z and y rotation in order to line up point 1 with the x-axis
    float zRotation = atan2(pt1_calc.y, pt1_calc.x);
    float xyHypotenuse = sqrt( (pt1_calc.x * pt1_calc.x) + (pt1_calc.y * pt1_calc.y) );
    float yRotation = -atan2(pt1_calc.z, xyHypotenuse);
    
    // Put it into our matrix
    mx = new PMatrix3D();
    mx.translate(pt0.x, pt0.y, pt0.z);
    mx.rotateZ(zRotation);
    mx.rotateY(yRotation);
    
    // Apply to point 2
    PMatrix3D mx2 = mx.get();
    PVector pt2_rot = new PVector();
    mx2.invert();
    mx2.mult(pt2_calc, pt2_rot);

    // Now rotate on the x-axis in order to line up point 2 on the y-axis.  And of course because it's the x-axis
    // that we're rotating this doesn't mess up the alignment of point 1 on the x-axis that we've already performed
    float xRotation = atan2(pt2_rot.z, pt2_rot.y);
    mx.rotateX(xRotation);
    
    // Finally line us up with p0 rather than the centre of the box
    mx.translate(xMag/2, yMag/2, zMag/2);
  }

  void draw()
  {
    pushMatrix();

    applyMatrix(mx.m00, mx.m01, mx.m02, mx.m03,
                mx.m10, mx.m11, mx.m12, mx.m13,
                mx.m20, mx.m21, mx.m22, mx.m23,
                mx.m30, mx.m31, mx.m32, mx.m33);

    box(xMag, yMag, zMag);
    
    popMatrix();
  }

};

void draw()
{
  PMatrix3D hi = new PMatrix3D();

  // Boxes are exclusively right-angled, so project B onto the plane defined by the origin and the vector A  
  PVector pvUnitX = PVector.sub(pt1, pt0);
  pvUnitX.normalize();
  PVector pt2_proj = PVector.sub(pt2, PVector.mult(pvUnitX, PVector.sub(pt2, pt0).dot(pvUnitX)));
  
  background(0,0,128);
  lights();

  camera(nDistance * cos(nRotation), 0, nDistance * sin(nRotation),
         0, 0, 0,
         0, 1, 0);

  Box oBox = new Box();
  oBox.pt0 = pt0.get();
  oBox.pt1 = pt1.get();
  oBox.pt2 = pt2.get();
  oBox.pt3 = pt3.get();
  oBox.calc();

  // Draw vertices
  noStroke();
  fill(128, 128);

  doVertex(oBox.pt0);
  doVertex(oBox.pt1);
  doVertex(oBox.pt2_out);
  doVertex(oBox.pt3_out);
  // Done drawing vertices

  float zRotation = atan2(pt1.y, pt1.x);
  float xyHypotenuse = sqrt( (pt1.x * pt1.x) + (pt1.y * pt1.y) );
  float yRotation = -atan2(pt1.z, xyHypotenuse);

  noFill();
  stroke(0);

  oBox.draw();
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
    pt1 = getRandomPoint();
    pt2 = getRandomPoint();
    pt3 = getRandomPoint();
  } 

  loop();
}


