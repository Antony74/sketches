
class RShapeIterator
{
  RShapeIterator(RGeomElem elem)
  {
    stack.add(new StackElem(elem,0));

    sRShape =   (new RShape()).getClass().getName();
    sRPath =    (new RPath()).getClass().getName();
    sRCommand = (new RCommand()).getClass().getName();
    sRPoint =   (new RPoint()).getClass().getName();
  }

  RGeomElem getCurrentElem()
  {
    return stack.lastElement().geomElem;
  }

  boolean hasUp()
  {
    return stack.size() > 1;
  }

  void up()
  {
    stack.removeElementAt(stack.size() - 1); // pop
  }

  boolean hasDown()
  {
    return getChild(stack.lastElement().geomElem, 0) != null;
  }

  void down()
  {
    stack.add(new StackElem(getChild(stack.lastElement().geomElem, 0), 0));
  }

  boolean hasPrevious()
  {
    return stack.lastElement().index > 0;
  }
  
  void previous()
  {
    RGeomElem parent = stack.elementAt(stack.size() - 2).geomElem;
    int nIndex = stack.lastElement().index - 1;
    up();
    stack.add(new StackElem(getChild(parent, nIndex), nIndex));
  }

  boolean hasNext()
  {
    RGeomElem parent = stack.elementAt(stack.size() - 2).geomElem;
    int nIndex = stack.lastElement().index + 1;
    return getChild(parent, nIndex) != null;
  }

  void next()
  {
    RGeomElem parent = stack.elementAt(stack.size() - 2).geomElem;
    int nIndex = stack.lastElement().index + 1;
    up();
    stack.add(new StackElem(getChild(parent, nIndex), nIndex));
  }

  private RGeomElem getChild(RGeomElem parent, int nIndex)
  {
    String sClass = parent.getClass().getName();
    
    if (sClass.equals(sRShape))
    {
      RShape shape = (RShape)parent;
      int nPaths = (shape.paths == null) ? 0 : shape.paths.length;
      int nChildren = (shape.children == null) ? 0 : shape.children.length;
      
      if (nIndex < nPaths)
      {
        return shape.paths[nIndex];
      }
      else if (nIndex < nPaths + nChildren)
      {
        return shape.children[nIndex - nPaths];
      }
    }
    
    return null;
  }

  private class StackElem
  {
    StackElem(RGeomElem elem, int nIndex)
    {
      geomElem = elem;
      index = nIndex;
    }

    RGeomElem geomElem;
    int index = 0;
  };

  private Vector<StackElem> stack = new Vector<StackElem>();

  private String sRShape;
  private String sRPath;
  private String sRCommand;
  private String sRPoint;
};


