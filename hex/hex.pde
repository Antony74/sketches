
final int DIR_RIGHT       = 0;
final int DIR_DOWN_RIGHT  = 1;
final int DIR_DOWN_LEFT   = 2;
final int DIR_LEFT        = 3;
final int DIR_UP_LEFT     = 4;
final int DIR_UP_RIGHT    = 5;
final int DIRECTION_COUNT = 6;

float nSpacing;
PVector[] arrUnitVectors;

ArrayList<HexNode> listAllNodes; // Note there will be 127 nodes in total

HexNode nodeRed;
HexNode nodeGreen;
HexNode nodeBlue;

void markRed(HexNode node)
{
  if (nodeRed == null)
  {
    nodeRed = node;
  }
}

void markGreen(HexNode node)
{
  if (nodeGreen == null)
  {
    nodeGreen = node;
  }
}

void markBlue(HexNode node)
{
  if (nodeBlue == null)
  {
    nodeBlue = node;
  }
}

void setup()
{
  size(600,600);
  
  nSpacing = min(width, height) / 13;
  arrUnitVectors = new PVector[DIRECTION_COUNT];
  arrUnitVectors[DIR_RIGHT] = new PVector(nSpacing, 0);
  
  for (int n = 1; n < DIRECTION_COUNT; ++n)
  {
    arrUnitVectors[n] = arrUnitVectors[n-1].get();
    arrUnitVectors[n].rotate(TWO_PI/DIRECTION_COUNT);
  }

  HexNode nodeRoot = new HexNode();
  nodeRoot.m_pt = new PVector( (width/2) - (nSpacing*3), 1.5 * nSpacing);
  listAllNodes = new ArrayList<HexNode>();
  listAllNodes.add(nodeRoot);
  
  HexNode node = nodeRoot;
  
  for (int nDirection = 0; nDirection < DIR_UP_RIGHT; ++nDirection)
  {
    for (int n = 1; n < 7; ++n)
    {
      node = node.create(nDirection);

      if (nDirection >= 3)
      {
        node.createUpRightRecursive();
      }     
    }
  }
  
  renumber();
}

void draw()
{
  float nSize = nSpacing * 0.75;

  for (int n = 0; n < listAllNodes.size(); ++n)
  {
    HexNode node = listAllNodes.get(n);

    for (int nDirection = 0; nDirection < DIRECTION_COUNT; ++nDirection)
    {
      HexNode nodeNeighbour = node.m_arrNeighbours[nDirection];
      
      if (nodeNeighbour != null)
      {
        line(node.m_pt.x, node.m_pt.y, nodeNeighbour.m_pt.x, nodeNeighbour.m_pt.y);
      }
    }
  }
  
  for (int n = 0; n < listAllNodes.size(); ++n)
  {
    HexNode node = listAllNodes.get(n);
    
    if (node == nodeRed)
    {
      fill(255, 0, 0);
    }
    else if (node == nodeGreen)
    {
      fill(0, 255, 0);
    }
    else if (node == nodeBlue)
    {
      fill(0, 0, 255);
    }
    else
    {
      fill(255);
    }
    
    ellipse(node.m_pt.x, node.m_pt.y, nSize, nSize);
    
    fill(0);
    text(new Integer(n).toString(), node.m_pt.x - (nSpacing * 0.3), node.m_pt.y + (nSpacing * 0.1));
  }

  noLoop();
}

class HexNode
{
  HexNode[] m_arrNeighbours;
  PVector m_pt;
  
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
}


