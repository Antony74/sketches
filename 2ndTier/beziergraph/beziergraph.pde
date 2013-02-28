
void setup()
{
  size(600, 600);
  strokeWeight(5);
  stroke(200, 100, 0, 128);
  noFill();
  
  translate(200,200);
  
  ArrayList<Bezier> arr = new ArrayList<Bezier>();
  
  Bezier b = new Bezier();
  b.p1 = new PVector(0, 0);
  b.cp1 = new PVector(190, 190);
  b.p2 = new PVector(200, 60);
  PMatrix2D matrix = b.init(radians(100));

  arr.add(b);

  for (int n = 0; n < 17; ++n)
  {
    Bezier b2 = arr.get(n).multiply(matrix);
    arr.add(b2);
  }

  beginShape();
  vertex(b.p1.x, b.p1.y);
  for (int n = 0; n < arr.size(); ++n)
  {
    Bezier b3 = arr.get(n);
    bezierVertex(b3.cp1.x, b3.cp1.y, b3.cp2.x, b3.cp2.y, b3.p2.x, b3.p2.y);
  }
  endShape();
}

class Bezier
{
  PVector p1;
  PVector cp1;
  PVector cp2;
  PVector p2;
  
  PMatrix2D init(float angle)
  {
    PMatrix2D matrix = new PMatrix2D();
    matrix.translate(p2.x - p1.x, p2.y - p1.y);
    matrix.rotate(angle);

    PVector controlPoint = new PVector();
    controlPoint.x = p1.x - (cp1.x - p1.x);
    controlPoint.y = p1.y - (cp1.y - p1.y);
    cp2 = matrix.mult(controlPoint, cp2);

    return matrix;
  }
  
  Bezier multiply(PMatrix2D matrix)
  {
    Bezier b = new Bezier();
    b.p1 = matrix.mult(p1,  b.p1);
    b.cp1 = matrix.mult(cp1, b.cp1);
    b.cp2 = matrix.mult(cp2, b.cp2);
    b.p2 = matrix.mult(p2,  b.p2);
    return b;
  }

};


