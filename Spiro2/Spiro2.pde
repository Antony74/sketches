
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

import java.awt.geom.Point2D;

Slider sliderStatic;  // Represents the shape that moves
Slider sliderDynamic; // Represents the shape that stays still

PGraphics myGraphics;

PVector ptPenBase;
PVector ptPrevious;

float slideAmount = 3;

// Approximate an ellipse using bezier curves
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

void mousePressed()
{
  if (mouseButton == LEFT)
    ++slideAmount;
  else
    --slideAmount;
}


