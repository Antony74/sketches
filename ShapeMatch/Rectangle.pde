
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

