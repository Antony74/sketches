
Polygon polyStatic = new Polygon();
Polygon polyDynamic = new Polygon();

PVector pivot;

void setup()
{
  size(900,600);

//  polyStatic.add(100,100);
//  polyStatic.add(300,500);
//  polyStatic.add(800,300);
//  polyStatic.add(700,200);

  for (float n = 0; n < TWO_PI; n += PI/6)
  {
    polyStatic.add(
                (width/2)  + (200 * cos(n)),
                (height/2) + (200 * sin(n)));
  }

  polyDynamic.add(500,250);
  polyDynamic.add(600,300);
  polyDynamic.add(550,350);
}

void draw()
{
  background(128, 128, 128);
  
//  PVector prevTranslate = new PVector(translate.x, translate.y);
//  float prevRotate = rotate;
  PVector pt = new PVector();
  Polygon poly;

  if (pivot == null)
  {
    poly = polyDynamic.transform(new PVector(0, 0.2), null, 0);
  }
  else
  {
    poly = polyDynamic.transform(new PVector(0, 0), pivot, 0.005);
  }
 
  boolean brc = poly.getIntersection(polyStatic, pt);

  if (brc && (pivot == null || dist(pivot.x, pivot.y, pt.x, pt.y) > 0.1))
  {
    // Push the new pivot point back to it's previous location, so the polygons are always just shy of making contact
    if (pivot == null)
    {
//      polyDynamic.transformPt(new PVector(0, -0.2), pivot, 0, pt);
    }
    else
    {
//      polyDynamic.transformPt(new PVector(0, 0), pivot, -0.005, pt);
    }

//    translate = prevTranslate;

    if (pivot != null)
    {
//      rotate += atan2(pivot.y, pivot.x);
//      rotate -= atan2(pt.y, pt.x);
      // Compensate for the change in pivot
      float xAdjust = pivot.x - pt.x;
      float yAdjust = pivot.y - pt.y;

//      polyDynamic = polyDynamic.transform(new PVector(-xAdjust, -yAdjust), null, 0);

//      translate.x -= xAdjust;
//      translate.y -= yAdjust;
      
      // Which ironically also means we have to change the new pivot to compensate for change in translate values
//      pt.x -= xAdjust;
//      pt.y -= yAdjust;
    }
  
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


