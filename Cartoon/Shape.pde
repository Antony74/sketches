
class Vertex
{
  Vertex(String sIdentifier, float x, float y)
  {
    this.cIdentifier = sIdentifier.charAt(0); // For some reason passing a char in as a parameter doesn't work in JavaScript mode
    pv = new PVector(x, y);
  }
  
  void draw()
  {
    pushStyle();
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0, 128);
    rect(pv.x, pv.y, 5, 5);
    popStyle();
  }
  
  char cIdentifier;
  PVector pv;
}

interface Shape
{
  void draw();
  PVector point(float t);
  float length();
};

class Element
{
  Vertex[] arrVertices;
  float nLength = 0.0;
};

class Line extends Element implements Shape
{
  void draw()
  {
    if (arrVertices.length == 2)
    {
      PVector pv1 = arrVertices[0].pv;
      PVector pv2 = arrVertices[1].pv;
      line(pv1.x, pv1.y, pv2.x, pv2.y);
    }
  }

  void calcLength()
  {
    if (arrVertices.length == 2)
    {
      PVector pv1 = arrVertices[0].pv;
      PVector pv2 = arrVertices[1].pv;
      nLength = PVector.dist(pv1, pv2);
    }
  }
  
  float length()
  {
    return nLength;
  }
  
  PVector point(float t)
  {
    if (arrVertices.length == 2 && t >= 0 && t <= 1)
    {
      PVector pv1 = arrVertices[0].pv.get();
      PVector pv2 = arrVertices[1].pv.get();
      pv1.mult(t);
      pv2.mult(1-t);
      return PVector.add(pv1, pv2);
    }
    else
    {
      return null;
    }
  }
};

class Bezier extends Element implements Shape
{
  float length()
  {
    return nLength;
  }
  
  void draw()
  {
    if (arrVertices.length == 4)
    {
      PVector pt1 = arrVertices[0].pv;
      PVector c1  = arrVertices[1].pv;
      PVector c2  = arrVertices[2].pv;
      PVector pt2 = arrVertices[3].pv;
      bezier(pt1.x, pt1.y, c1.x, c1.y, c2.x, c2.y, pt2.x, pt2.y);
    }
  }

  void calcLength()
  {
    if (arrVertices.length == 4)
    {
      PVector pt1 = arrVertices[0].pv;
      PVector pt2 = arrVertices[3].pv;
      nLength = PVector.dist(pt1, pt2);
    }
  }

  PVector point(float t)
  {
    if (arrVertices.length == 4)
    {
      PVector pt1 = arrVertices[0].pv;
      PVector c1  = arrVertices[1].pv;
      PVector c2  = arrVertices[2].pv;
      PVector pt2 = arrVertices[3].pv;
      float x = bezierPoint(pt1.x, c1.x, c2.x, pt2.x, t);
      float y = bezierPoint(pt1.y, c1.y, c2.y, pt2.y, t);
      return new PVector(x, y);
    }
    else
    {
      return null;
    }
  }
};

class Composite implements Shape
{
  ArrayList<Vertex> arrAllVertices = new ArrayList<Vertex>();
  ArrayList<Shape> arrShapes = new ArrayList<Shape>();
  float nLength = 0.0;
  
  void drawVertices()
  {
    for (int n = 0; n < arrAllVertices.size(); ++n)
    {
      Vertex v = arrAllVertices.get(n);
      v.draw();
    }
  }

  Composite vertex(Vertex v)
  {
    arrAllVertices.add(v);
    return this;
  }
  
  Composite line(String s)
  {
    for (int n = 1; n < s.length(); ++n)
    {
      String sSub = s.substring(n-1, n+1);
      Line line = new Line();
      addVerticesToShape(sSub, line);
      line.calcLength();
      nLength += line.nLength;
      arrShapes.add(line);
    }
    return this;
  }
  
  Composite bezier(String s)
  {
    if (s.length() == 4)
    {
      Bezier bezier = new Bezier();
      addVerticesToShape(s, bezier);
      bezier.calcLength();
      nLength += bezier.nLength;
      arrShapes.add(bezier);
    }
    
    return this;
  }

  void addVerticesToShape(String s, Element elm)
  {
    elm.arrVertices = new Vertex[s.length()];
    for (int n = 0; n < s.length(); ++n)
    {
      char c = s.charAt(n);
      for (int m = 0; m < arrAllVertices.size(); ++m)
      {
        Vertex v = arrAllVertices.get(m);
        
        if (v.cIdentifier == c)
        {
          elm.arrVertices[n] = v;
          break;
        }
      }
      
      if (elm.arrVertices[n] == null)
      {
        println("Vertex " + c + " not found");
      }
    }
  }

  void draw()
  {
    for (int n = 0; n < arrShapes.size(); ++n)
    {
      Shape shape = arrShapes.get(n);
      shape.draw();
    }
  }

  PVector point(float t)
  {
    t *= nLength;
    for (int n = 0; n < arrShapes.size(); ++n)
    {
      Shape shape = arrShapes.get(n);
      if (t <= shape.length())
      {
        return shape.point(t/shape.length());
      }
      
      t -= shape.length();
    }
    
    return null;
  }

  float length()
  {
    return nLength;
  }

};


