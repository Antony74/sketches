//
// Configuration settings
//

String drawing1 = "drawing1.svg";
String drawing2 = "drawing2.svg";

int selectedStrokeColor = color(255,0,0);
int selectedFillColor = color(200,0,0);

// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

RShape shape1;
RShape shape2;

RShapeIterator itr1;
RShapeIterator itr2;

RStyle modifyStyleSelected(RStyle style)
{
  if (style.stroke)
  {
    style.strokeColor = selectedStrokeColor;
  }

  if (style.fill)
  {
    style.fillColor = selectedFillColor;
  }
  
  return style;
}

void setup()
{
  size(900,500);

  RG.init(this);

  RSVG svg = new RSVGIgnoreTagWarnings();
  shape1 = svg.toShape(drawing1);
  shape2 = svg.toShape(drawing2);

  itr1 = new RShapeIterator(shape1);
  itr2 = new RShapeIterator(shape2);
}

void draw()
{
  background(255);
  
  // first shape

  translate(0,100);
  smooth();
  drawShapeWithSelection(shape1, itr1);

  noSmooth();
  drawArrows(itr1);

  // second shape
  
  translate(500,0);

  smooth();
//  drawShapeWithSelection(shape2, shape2.getStyle());
  shape2.draw();

  noSmooth();
  drawArrows(itr2);
}

void keyPressed()
{
  switch(keyCode)
  {
  case UP:
    if (itr1.hasUp())
    {
      itr1.up();
    }
    break;
  case DOWN:
    if (itr1.hasDown())
    {
      itr1.down();
    }
    break;
  case LEFT:
    if (itr1.hasPrevious())
    {
      itr1.previous();
    }
    break;
  case RIGHT:
    if (itr1.hasNext())
    {
      itr1.next();
    }
    break;
  }
}

void drawShapeWithSelection(RShape shape, RShapeIterator itrSelected)
{
  drawShapeWithSelection(shape, shape.getStyle(), itrSelected, false);
  
  stroke(selectedStrokeColor);
  strokeWeight(10);
  RGeomElem elem = itrSelected.getCurrentElem();
  RPoint point = itrSelected.getCurrentPoint();
  
  if (elem != null)
  {
    switch(elem.getType())
    {
    case RGeomElem.SUBSHAPE:
    case RGeomElem.COMMAND:
      elem.draw();
      break;
    }
  }

  if (point != null)
  {
    rectMode(CENTER);
    rect(point.x, point.y, 5, 5);
  }
}

void drawShapeWithSelection(RShape shape, RStyle defaultStyle, RShapeIterator itrSelected, boolean bSelected)
{
  RStyle style = new RStyle(shape.getStyle());
  
  // Perform any style substitution needed - this code is not complete - only supports what I presently need

  if (style.fillDef == false)
  {
    style.fillDef = defaultStyle.fillDef;
    style.fill = defaultStyle.fill;
    style.fillColor = defaultStyle.fillColor;
  }
  
  if (style.strokeDef == false)
  {
    style.strokeDef = defaultStyle.strokeDef;
    style.stroke = defaultStyle.stroke;
    style.strokeColor = defaultStyle.strokeColor;

    if (style.strokeWeightDef == false)
    {
      style.strokeWeightDef = defaultStyle.strokeWeightDef;
      style.strokeWeight = defaultStyle.strokeWeight;
    }
  }

  // End of style substitution  
  
  if (shape.equals(itrSelected.getCurrentElem()))
  {
    bSelected = true;
  }
  
  if (bSelected)
  {
    modifyStyleSelected(style);
  }
  
  if (shape.children == null)
  {
    drawShapeWithStyle(shape, style);
  }
  else
  {
    for (int n = 0; n < shape.children.length; ++n)
    {
      drawShapeWithSelection(shape.children[n], style, itr1, bSelected); // recursion
    }
  }
}

void drawShapeWithStyle(RShape shape, RStyle style)
{
  RStyle shapeStyle = shape.getStyle();
  shape.setStyle(style);
  shape.draw();
  shape.setStyle(shapeStyle);  
}


