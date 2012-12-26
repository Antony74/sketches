//
// CurveToBezier - converts Processing's curve vertices (Catmull-Rom curves) into Beziers,
// so that they can be saved as SVG.  The class should be re-usable.  The rest is proof of concept.
//
// Click to add a vertex (you'll want to add at least four).
// Press s to save as SVG.
// Hold any other key to see the Catmull-Rom visualisation instead of the Bezier visualisation
// (they're almost identical).
//
// Thanks to quarks and therealpomax.
// http://forum.processing.org/topic/convert-between-curvevertex-and-beziervertex
//

// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

Vector<PVector> points = new Vector<PVector>();
CurveToBezier c2b = new CurveToBezier();

void setup()
{
  size(900,600);
  RG.init(this);
  rectMode(CENTER);
}

void draw()
{
  background(128);

  if (keyPressed)
  {
    // Draw using Catmull-Rom
    noFill();
    stroke(0,0,255);
  
    beginShape();
    for (int n = 0; n < points.size(); ++n)
    {
      curveVertex(points.get(n).x, points.get(n).y);
    }
    endShape();
  }
  else
  {
    // Draw using the Beziers stored in our geomerative.RPath object
    noFill();
    stroke(0);
    c2b.path.draw();
  }

  // Draw vertices
  fill(255,0,0);
  noStroke();

  for (int n = 0; n < points.size(); ++n)
  {
    rect(points.get(n).x, points.get(n).y, 10, 10);
  }
}

void mousePressed()
{
  PVector pt = new PVector(mouseX, mouseY);
  points.add(pt);
  
  c2b.curveVertex(pt.x, pt.y);  
}

void keyPressed()
{
  if (key == 's') // Save
  {
    RStyle style = new RStyle();
    style.setFill(false);
    style.setStroke(color(0));

    RShape shape = new RShape(c2b.path);
    shape.setStyle(style);
    RG.saveShape("output.svg", shape);    
  }
}

//
// CurveToBezier
//
class CurveToBezier
{
  CurveToBezier()
  {
    ring[0] = new PVector();
    ring[1] = new PVector();
    ring[2] = new PVector();
    ring[3] = new PVector();
  }
  
  void curveVertex(float x, float y)
  {
    ring[count % 4].x = x;
    ring[count % 4].y = y;

    if (count >= 3)
    {
      makeBezierZero(ring[(count-3)%4], ring[(count-2)%4], ring[(count-1)%4], ring[count%4]);
    }
    else if (count == 1)
    {
      path.lastPoint.x = x;
      path.lastPoint.y = y;
    }

    ++count;
  }
  
  private void makeBezierZero(PVector c0, PVector c1, PVector c2, PVector c3)
  {
    PVector b1 = new PVector(0,0);
    PVector b2 = new PVector(0,0);
    
    b1.add(c2);
    b1.sub(c0);
    b1.add(PVector.mult(c1, 6));
    b1.div(6);
  
    b2.add(c1);
    b2.sub(c3);
    b2.add(PVector.mult(c2, 6));
    b2.div(6);
    
    path.addBezierTo(b1.x, b1.y, b2.x, b2.y, c2.x, c2.y);
  }

  RPath path = new RPath();
  private PVector ring[] = new PVector[4];
  private int count = 0;
}


