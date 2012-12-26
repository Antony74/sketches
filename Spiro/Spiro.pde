
SpiroPolygon polyStatic = new SpiroPolygon();
SpiroPolygon polyDynamic = new SpiroPolygon();

PVector pivot;

PGraphics myGraphics;

void setup()
{
  size(900,600);
  background(255);

  for (float n = 0; n < TWO_PI; n += PI/6)
  {
    polyStatic.add(
                (width/2)  + (270 * cos(n)),
                (height/2) + (270 * sin(n)));
  }

  polyDynamic.add(500,250);
  polyDynamic.add(600,300);
  polyDynamic.add(550,350);
  polyDynamic.setPen(510,260);

  noFill();

  myGraphics = createGraphics(width, height);
  myGraphics.beginDraw();
  myGraphics.background(128);
  myGraphics.endDraw();
}

void draw()
{
  image(myGraphics, 0, 0);

  if (pivot != null)
  {
    polyDynamic.drawPen(myGraphics);
  }
  
  PVector pt = new PVector();
  SpiroPolygon poly;

  if (pivot == null)
  {
    poly = polyDynamic.translate(0, 2);
  }
  else
  {
    poly = polyDynamic.rotate(pivot, 0.03);
  }
 
  boolean brc = poly.getIntersection(polyStatic, pt);

  if (brc && (pivot == null || dist(pivot.x, pivot.y, pt.x, pt.y) > 1))
  {
    pivot = pt;
  }
  else
  {
    polyDynamic = poly;
  }
  
  polyStatic.draw();  
  polyDynamic.draw();  

  if (pivot != null)
  {
    ellipse(pivot.x, pivot.y, 10, 10);
  }
}


