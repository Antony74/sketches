
PVector ptStart;
PVector ptEnd;
PVector ptArc1;
PVector ptArc2;

PVector pt[] = new PVector[4];

float rect_radius = 10;

int drag = 999;

void setup()
{
  size(600, 600);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  
  ptStart = new PVector(250,  50);
  ptEnd =   new PVector(500, 500);
  ptArc1 =  new PVector(150, 500);
  ptArc2 =  new PVector(200, 300);

  pt[0] = ptStart;
  pt[1] = ptEnd;
  pt[2] = ptArc1;
  pt[3] = ptArc2;
  
  drawCrescent();
}

void draw()
{
  // we draw when needed, rather than constantly
}

void drawCrescent()
{
  background(255);

  stroke(0);
  noFill();
  arc_pv(ptStart, ptEnd, ptArc1);
  arc_pv(ptStart, ptEnd, ptArc2);
  
  noStroke();
  fill(255, 0, 0, 128);
  
  for (int n = 0; n < pt.length; ++n)
  {
    PVector v = pt[n];
    rect(v.x, v.y, rect_radius, rect_radius);
  }
}

float getHeading(PVector pt1, PVector pt2)
{
  PVector pv = pt1.get();
  pv.sub(pt2);
  return pv.heading2D();
}

void arc_pv(PVector ptStart, PVector ptEnd, PVector ptArc)
{
  PVector ptRadial1 = new PVector();
  PVector ptRadial2 = new PVector();
  PVector ptRadial3 = new PVector();
  PVector ptRadial4 = new PVector();

  bisect(ptStart, ptEnd, ptRadial1, ptRadial2);  
  bisect(ptStart, ptArc, ptRadial3, ptRadial4);  

  PVector ptCentre = intersect_pv(ptRadial1, ptRadial2, ptRadial3, ptRadial4);

  if (ptCentre != null)
  {
    float radius = PVector.dist(ptCentre, ptStart);
    float headingStart = getHeading(ptStart, ptCentre);
    float headingArc = getHeading(ptArc, ptCentre);
    float headingEnd = getHeading(ptEnd, ptCentre);
    
    if (headingStart <= headingArc && headingArc <= headingEnd)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingStart, headingEnd);
    }
    else if (headingStart <= headingEnd && headingEnd <= headingArc)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingEnd, headingStart + TWO_PI);
    }
    else if (headingArc <= headingStart && headingStart <= headingEnd)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingEnd - TWO_PI, headingStart);
    }
    else if (headingArc <= headingEnd && headingEnd <= headingStart)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingStart - TWO_PI, headingEnd);
    }
    else if (headingEnd <= headingStart && headingStart <= headingArc)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingStart, headingEnd + TWO_PI);
    }
    else if (headingEnd <= headingArc && headingArc <= headingStart)
    {
      arc(ptCentre.x, ptCentre.y, radius, radius, headingEnd, headingStart);
    }
    else
    {
      String s = new Float(headingStart).toString() + ", " + new Float(headingArc).toString() + ", " + new Float(headingEnd).toString();
      throw new RuntimeException(s);
    }
  }
}

void mousePressed()
{
  for (int n = 0; n < pt.length; ++n)
  {
    PVector v = pt[n];
    if (abs(mouseX - v.x) <= rect_radius && abs(mouseY - v.y) <= rect_radius)
    {
      drag = n;
      return;
    }
  }
  
  drag = 999;
}

void mouseDragged()
{
  if (drag < pt.length)
  {
    pt[drag].x = mouseX;
    pt[drag].y = mouseY;
    
    drawCrescent();
  }
}

void bisect(PVector pt1, PVector pt2, PVector pt3, PVector pt4)
{
  PVector pv12 = pt2.get();
  pv12.sub(pt1);
  PVector pv34 = new PVector(-pv12.y, pv12.x);
  pv12.mult(0.5);
  pt3.set(PVector.add(pt1, pv12));
  pt4.set(PVector.add(pt3, pv34));
}

PVector intersect_pv(PVector pt1, PVector pt2, PVector pt3, PVector pt4)
{
  return intersect(pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y, pt4.x, pt4.y);
}

PVector intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
{
  float nDenom = ((x1-x2)*(y3-y4)) - ((y1-y2)*(x3-x4));
  if (nDenom == 0.0)
  {
    // Lines are parallel
    return null;
  }
  else
  {
    // Lines are not parallel, therefore there is a single point of intersection to be found,
    float xNum = (((x1*y2)-(y1*x2))*(x3-x4)) - ((x1-x2)*((x3*y4)-(y3*x4)));
    float yNum = (((x1*y2)-(y1*x2))*(y3-y4)) - ((y1-y2)*((x3*y4)-(y3*x4)));
    float x = xNum / nDenom;
    float y = yNum / nDenom;

    return new PVector(x,y);    
  }
}



