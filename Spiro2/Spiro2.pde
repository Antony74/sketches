
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

import java.awt.geom.Point2D;

Slider sliderStatic;
Slider sliderDynamic;

PGraphics myGraphics;

PVector ptPenBase;
PVector ptPrevious;

float slideAmount = 3;

class Slider
{
  RPath path;
  int currentSegment;
  float segmentLength;
  float segmentPosition;
  float segmentCount;

  void setPath(RPath p)
  {
    path = p;
    currentSegment = 0;
    segmentLength = path.commands[0].getCurveLength();
    segmentPosition = 0;
    segmentCount = path.commands.length;
  }
  
  void slide(float amount)
  {
    segmentPosition += amount;
    
    while (segmentPosition > segmentLength)
    {
      ++currentSegment;
      if (currentSegment >= segmentCount)
        currentSegment = 0;
      
      segmentPosition -= segmentLength;
      segmentLength = path.commands[currentSegment].getCurveLength();
    }

    while (segmentPosition < 0)
    {
      --currentSegment;
      if (currentSegment < 0)
       currentSegment += segmentCount;
      
      segmentLength = path.commands[currentSegment].getCurveLength();
      segmentPosition += segmentLength; 
    }
  }
  
  float withinSegment()
  {
    return map(segmentPosition, 0, segmentLength, 0, 1);
  }
  
  RPoint getPoint()
  {
    return path.commands[currentSegment].getPoint(withinSegment());
  }

  RPoint getTangent()
  {
    return path.commands[currentSegment].getTangent(withinSegment());
  }
};

RPath getEllipse(float xCentre, float yCentre, float xRadius, float yRadius)
{
  float x1 = xCentre - xRadius;
  float x2 = xCentre - (xRadius/2);
  float x3 = xCentre;
  float x4 = xCentre + (xRadius/2);
  float x5 = xCentre + xRadius;
  float y1 = yCentre - yRadius;
  float y2 = yCentre - (yRadius/2);
  float y3 = yCentre;
  float y4 = yCentre + (yRadius/2);
  float y5 = yCentre + yRadius;

  RPath path = new RPath(x1, y3);  
  path.addBezierTo(x1, y2, x2, y1, x3, y1);
  path.addBezierTo(x4, y1, x5, y2, x5, y3);
  path.addBezierTo(x5, y4, x4, y5, x3, y5);
  path.addBezierTo(x2, y5, x1, y4, x1, y3);

  return path;
}

void setup()
{
  size(900,600);
  background(255);

  RG.init(this);

  sliderStatic = new Slider();
  sliderDynamic = new Slider();

  sliderStatic.setPath(getEllipse(width/2,height/2,270,270));
  sliderDynamic.setPath(getEllipse(0,0,80,120));
  ptPenBase = new PVector(0, 110);
  
  noFill();

  myGraphics = createGraphics(width, height);
  myGraphics.beginDraw();
  myGraphics.background(128);
  myGraphics.endDraw();
}

void draw()
{
  image(myGraphics, 0, 0);

  myGraphics.beginDraw();
  
  sliderStatic.slide(slideAmount);
  sliderDynamic.slide(slideAmount);

  sliderStatic.path.draw(this);

  RPoint rp1, rp2, rp3, rp4;

  rp1 = sliderStatic.getPoint();
  rp2 = sliderStatic.getTangent();
  rp3 = sliderDynamic.getPoint();
  rp4 = sliderDynamic.getTangent();

  // Draw the pivot point
  ellipse(rp1.x, rp1.y, 10, 10);
  
  // Draw a tangent
//  line(rp1.x, rp1.y, rp1.x + rp2.x, rp1.y + rp2.y);

  translate(rp1.x, rp1.y);

  float angle = atan2(rp2.y, rp2.x) - atan2(rp4.y, rp4.x);
  rotate(angle);

  translate(-rp3.x, -rp3.y);

  sliderDynamic.path.draw(this);

  PGraphicsJava2D pg = (PGraphicsJava2D)g;
  Point2D ptOut = new Point2D.Float();
  
  pg.g2.getTransform().transform(new Point2D.Float(ptPenBase.x, ptPenBase.y), ptOut);

  myGraphics.stroke(150, 0, 150);
  
  PVector pt = new PVector((float)ptOut.getX(), (float)ptOut.getY());

  if (ptPrevious != null)
  {
    myGraphics.line(ptPrevious.x, ptPrevious.y, pt.x, pt.y);
  }

  ptPrevious = pt;
  
  myGraphics.endDraw();
}

void mousePressed()
{
  if (mouseButton == LEFT)
    ++slideAmount;
  else
    --slideAmount;
}


