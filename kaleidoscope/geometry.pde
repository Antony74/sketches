
class Rectangle
{
  int xMin;
  int yMin;
  int xMax;
  int yMax;

  Rectangle() {}
  
  Rectangle(int x1, int y1, int x2, int y2)
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
      int nSwap = xMin;
      xMin = xMax;
      xMax = nSwap;
    }

    if (yMin > yMax)
    {
      int nSwap = yMin;
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
  
  boolean containsPoint(int x, int y)
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
  
  int width()
  {
    return xMax - xMin;
  }
  
  int height()
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


