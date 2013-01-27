
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

RFont m_font;
RGroup m_group;
RPoint m_pts[];
RPath m_path;

float m_textWidth = 0;

String m_sTyped = "";

void setup()
{
  size(900, 600);
  noSmooth();

  RG.init(this);
  m_font = new RFont(dataPath("impact.ttf"));
}

void draw()
{
  background(128);
  stroke(0);
  strokeWeight(1);
  
  translate((width - m_textWidth)/2, height/10);
  if (m_sTyped.length() > 0)
  {
    m_group.draw();

    for (int n = 0; n < m_pts.length; ++n)
    {
//      ellipse(m_pts[n].x, m_pts[n].y, 10, 10);
    }
  
    if (m_path != null)
    {
      RCommand cmd = m_path.commands[second() % m_path.commands.length];
      stroke(255,0,0);
      strokeWeight(3);
      cmd.draw();
    }
    
  }
}

void keyTyped()
{
  if (key == BACKSPACE)
  {
    if (m_sTyped.length() > 0)
    {
      m_sTyped = m_sTyped.substring(0, m_sTyped.length() - 1);
    }
  }
  else
  {
    m_sTyped += key;
  }
  
  if (m_sTyped.length() > 0)
  {
    m_group = m_font.toGroup(m_sTyped); 
    
    simplifyGroup(m_group, 0.01);
    
    m_pts = m_group.getPoints();

    float xMin = m_pts[0].x;
    float xMax = m_pts[0].x;

    for (int n = 1; n < m_pts.length; ++n)
    {
      xMin = min(xMin, m_pts[n].x);
      xMax = max(xMax, m_pts[n].x);
    }
    
    m_textWidth = xMax - xMin;
  }
}

void simplifyGroup(RGroup group, float acceptableError)
{
  for (int n = 0; n < group.elements.length; ++n)
  {
    RGeomElem elem = group.elements[n];
    
    if (elem.getClass().getName() == "geomerative.RShape")
    {
      simplifyShape((RShape)elem, acceptableError);
    }
    else
    {
      throw new RuntimeException("Element " + elem.getClass().getName() + " not supported");
    }
  }
}

void simplifyShape(RShape shape, float acceptableError)
{
  for (int n = 0; n < shape.paths.length; ++n)
  {
    simplifyPath(shape.paths[n], acceptableError);
  }

  if (shape.children != null)
  {
    for (int n = 0; n < shape.children.length; ++n)
    {
      simplifyShape(shape.children[n], acceptableError);
    }
  }
}

void simplifyPath(RPath path, float acceptableError)
{
  if (m_path == null)
  {
    m_path = path;
  }
  
  ArrayList<RCommand> simplified = new ArrayList<RCommand>();
    
  for (int n = 0; n < path.commands.length; ++n)
  {
    RCommand cmd1 = path.commands[n];
    RCommand cmd2 = path.commands[(n+1)%path.commands.length];
    
    if (cmd1.countControlPoints() != 0)
    {
      throw new RuntimeException("Command has " + cmd1.countControlPoints() + " control point(s).  Not a line");
    }
    
    float dist1 = dist(cmd1.startPoint, cmd1.endPoint); 
    float dist2 = dist(cmd2.startPoint, cmd2.endPoint);
    float dist3 = dist(cmd1.startPoint, cmd2.endPoint);

//    println(dist1 + ", " + dist2 + ", " + dist3);

    if (dist3 == 0 || (dist1 + dist2) / dist3 < 1 + acceptableError)
    {
      cmd2.startPoint = cmd1.startPoint;

//      println("yay");

    }
    else
    {
      simplified.add(cmd1);
    }
  } 

  path.commands = new RCommand[simplified.size()];
  for (int n = 0; n < simplified.size(); ++n)
  {
    path.commands[n] = simplified.get(n);
  }
}

float dist(RPoint p1, RPoint p2)
{
  return dist(p1.x, p1.y, p2.x, p2.y);
}


