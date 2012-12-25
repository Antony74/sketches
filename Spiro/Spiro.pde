
Polygon polyStatic = new Polygon();
Polygon polyDynamic = new Polygon();

PVector translate = new PVector(0,0);
float rotate = 0;

PVector pivot;

void setup()
{
  size(900,600);

  polyStatic.add(100,100);
  polyStatic.add(300,500);
  polyStatic.add(800,300);

  polyDynamic.add(500,250);
  polyDynamic.add(600,300);
  polyDynamic.add(550,350);
}

void draw()
{
  background(128, 128, 128);
  
  PVector prevTranslate = new PVector(translate.x, translate.y);
  float prevRotate = rotate;
  PVector pt = new PVector();

  if (pivot == null)
  {
    translate.y += 0.2;
  }
  else
  {
    rotate += 0.005;
  }

  Polygon poly = polyDynamic.transform(translate, pivot, rotate);
  
  boolean brc = poly.getIntersection(polyStatic, pt);

  if (brc)
  {
    // Push the new pivot point back to it's previous location, so the polygons are always just shy of making contact
    if (pivot == null)
    {
      polyDynamic.transformPt(new PVector(0, -0.2), pivot, 0, pt);
    }
    else
    {
      polyDynamic.transformPt(new PVector(0, 0), pivot, -0.005, pt);
    }

    translate = prevTranslate;

    if (pivot != null)
    {
      // Compensate for the change in pivot
//      translate.x -= pivot.x - pt.x;
//      translate.y -= pivot.y - pt.y;
    }
  
    pivot = pt;
  }

  polyStatic.draw();  
  poly.draw();  
}


