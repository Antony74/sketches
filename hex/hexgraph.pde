
final int DIR_RIGHT       = 0;
final int DIR_DOWN_RIGHT  = 1;
final int DIR_DOWN_LEFT   = 2;
final int DIR_LEFT        = 3;
final int DIR_UP_LEFT     = 4;
final int DIR_UP_RIGHT    = 5;
final int DIRECTION_COUNT = 6;

ArrayList<HexNode> listAllNodes; // Note there will be 127 nodes in total

class HexNode
{
  HexNode[] m_arrNeighbours;
  PVector m_pt;  
  int m_nIndex;
  
  HexNode()
  {
    m_arrNeighbours = new HexNode[DIRECTION_COUNT];
  }
  
  HexNode create(int nDirection)
  {
    int nInverseDirection = (nDirection + 3) % DIRECTION_COUNT;
    
    HexNode node = new HexNode();
    node.m_pt = m_pt.get();
    node.m_pt.add(arrUnitVectors[nDirection]);
    m_arrNeighbours[nDirection] = node;
    node.m_arrNeighbours[nInverseDirection] = this;
    listAllNodes.add(node);
    return node;
  }
  
  void createUpRightRecursive()
  {
    if (listAllNodes.size() > 1000)
    {
      println("More recursion than expected");
      return;
    }

    HexNode node1 = m_arrNeighbours[DIR_RIGHT];

    if (node1 == null)
    {
      node1 = m_arrNeighbours[DIR_DOWN_RIGHT].m_arrNeighbours[DIR_UP_RIGHT];
      m_arrNeighbours[DIR_RIGHT] = node1;
      node1.m_arrNeighbours[DIR_LEFT] = this;
    }

    HexNode node2 = node1.m_arrNeighbours[DIR_UP_RIGHT];

    if (node2 == null)
    {
      HexNode node = node1.m_arrNeighbours[DIR_UP_LEFT];
      
      if (node == null)
      {
        return;
      }
      
      m_arrNeighbours[DIR_UP_RIGHT] = node;
      node.m_arrNeighbours[DIR_DOWN_LEFT] = this;
      return;
    }

    if (node2.m_arrNeighbours[DIR_LEFT] != null)
    {
      HexNode node = node2.m_arrNeighbours[DIR_LEFT];
      m_arrNeighbours[DIR_UP_RIGHT] = node;
      node.m_arrNeighbours[DIR_DOWN_LEFT] = this;
      node1.m_arrNeighbours[DIR_UP_LEFT] = node;
      node.m_arrNeighbours[DIR_DOWN_RIGHT] = node1;
      return;
    }
    
    if (node1.m_arrNeighbours[DIR_UP_LEFT] == null)
    {
      HexNode node = create(DIR_UP_RIGHT);
      node1.m_arrNeighbours[DIR_UP_LEFT] = node;
      node.m_arrNeighbours[DIR_DOWN_RIGHT] = node1;
      node2.m_arrNeighbours[DIR_LEFT] = node;
      node.m_arrNeighbours[DIR_RIGHT] = node2;

      node.createUpRightRecursive();
    } 
  }
  
};

void renumber()
{
  HexNode nodeLeft = listAllNodes.get(0);
  HexNode nodeCurrent = nodeLeft;

  listAllNodes = new ArrayList<HexNode>();

  while (nodeCurrent != null)
  {
    listAllNodes.add(nodeCurrent);
    
    nodeCurrent = nodeCurrent.m_arrNeighbours[DIR_RIGHT];
    
    if (nodeCurrent == null)
    {
      nodeCurrent = nodeLeft.m_arrNeighbours[DIR_DOWN_LEFT];
      
      if (nodeCurrent == null)
      {
        nodeCurrent = nodeLeft.m_arrNeighbours[DIR_DOWN_RIGHT]; 
      }

      nodeLeft = nodeCurrent;
    }
  }
  
  for (int n = 0; n < listAllNodes.size(); ++n)
  {
    HexNode node = listAllNodes.get(n);
    node.m_nIndex = n;
  }
}

