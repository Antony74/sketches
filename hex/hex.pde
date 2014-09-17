
float nSpacing;
PVector[] arrUnitVectors;

void setup()
{
  size(900, 900);
  
  nSpacing = min(width, height) / 20;
  arrUnitVectors = new PVector[DIRECTION_COUNT];
  arrUnitVectors[DIR_RIGHT] = new PVector(nSpacing, 0);
  
  for (int n = 1; n < DIRECTION_COUNT; ++n)
  {
    arrUnitVectors[n] = arrUnitVectors[n-1].get();
    arrUnitVectors[n].rotate(TWO_PI/DIRECTION_COUNT);
  }

  HexNode nodeRoot = new HexNode();
  nodeRoot.m_pt = new PVector( (width/2) - (nSpacing*3), (height/2) - (nSpacing*5.5));
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
  assembleSolution();
  assembleConstraints();
  
  for (Constraint constraint: listConstraints)
  {
    constraint.checkConstraint();
  }
  
  textFont(createFont("Courier New", 16));
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
    String sContent = solution.get(n).toString();
    
    if (sContent.equals(" "))
    {
      fill(255, 255, 0);
    }
    else
    {
      fill(255);
    }
    
    ellipse(node.m_pt.x, node.m_pt.y, nSize, nSize);
    
    fill(0);
    text(sContent, node.m_pt.x - (nSpacing * 0.3), node.m_pt.y + (nSpacing * 0.1));
  }

  for (int n = 0; n < listConstraints.size(); ++n)
  {
    Constraint constraint = listConstraints.get(n);
    constraint.draw();
  }

  noLoop();
}



