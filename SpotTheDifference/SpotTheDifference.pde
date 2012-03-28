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
  background(255);
  smooth();

  RG.init(this);

  RSVG svg = new RSVGIgnoreTagWarnings();
  shape1 = svg.toShape(drawing1);
  shape2 = svg.toShape(drawing2);

  itr1 = new RShapeIterator(shape1);
  itr2 = new RShapeIterator(shape2);
}

void draw()
{
  translate(0,100);
  drawShapeWithSelection(shape1, shape1.getStyle(), itr1);
//  shape1.draw();

/*
  RGeomElem elem1 = itr1.getCurrentElem();
  RStyle normalStyle1 = elem1.getStyle();
  RStyle selectedStyle1 = modifyStyleSelected(new RStyle(normalStyle1));
  elem1.setStyle(selectedStyle1);
  elem1.draw();
  elem1.setStyle(normalStyle1);
*/
  
  translate(500,0);
//  drawShapeWithSelection(shape2, shape2.getStyle());
  shape2.draw();

  noLoop();
}

void keyPressed()
{
  switch(keyCode)
  {
  case UP:
    if (itr1.hasUp())
    {
      itr1.up();
      println("up");
    }
    break;
  case DOWN:
    if (itr1.hasDown())
    {
      itr1.down();
      println("down");
    }
    break;
  case LEFT:
    if (itr1.hasPrevious())
    {
      itr1.previous();
      println("left");
    }
    break;
  case RIGHT:
    if (itr1.hasNext())
    {
      itr1.next();
      println("right");
    }
    break;
  }
  
  loop();
}

void drawShapeWithSelection(RShape shape, RStyle defaultStyle, RShapeIterator itrSelected)
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
  
  if (itrSelected.getCurrentElem().equals(shape))
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
      drawShapeWithSelection(shape.children[n], style, itr1); // recursion
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


