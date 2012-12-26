import java.util.Set;
import java.util.TreeSet;

class BaseTriangle extends Triangle
{
  void calculate(int xPosition, int yPosition)
  {
    float ang1 = ((TWO_PI * 0) / 3) - HALF_PI;
    float ang2 = ((TWO_PI * 1) / 3) - HALF_PI;
    float ang3 = ((TWO_PI * 2) / 3) - HALF_PI;
    x1 = xPosition + (int)(nRadius * cos(ang1));
    y1 = yPosition + (int)(nRadius * sin(ang1));
    x2 = xPosition + (int)(nRadius * cos(ang2));
    y2 = yPosition + (int)(nRadius * sin(ang2));
    x3 = xPosition + (int)(nRadius * cos(ang3));
    y3 = yPosition + (int)(nRadius * sin(ang3));
  }
  
    int nRadius = 100;
};

class KaleidoscopeClip implements IFilter
{
  IFilter filterNext;
  BaseTriangle base;
  
  KaleidoscopeClip(IFilter next, BaseTriangle baseTriangle)
  {
    filterNext = next;
    base = baseTriangle;
  }
    
  void triangle(int x1, int y1, int x2, int y2, int x3, int y3)
  {
    Triangle tri = new Triangle();
    tri.x1 = x1; tri.y1 = y1;
    tri.x2 = x2; tri.y2 = y2;
    tri.x3 = x3; tri.y3 = y3;
    triangle(tri);
  }
  
  void triangle(Triangle tri)
  {
    if (tri.getBounds().intersects(base.getBounds()))
    {
      Set<Point> points = new TreeSet<Point>();

      if(tri.containsPoint(base.x1, base.y1))
        points.add(new Point(base.x1, base.y1));

      if(tri.containsPoint(base.x2,base.y2))
        points.add(new Point(base.x2, base.y2));

      if(tri.containsPoint(base.x3,base.y3))
        points.add(new Point(base.x3, base.y3));

      if(base.containsPoint(tri.x1,tri.y1))
        points.add(new Point(tri.x1, tri.y1));

      if(base.containsPoint(tri.x2,tri.y2))
        points.add(new Point(tri.x2, tri.y2));

      if(base.containsPoint(tri.x3,tri.y3))
        points.add(new Point(tri.x3, tri.y3));

      getIntersection(tri.x1, tri.y1, tri.x2, tri.y2, base.x1, base.y1, base.x2, base.y2, points);
      getIntersection(tri.x1, tri.y1, tri.x2, tri.y2, base.x2, base.y2, base.x3, base.y3, points);
      getIntersection(tri.x1, tri.y1, tri.x2, tri.y2, base.x3, base.y3, base.x1, base.y1, points);
      getIntersection(tri.x2, tri.y2, tri.x3, tri.y3, base.x1, base.y1, base.x2, base.y2, points);
      getIntersection(tri.x2, tri.y2, tri.x3, tri.y3, base.x2, base.y2, base.x3, base.y3, points);
      getIntersection(tri.x2, tri.y2, tri.x3, tri.y3, base.x3, base.y3, base.x1, base.y1, points);
      getIntersection(tri.x3, tri.y3, tri.x1, tri.y1, base.x1, base.y1, base.x2, base.y2, points);
      getIntersection(tri.x3, tri.y3, tri.x1, tri.y1, base.x2, base.y2, base.x3, base.y3, points);
      getIntersection(tri.x3, tri.y3, tri.x1, tri.y1, base.x3, base.y3, base.x1, base.y1, points);

      if (points.size() > 0)
      {
        Point hull[] = findHull(points.toArray(new Point[0]));

        if (hull.length >= 3)
        {
          for (int n = 2; n < hull.length; ++n)
          {
            filterNext.triangle(hull[n].x, hull[n].y, hull[n-1].x, hull[n-1].y, hull[0].x, hull[0].y);
          }
        }
      }
    }  
  }

  void getIntersection(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, Set<Point> points)
  {
    int nDenom = ((x1-x2)*(y3-y4)) - ((y1-y2)*(x3-x4));
    if (nDenom == 0)
    {
      // Lines are parallel.  We will already have any points that may be relevant
    }
    else
    {
      // Lines are not parallel, therefore there is a single point of intersection to be found,
      // although it may or may not lie within the line-segments.
      int xNum = (((x1*y2)-(y1*x2))*(x3-x4)) - ((x1-x2)*((x3*y4)-(y3*x4)));
      int yNum = (((x1*y2)-(y1*x2))*(y3-y4)) - ((y1-y2)*((x3*y4)-(y3*x4)));
      int x = (int)((double)xNum/(double)nDenom);
      int y = (int)((double)yNum/(double)nDenom);
      
      Rectangle rect12 = new Rectangle(x1,y1,x2,y2);
      rect12.normalise();
      Rectangle rect34 = new Rectangle(x3,y3,x4,y4);
      rect34.normalise();

      if (rect12.containsPoint(x,y) && rect34.containsPoint(x,y))
      {
          Point pt = new Point(x,y);
          points.add(pt);
      }
    }
  }
};

class KaleidoscopeMirror implements IFilter
{
  IFilter filterNext;
  BaseTriangle base;
  
  KaleidoscopeMirror(IFilter next, BaseTriangle baseTriangle)
  {
    filterNext = next;
    base = baseTriangle;
  }
    
  void triangle(int x1, int y1, int x2, int y2, int x3, int y3)
  {
    Triangle tri = new Triangle();
    tri.x1 = x1; tri.y1 = y1;
    tri.x2 = x2; tri.y2 = y2;
    tri.x3 = x3; tri.y3 = y3;
    triangle(tri);
  }
  
  // I suspect this could be tidier
  void triangle(Triangle tri)
  {
    Rectangle bounds = base.getBounds();
    int nWidth = bounds.width();
    int nHeight = bounds.height();

    pushMatrix();
    int xAdjust = base.x1 % (nWidth * 3);
    int yAdjust = base.y1 % (nHeight * 2);
    translate(xAdjust - base.x1, yAdjust - base.y1 - (nHeight/2));

    int nDirection = 1;
    for (int nCol = -2; nCol < width/nWidth; ++nCol)
    {
      int x = nWidth * nCol * 3/2;

      pushMatrix();
      translate(x,0);
      
      for (int y = -nHeight; y < height + (nHeight*2); y += (nHeight*2))
      {
        pushMatrix();
        translate(0,y + (nDirection*nHeight/2));
        triangleTranslation(tri, base);
        popMatrix();
      }
      
      popMatrix();
      nDirection *= -1;
    }
    popMatrix();
  }

  // I suspect this could be tidier
  void triangleTranslation(Triangle tri, Triangle triBase)
  {
    Rectangle bounds = base.getBounds();
    int nWidth = bounds.width();
    int nHeight = bounds.height();

    pushMatrix();
    translate(triBase.x1, triBase.y1);

    Triangle tri2 = tri.getTranslation(triBase.x1, triBase.y1);

    triangleHex(tri2);

    popMatrix();
  }
  
  void triangleHex(Triangle triOrig)
  {
    int nDirection = 1;
    
    for (float ang = 0; ang < TWO_PI; ang += THIRD_PI)
    {
      pushMatrix();
      
      rotate(ang);
      
      Triangle tri = new Triangle();
      
      tri.x1 = triOrig.x1 * nDirection;
      tri.y1 = triOrig.y1;
      
      tri.x2 = triOrig.x2 * nDirection;
      tri.y2 = triOrig.y2;

      tri.x3 = triOrig.x3 * nDirection;
      tri.y3 = triOrig.y3;

      filterNext.triangle(tri);
      
      popMatrix();

      nDirection *= -1;
    }
  }
  
};


