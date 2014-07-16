

class Vertex
{
  Vertex(String sIdentifier, float x, float y, float z, String sDescription)
  {
    this.cIdentifier = sIdentifier.charAt(0);
    this.sDescription = sDescription;
    pv = new PVector(x, y, z);
  }
  
  char cIdentifier;
  String sDescription;
  PVector pv;
};

class Vertices
{
  Vertex[] arrVertices;

  void draw(int nEndShapeMode)
  {
    beginShape();
    for (int n = 0; n < arrVertices.length; ++n)
    {
      PVector pv = arrVertices[n].pv;
      vertex(pv.x, pv.y, pv.z);
    }
    endShape(nEndShapeMode);
  }
};

class CompositeShape
{
  ArrayList<Vertex> arrAllVertices = new ArrayList<Vertex>();
  ArrayList<Vertices> arrShapesToOutline = new ArrayList<Vertices>();
  ArrayList<Vertices> arrShapesToFill = new ArrayList<Vertices>();
  
  void draw()
  {
    pushStyle();
    noStroke();
    
    for (int n = 0; n < arrShapesToFill.size(); ++n)
    {
      arrShapesToFill.get(n).draw(CLOSE);
    }
    
    popStyle();

    pushStyle();
    noFill();
    
    for (int n = 0; n < arrShapesToOutline.size(); ++n)
    {
      arrShapesToOutline.get(n).draw(CLOSE);
    }
    
    popStyle();
  }

  CompositeShape vertex(Vertex v)
  {
    arrAllVertices.add(v);
    return this;
  }

  CompositeShape outline(String s)
  {
    addVerticesToArray(arrShapesToOutline, s);
    return this;
  }

  CompositeShape fill(String s)
  {
    addVerticesToArray(arrShapesToFill, s);
    return this;
  }
  
  void addVerticesToArray(ArrayList<Vertices> arr, String s)
  {
    Vertices vertices = new Vertices();
    vertices.arrVertices = new Vertex[s.length()];
    for (int n = 0; n < s.length(); ++n)
    {
      char c = s.charAt(n);
      for (int m = 0; m < arrAllVertices.size(); ++m)
      {
        Vertex v = arrAllVertices.get(m);
        
        if (v.cIdentifier == c)
        {
          vertices.arrVertices[n] = v;
          break;
        }
      }
      
      if (vertices.arrVertices[n] == null)
      {
        println("Vertex " + c + " not found");
      }
    }
    arr.add(vertices);    
  }

};


