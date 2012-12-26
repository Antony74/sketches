class SpiroPolygon
{
  ArrayList<PVector> arrVertices;
  PVector currentPen;
  PVector prevPen;

  SpiroPolygon()
  {
    arrVertices = new ArrayList<PVector>();
  }

  void add(float x, float y)
  {
    arrVertices.add(new PVector(x,y));
  }

  void setPen(float x, float y)
  {
    if (currentPen == null)
    {
      currentPen = new PVector(x,y);
    }
    else
    {
      currentPen.x = x;
      currentPen.y = y;
    }
  }

  boolean getIntersection(SpiroPolygon other, PVector ptIntersection)
  {
    boolean bFound = false;
    
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      PVector pt1 = arrVertices.get(n);
      PVector pt2 = arrVertices.get( (n+1) % arrVertices.size() );

      for (int m = 0; m < other.arrVertices.size(); ++m)
      {
        PVector pt3 = other.arrVertices.get(m);
        PVector pt4 = other.arrVertices.get( (m+1) % other.arrVertices.size() );
        
        PVector pt = new PVector();
        boolean brc = getIntersection(pt1.x, pt1.y, pt2.x, pt2.y, pt3.x, pt3.y, pt4.x, pt4.y, pt);

        if (brc)
        {
          if (bFound == false || pivot == null || distVec(pivot, pt) > distVec(pivot, ptIntersection))
          {
            ptIntersection.x = pt.x;
            ptIntersection.y = pt.y;
            bFound = true;
          }
        }
      }
    }

    return bFound;
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
    stroke(0);
    
    beginShape();
  
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      vertex(arrVertices.get(n).x, arrVertices.get(n).y);
    }
  
    endShape(CLOSE);
  }

  void drawPen(PGraphics someGraphics)
  {
    someGraphics.beginDraw();
    someGraphics.stroke(150, 0, 150);
    
    if (prevPen == null && currentPen == null)
    {
      // can't draw
    }
    else if (prevPen == null)
    {
      someGraphics.point(currentPen.x, currentPen.y);
      
      prevPen = new PVector(currentPen.x, currentPen.y);
    }
    else
    {
      someGraphics.line(prevPen.x, prevPen.y, currentPen.x, currentPen.y);
      prevPen.x = currentPen.x;
      prevPen.y = currentPen.y;
    }
    someGraphics.endDraw();
  }

  SpiroPolygon translate(float x, float y)
  {
    return transform(new PVector(x,y), null, 0);
  }

  SpiroPolygon rotate(PVector pivot, float rotate)
  {
    return transform(new PVector(0,0), pivot, rotate);
  }
  
  SpiroPolygon transform(PVector translate, PVector pivot, float rotate)
  {
    SpiroPolygon poly = new SpiroPolygon();
    
    for (int n = 0; n < arrVertices.size(); ++n)
    {
      PVector pt = arrVertices.get(n);
      PVector pt2 = new PVector(pt.x, pt.y);

      transformPt(translate, pivot, rotate, pt2);

      poly.add(pt2.x, pt2.y);
    }

    if (currentPen != null)
    {
      poly.setPen(currentPen.x, currentPen.y);
      transformPt(translate, pivot, rotate, poly.currentPen);
    }

    if (prevPen != null)
    {
      poly.prevPen = new PVector(prevPen.x, prevPen.y);
    }
    
    return poly;
  }

  void transformPt(PVector translate, PVector pivot, float rotate, PVector pt)
  {
      float x = pt.x;
      float y = pt.y;
      
      x += translate.x;
      y += translate.y;
      
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

