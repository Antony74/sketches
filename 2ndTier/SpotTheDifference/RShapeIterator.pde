
class RShapeIterator
{
  RShapeIterator(RGeomElem elem)
  {
    stack.add(new StackElem(elem,0));
  }

  RGeomElem getCurrentElem()
  {
    return stack.elementAt(currentDepth).geomElem;
  }

  RPoint getCurrentPoint()
  {
    return stack.elementAt(currentDepth).point;
  }

  boolean hasUp()
  {
    return currentDepth > 0;
  }

  void up()
  {
    --currentDepth;
  }

  boolean hasDown()
  {
    if (currentDepth < stack.size() - 1)
    {
      return true;
    }
    else
    { 
      RGeomElem current = getCurrentElem();
      return (current == null) ? false : (getChild(current, 0) != null);
    }
  }

  void down()
  {
    if (currentDepth >= stack.size() - 1)
    {
      stack.add(new StackElem(getChild(stack.lastElement().geomElem, 0), 0));
    }
    ++currentDepth;
  }

  boolean hasPrevious()
  {
    return stack.elementAt(currentDepth).index > 0;
  }
  
  void previous()
  {
    RGeomElem parent = stack.elementAt(currentDepth - 1).geomElem;
    int nIndex = getCurrentIndex() - 1;
    while (currentDepth < stack.size())
    {
      stack.removeElementAt(stack.size() - 1);
    }
    stack.add(new StackElem(getChild(parent, nIndex), nIndex));
  }

  boolean hasNext()
  {
    if (hasUp())
    {
      RGeomElem parent = stack.elementAt(currentDepth - 1).geomElem;
      int nIndex = getCurrentIndex() + 1;
      return getChild(parent, nIndex) != null;
    }
    else
    {
      return false;
    }
  }

  void next()
  {
    RGeomElem parent = stack.elementAt(currentDepth - 1).geomElem;
    int nIndex = getCurrentIndex() + 1;
    while (currentDepth < stack.size())
    {
      stack.removeElementAt(stack.size() - 1);
    }
    stack.add(new StackElem(getChild(parent, nIndex), nIndex));
  }

  private Object getChild(RGeomElem parent, int nIndex)
  {
    if (parent == null)
    {
      return null;
    }
    
    switch(parent.getType())
    {
    case RGeomElem.SHAPE:

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
      else
      {
        return null;
      }

    case RGeomElem.SUBSHAPE:
    
      RPath path = (RPath)parent;
      int nCommands = (path.commands == null) ? 0 : path.commands.length;
      
      if (nIndex < nCommands)
      {
        return path.commands[nIndex];
      }
      else
      {      
        return null;
      }
      
    case RGeomElem.COMMAND:
    
      RCommand cmd = (RCommand)parent;
      int nPoints = (cmd.controlPoints == null) ? 2 : cmd.controlPoints.length + 2;
      if (nIndex == 0)
      {
        return cmd.startPoint;
      }
      else if (nIndex == nPoints - 1)
      {
        return cmd.endPoint;
      }
      else if (nIndex < nPoints)
      {
        return cmd.controlPoints[nIndex - 1];
      }
      else
      {
        return null;
      }
    }
    
    return null;
  }

  private class StackElem
  {
    StackElem(Object obj, int nIndex)
    {
      if (obj.getClass().getName().equals("geomerative.RPoint"))
      {
        point = (RPoint)obj;
      }
      else
      {
        geomElem = (RGeomElem)obj;
      }
      index = nIndex;
    }

    RGeomElem geomElem;
    RPoint point;
    int index = 0;
  };

  private int getCurrentIndex()
  {
    return stack.elementAt(currentDepth).index;
  }

  private Vector<StackElem> stack = new Vector<StackElem>();
  private int currentDepth = 0;
};


