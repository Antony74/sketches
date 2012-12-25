
class Rectangle
{
  float xMin;
  float yMin;
  float xMax;
  float yMax;

  Rectangle() {}
  
  Rectangle(float x1, float y1, float x2, float y2)
  {
    xMin = x1;
    yMin = y1;
    xMax = x2;
    yMax = y2;
  }

  void normalise()
  {
    if (xMin > xMax)
    {
      float nSwap = xMin;
      xMin = xMax;
      xMax = nSwap;
    }

    if (yMin > yMax)
    {
      float nSwap = yMin;
      yMin = yMax;
      yMax = nSwap;
    }
  }
  
  boolean intersects(Rectangle other)
  {
    if (xMax < other.xMin
    ||  yMax < other.yMin
    ||  xMin > other.xMax
    ||  yMin > other.yMax)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
  
  boolean containsPoint(float x, float y)
  {
    if (xMax < x
    ||  yMax < y
    ||  xMin > x
    ||  yMin > y)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
  
  float width()
  {
    return xMax - xMin;
  }
  
  float height()
  {
    return yMax - yMin;
  }

};

class Triangle
{
  Triangle() {}
  Triangle(int nx1, int ny1, int nx2, int ny2, int nx3, int ny3)
  {
    x1 = nx1; y1 = ny1;
    x2 = nx2; y2 = ny2;
    x3 = nx3; y3 = ny3;
  }
  
  int x1;
  int y1;
  int x2;
  int y2;
  int x3;
  int y3;
  int nRed;
  int nGreen;
  int nBlue;
  
  Rectangle getBounds()
  {
    Rectangle rect = new Rectangle();
    rect.xMin = min(x1,x2,x3);
    rect.xMax = max(x1,x2,x3);
    rect.yMin = min(y1,y2,y3);
    rect.yMax = max(y1,y2,y3);
    return rect;
  }

  boolean containsPoint(int x, int y)
  {
    Triangle tri1 = new Triangle(x1, y1, x2, y2, x, y);
    Triangle tri2 = new Triangle(x2, y2, x3, y3, x, y);
    Triangle tri3 = new Triangle(x3, y3, x1, y1, x, y);

    if (twice_area() == (tri1.twice_area() + tri2.twice_area() + tri3.twice_area()))
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  int twice_area()
  {
    return abs( ((x1*(y2-y3)) + (x2*(y3-y1)) + (x3*(y1-y2))) );
  }
  
  Triangle getTranslation(int x, int y)
  {
    Triangle tri = new Triangle();
    tri.x1 = x1 - x;
    tri.y1 = y1 - y;
    tri.x2 = x2 - x;
    tri.y2 = y2 - y;
    tri.x3 = x3 - x;
    tri.y3 = y3 - y;
    return tri;
  }
};

class Polygon
{
  ArrayList<PVector> arrVertices;

  Polygon()
  {
    arrVertices = new ArrayList<PVector>();
  }
  
  Polygon(int initialCapacity)
  {
    arrVertices = new ArrayList<PVector>(initialCapacity);
  }

  void add(float x, float y)
  {
    arrVertices.add(new PVector(x,y));
  }

  boolean getIntersection(Polygon other, PVector ptIntersection)
  {
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      PVector pt1 = arrVertices.get(n);
      PVector pt2 = arrVertices.get( (n+1) % arrVertices.size() );

      for (int m = 0; m < other.arrVertices.size(); ++m)
      {
        PVector pt3 = other.arrVertices.get(m);
        PVector pt4 = other.arrVertices.get( (m+1) % other.arrVertices.size() );
        
        boolean brc = getIntersection(pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y, pt4.x, pt4.y, ptIntersection);

        if (brc)
        {
          return true;
        }
      }
    }

    return false;
  }

  boolean getIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, PVector pt)
  {
    float nDenom = ((x1-x2)*(y3-y4)) - ((y1-y2)*(x3-x4));
    if (nDenom == 0)
    {
      // Lines are parallel.  We will already have any points that may be relevant
    }
    else
    {
      // Lines are not parallel, therefore there is a single point of intersection to be found,
      // although it may or may not lie within the line-segments.
      float xNum = (((x1*y2)-(y1*x2))*(x3-x4)) - ((x1-x2)*((x3*y4)-(y3*x4)));
      float yNum = (((x1*y2)-(y1*x2))*(y3-y4)) - ((y1-y2)*((x3*y4)-(y3*x4)));
      float x = xNum/nDenom;
      float y = yNum/nDenom;
      
      Rectangle rect12 = new Rectangle(x1,y1,x2,y2);
      rect12.normalise();
      Rectangle rect34 = new Rectangle(x3,y3,x4,y4);
      rect34.normalise();

      if (rect12.containsPoint(x,y) && rect34.containsPoint(x,y))
      {
          pt.x = x;
          pt.y = y;
          return true;
      }
    }

    return false;
  }

  void draw()
  {
    beginShape();
  
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      vertex(arrVertices.get(n).x, arrVertices.get(n).y);
    }
  
    endShape(CLOSE);
  }
  
  Polygon transform(PVector translate, PVector pivot, float rotate)
  {
    Polygon poly = new Polygon(arrVertices.size());
    
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      PVector pt = arrVertices.get(n);
      float x = pt.x + translate.x;
      float y = pt.y + translate.y;
      
      if (pivot != null)
      {
        x -= pivot.x;
        y -= pivot.y;

        float hypotenuse = dist(0, 0, x, y);
        float angle = atan2(y, x);
        angle += rotate;
        x = hypotenuse * cos(angle);
        y = hypotenuse * sin(angle);
        
        x += pivot.x;
        y += pivot.y;
      }
      
      poly.add(x, y);
    }
    
    return poly;
  }

  void transformPt(PVector translate, PVector pivot, float rotate, PVector pt)
  {
      float x = pt.x + translate.x;
      float y = pt.y + translate.y;
      
      if (pivot != null)
      {
        x -= pivot.x;
        y -= pivot.y;

        float hypotenuse = dist(0, 0, x, y);
        float angle = atan2(y, x);
        angle += rotate;
        x = hypotenuse * cos(angle);
        y = hypotenuse * sin(angle);
        
        x += pivot.x;
        y += pivot.y;
      }

      pt.x = x;
      pt.y = y;
  }

};


