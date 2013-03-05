
float dist(RPoint A, RPoint B)
{
  return dist(A.x, A.y, B.x, B.y);
}

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

class AssessShapeMatch
{
  float pointToLineDistance(RPoint P, RPoint A, RPoint B)
  {
   float distAB = dist(A, B);
   float distLine = abs((P.x - A.x) * (B.y - A.y) - (P.y - A.y) * (B.x - A.x)) / distAB;
   return distLine;
  }
  
  float pointToCommandDistance(RPoint P, RCommand cmd)
  {
    Rectangle rect = new Rectangle(cmd.startPoint.x, cmd.startPoint.y, cmd.endPoint.x, cmd.endPoint.y);
    rect.normalise();
    if (rect.containsPoint(P.x, P.y))
    {
      return pointToLineDistance(P, cmd.startPoint, cmd.endPoint);
    }
    else
    {
      float distAP = dist(cmd.startPoint, P);
      float distBP = dist(cmd.endPoint, P);
      return min(distAP, distBP);
    }
  }
  
  float pointToPolylineDistance(RPoint P, RPath polyline)
  {
    float least = pointToCommandDistance(P, polyline.commands[0]);
    for (int n = 1; n < polyline.commands.length; ++n)
    {
      float candidate = pointToCommandDistance(P, polyline.commands[n]);
      least = min(least, candidate);
    }
    return least;
  }
  
  float pointsToPolylineFitness(ArrayList<RPoint> arrTargetPoints, RPath polyline)
  {
    float fitness = 0;
    
    for (int n = 0; n < arrTargetPoints.size(); ++n)
    {
      RPoint P = arrTargetPoints.get(n);
      float distance = pointToPolylineDistance(P, polyline);
      
      fitness += (distance * distance);
    }
    
    fitness /= arrTargetPoints.size();
    return fitness;
  }

};


