
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

RFont m_font;
RGroup m_group;
RShape m_shape;
ArrayList<RPoint> m_pts;

LetterFactory m_LetterFactory;

float m_textWidth = 0;

String m_sTyped = "";

int m_nClicks = 0;

PVector m_lineStart = new PVector(0,0);
PVector m_lineEnd = new PVector(0,0);

void setup()
{
  size(900, 600);
  noSmooth();

  RG.init(this);
  m_font = new RFont(dataPath("impact.ttf"));
  m_LetterFactory = new LetterFactory(m_font);

  m_pts = new ArrayList<RPoint>();
}

void draw()
{
  background(128);
  stroke(0);
  strokeWeight(1);
  
  pushMatrix();
  translate((width - m_textWidth)/2, height/10);
  if (m_sTyped.length() > 0)
  {
    m_group.draw();

    for (int n = 0; n < m_pts.size(); ++n)
    {
      ellipse(m_pts.get(n).x, m_pts.get(n).y, 6, 6);
    }

    if (m_shape != null)
    {
      RPath path = m_shape.paths[second() % m_shape.paths.length];
      stroke(255,0,0);
      strokeWeight(3);
      path.draw();
    }
  }

  popMatrix();
  line(m_lineStart.x, m_lineStart.y, m_lineEnd.x, m_lineEnd.y);

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
    m_LetterFactory.doThing(key);
  }
  
  if (m_sTyped.length() > 0)
  {
    m_group = m_font.toGroup(m_sTyped); 
    m_shape = m_font.toShape(key);
    RG.setPolygonizer(RG.ADAPTATIVE);
    m_group.polygonize();
//    makeConvexGroup(m_group);
    
    RPoint pts[] = m_group.getPoints();

    float xMin = pts[0].x;
    float xMax = pts[0].x;

    for (int n = 1; n < pts.length; ++n)
    {
      xMin = min(xMin, pts[n].x);
      xMax = max(xMax, pts[n].x);
    }
    
    m_textWidth = xMax - xMin;
  }
}

void makeConvexGroup(RGroup group)
{
  for (int n = 0; n < group.elements.length; ++n)
  {
    RGeomElem elem = group.elements[n];
    
    if (elem.getClass().getName() == "geomerative.RShape")
    {
      makeConvexShape((RShape)elem);
    }
    else
    {
      throw new RuntimeException("Element " + elem.getClass().getName() + " not supported");
    }
  }
}

void makeConvexShape(RShape shape)
{
  for (int n = 0; n < shape.paths.length; ++n)
  {
    makeConvexPath(shape.paths[n]);
  }

  if (shape.children != null)
  {
    for (int n = 0; n < shape.children.length; ++n)
    {
      makeConvexShape(shape.children[n]);
    }
  }
}

void makeConvexPath(RPath path)
{
  for (int n = 0; n < path.commands.length; ++n)
  {
    RCommand cmd1 = path.commands[n];
    RCommand cmd2 = path.commands[(n+1) % path.commands.length];

    float angle = getAngle(cmd2) - getAngle(cmd1);    
    
    if ( angle >= HALF_PI || angle < -HALF_PI )
    {
      // convex
    }
    else
    {
      m_pts.add(cmd1.endPoint);
      println(angle / PI);
    }
  }
}

float getAngle(RCommand cmd)
{
    float angle = atan2(cmd.endPoint.y - cmd.startPoint.y, cmd.endPoint.x - cmd.startPoint.x);
    return angle;      
}

void mouseClicked()
{
  ++m_nClicks;
  
  if (m_nClicks % 2 == 0)
  {
    m_lineStart.x = mouseX;
    m_lineStart.y = mouseY;
  }
  else
  {
    m_lineEnd.x = mouseX;
    m_lineEnd.y = mouseY;
  }
}



