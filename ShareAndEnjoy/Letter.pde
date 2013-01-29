
import java.util.TreeSet;
import java.util.Iterator;

class LetterFactory
{
  TreeSet<Part> m_TreeSet;
  RFont m_font;

  LetterFactory(RFont font)
  {
    m_font = font;
    m_TreeSet = new TreeSet<Part>();
  }
  
  void doThing(char letter)
  {
    RShape shape = m_font.toShape(letter);
    Part part = null;
    int nPart = 0;

    for (int n = 0; n < shape.paths.length; ++n)
    {
      RPath path = shape.paths[n];
      
      if (part == null || part.m_shape.paths[0].containsBounds(path) == false)
      {
        ++nPart;
        part = new Part(letter, nPart);
        part.m_shape.addPath(path);
        m_TreeSet.add(part);
      }
      else
      {
        part.m_shape.addPath(path);
      }
    }
  
    Iterator<Part> itr = m_TreeSet.iterator();

    while(itr.hasNext())
    {
      part = itr.next();
      part.doConvexThing();
    }
  }

};

class Part implements Comparable<Part>
{
  RShape m_shape = new RShape();
  ArrayList<RPath> convexPaths = new ArrayList<RPath>();

  char m_letter;
  int m_nPart;

  Part(char letter, int nPart)
  {
    m_letter = letter;
    m_nPart = nPart;
  }
  
  int compareTo(Part other)
  {
    if (m_letter == other.m_letter)
    {
      return m_nPart - other.m_nPart;
    }
    else
    {
      return m_letter - other.m_letter;
    }
  }

  void doConvexThing()
  {
    convexPaths.add(m_shape.paths[0]);
    for (int n = 0; n < convexPaths.size();)
    {
      boolean brc = doConvexThing(n);
      if (brc)
      {
        ++n;
      }
    }  
  }    
  
  boolean doConvexThing(int nPath)
  {
    RPath path = convexPaths.get(nPath);  
    for (int n = 0; n < path.commands.length; ++n)
    {
      boolean brc = doConvexThing(path, n);
      if (brc)
      {
        ++n;
      }
    }
    
    return true;
  }

  boolean doConvexThing(RPath path, int nCmd1)
  {
    int nCount = path.commands.length;
    int nPrev = (nCmd1 - 1) % nCount;
    int nNext = (nCmd1 + 1) % nCount;
    
    RCommand cmd1 = path.commands[nCmd1];
    
    for (int nCmd2 = 0; nCmd2 < path.commands.length; ++nCmd2)
    {
      RCommand cmd2 = path.commands[nCmd2];

      RPoint pt = getLineLineSegmentIntersection(cmd1, cmd2);
      
      if (nCmd1 == nCmd2)
      {
        // no action
      }
      else if (nPrev == nCmd2 && cmd2.endPoint == pt)
      {
        // no action
      }
      else if (nNext == nCmd2 && cmd2.startPoint == pt)
      {
        // no action
      }
      else if (pt != null)
      {
        // We have an intersection, and not one that wouldn't happen if this path was convex, so action is required.
        println(pt.toString());
      }
      
    }

    return true;
  }

  RPoint getLineLineSegmentIntersection(RCommand cmd1, RCommand cmd2)
  {
    return getLineLineSegmentIntersection(cmd1.startPoint, cmd1.endPoint, cmd2.startPoint, cmd2.endPoint);
  }

  RPoint getLineLineSegmentIntersection(RPoint p1, RPoint p2, RPoint p3, RPoint p4)
  {
    RPoint ptIntersection = getLineLineIntersection(p1, p2, p3, p4);
  
    if (ptIntersection != null)
    {  
      Rectangle rect34 = new Rectangle(p3.x, p3.y, p4.x, p4.y);
      rect34.normalise();
  
      if (rect34.containsPoint(ptIntersection.x,ptIntersection.y))
      {
        // Good, this point is also on the line-segment, not just on the line
      }
      else
      {
        ptIntersection = null;
      }
    }
  
    return ptIntersection;
  }
  
  RPoint getLineLineIntersection(RPoint p1, RPoint p2, RPoint p3, RPoint p4)
  {
    float denominator = ((p1.x-p2.x)*(p3.y-p4.y)) - ((p1.y-p2.y)*(p3.x-p4.x));
    if (denominator == 0)
    {
      // Lines are parallel.  We will already have any points that may be relevant
      return null;
    }
    else
    {
      // Lines are not parallel, therefore there is a single point of intersection to be found,
      // although it may or may not lie within the line-segments.
      float xNum = (((p1.x*p2.y)-(p1.y*p2.x))*(p3.x-p4.x)) - ((p1.x-p2.x)*((p3.x*p4.y)-(p3.y*p4.x)));
      float yNum = (((p1.x*p2.y)-(p1.y*p2.x))*(p3.y-p4.y)) - ((p1.y-p2.y)*((p3.x*p4.y)-(p3.y*p4.x)));
      
      return new RPoint(xNum/denominator, yNum/denominator);
    }
      
  }

};


