
class Box
{
  // To use this Box class, please set these four points to be vertices of the desired box, then call calc() followed by draw()
  // There is no need to make subsequent calls to calc() unless/until you change this set of points.
  PVector pt0 = new PVector(0,0,0); // We will translate such that pt0 becomes our origin
  PVector pt1 = new PVector(1,0,0); // We will rotate such that pt1 becomes our x-axis
  PVector pt2 = new PVector(0,1,0); // Once coerced to ensure it is normal to our x-axis, we will rotate such that pt2 becomes our y-axis
  PVector pt3 = new PVector(0,0,1); // And since the above fixes our z-axis too, we only require pt3 for its magnitude relative to pt0

  float xMag, yMag, zMag;

  // The finished values for points 2 and 3 are output here, since as discussed above, the ones input may be moved to satisfy the (right-angular) properties of a box.
  // Points 0 and 1 do not change, but are output for completeness.
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
    pt3_out.add(pt0);
    
    // Calculate z and y rotation in order to line up point 1 with the x-axis
    float zRotation = atan2(pt1_calc.y, pt1_calc.x);
    float xyHypotenuse = sqrt( (pt1_calc.x * pt1_calc.x) + (pt1_calc.y * pt1_calc.y) );
    float yRotation = -atan2(pt1_calc.z, xyHypotenuse);
    
    // Put what we have so far into our matrix
    PMatrix3D mx0 = new PMatrix3D();
    mx0.rotateZ(zRotation);
    mx0.rotateY(yRotation);
    
    // Apply to point 2
    PMatrix3D mx2 = mx0.get();
    PVector pt2_rot = new PVector();
    mx2.invert();
    mx2.mult(pt2_calc, pt2_rot);

    // Now rotate on the x-axis in order to line up point 2 on the y-axis.  And of course because it's the x-axis
    // that we're rotating this doesn't mess up the alignment of point 1 on the x-axis that we've already performed
    float xRotation = atan2(pt2_rot.z, pt2_rot.y);
    mx0.rotateX(xRotation);
    
    // Line us up with p0 rather than the centre of the box
    mx0.translate(xMag/2, yMag/2, zMag/2);

    // We've been using p0 as our origin, move us back to the actual origin
    mx = new PMatrix3D();
    mx.translate(pt0.x, pt0.y, pt0.z);
    mx.apply(mx0);
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


