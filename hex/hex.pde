
float nSpacing;
float nNodeSize;
PVector[] arrUnitVectors;
float nRotation = 0.0;
int nTextSize = 16;
HexNode nodeHasFocus = null;

void setup()
{
  size(900, 900);
  
  nSpacing = min(width, height) / 20;
  nNodeSize = nSpacing * 0.75;
  
  arrUnitVectors = new PVector[DIRECTION_COUNT];
  arrUnitVectors[DIR_RIGHT] = new PVector(nSpacing, 0);
  
  for (int n = 1; n < DIRECTION_COUNT; ++n)
  {
    arrUnitVectors[n] = arrUnitVectors[n-1].get();
    arrUnitVectors[n].rotate(TWO_PI/DIRECTION_COUNT);
  }

  HexNode nodeRoot = new HexNode();
  nodeRoot.m_pt = new PVector( (width/2) + (arrUnitVectors[DIR_UP_LEFT].x * 6), (height/2) + (arrUnitVectors[DIR_UP_LEFT].y * 6));
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
  checkConstraints();
  
  textFont(createFont("Courier New Bold", nTextSize));
}

void draw()
{
  background(200);
  
  translate(width/2, height/2);
  rotate(nRotation);
  translate(-width/2, -height/2);

  // Draw edges - i.e. the connections between neighbouring nodes
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

  // Draw nodes  
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

    pushStyle();
    
    if (node == nodeHasFocus)
    {
      stroke(255, 0, 0);
      strokeWeight(3);
    } 
    
    ellipse(node.m_pt.x, node.m_pt.y, nNodeSize, nNodeSize);

    popStyle();
    
    // Draw text
    
    pushMatrix();
    translate(node.m_pt.x, node.m_pt.y);
    rotate(-nRotation);
    
    fill(0);
    text(sContent, -textWidth(sContent) * 0.5, nTextSize * 0.4);

    popMatrix();
  }

  // Draw constraints
  for (int n = 0; n < listConstraints.size(); ++n)
  {
    Constraint constraint = listConstraints.get(n);
    constraint.draw();
  }

  // Draw a "this way up" arrow
  strokeWeight(4);
  line(260, 100, 260, 170);
  line(260, 100, 240, 130);
  line(260, 100, 280, 130);
  strokeWeight(1);

  noLoop();
}

void mouseDragged()
{
  PVector pvCurrent  = new PVector(mouseX - (width/2), mouseY - (height/2));
  PVector pvPrevious = new PVector(pmouseX - (width/2), pmouseY - (height/2));

  nRotation += pvCurrent.heading() - pvPrevious.heading();
  
  loop();
}

void mouseClicked()
{
  PVector pt = new PVector(mouseX - (width/2), mouseY - (height/2));
  pt.rotate(-nRotation);
  pt.x += width/2;
  pt.y += height/2;
  
  nodeHasFocus = null;
  
  for (int n = 0; n < listAllNodes.size(); ++n)
  {
      HexNode node = listAllNodes.get(n);

      if (dist(node.m_pt.x, node.m_pt.y, pt.x, pt.y) < nNodeSize/2)
      {
        nodeHasFocus = node;
      }
  }
  
  loop();
}

void keyPressed()
{
  if (nodeHasFocus != null)
  {
    char cKey = key;
    if (cKey >= 'a' && cKey <= 'z')
    {
      cKey -= 'a';
      cKey += 'A';
    }
    
    if (keyCode == BACKSPACE || keyCode == DELETE)
    {
      cKey = ' ';
    }
    
    if ( (cKey == ' ') || (cKey >= 'A' && cKey <= 'Z') )
    {
      solution.set(nodeHasFocus.m_nIndex, cKey);
      checkConstraints();
      loop();
    } 
  }
}


