
PVector pvDirection = new PVector(10, 30); 
PVector pvVelocity = new PVector(-140, 30);

void setup()
{
  size(300, 300);
  smooth();
}

void draw()
{
  strokeWeight(5);

  pushMatrix();
   
  translate(10, 10); 
  
  // Draw the vector we want to express our velocity in
  line(0, 0, pvDirection.x, pvDirection.y);
  translate(pvDirection.x, pvDirection.y);

  // Draw a vector at right angles to it
  PVector pvOrthogonal = new PVector(pvDirection.y, -pvDirection.x);
  line(0, 0, pvOrthogonal.x, -pvDirection.y);
  
  
  popMatrix();
  pushMatrix();
  
  translate(width/2, height/2);
   
  // Draw our velocity vector
  line(0, 0, pvVelocity.x, pvVelocity.y);
  
  strokeWeight(1);

  // Draw the velocity component in the desired direction
  PVector pvUnit = pvDirection.copy();
  pvUnit.normalize();
  
  float inDirection = dot(pvVelocity, pvUnit);
  PVector pvInDirection = PVector.mult(pvUnit, inDirection);

  line(0,0, pvInDirection.x, pvInDirection.y);
  translate(pvInDirection.x, pvInDirection.y);
  
  // Draw the velocity component in the orthogonal direction
  pvUnit = pvOrthogonal.copy();
  pvUnit.normalize();

  float orthogonalDirection = dot(pvVelocity, pvUnit);
  PVector pvOrthogonalDirection = PVector.mult(pvUnit, orthogonalDirection);

  line(0,0, pvOrthogonalDirection.x, pvOrthogonalDirection.y);

  popMatrix();
  noLoop();
}

//
// PVector can do it for me, but let's just check I can apply the formula for dot product myself
//

float dot(PVector a, PVector b)
{
  return (a.x*b.x) + (a.y*b.y);
}