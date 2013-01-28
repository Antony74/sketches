
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
  }
};


