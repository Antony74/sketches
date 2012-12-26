
import java.util.Vector;

static kaleidoscope global;
Vector<Triangle> g_vecTriangles = new Vector<Triangle>();

// This is the triangle formed by the kaleidoscope's mirrors
BaseTriangle g_baseTriangle = new BaseTriangle();

// Each time a triangle is drawn it passes through several filters.  First it's clipped, then it's mirrored, then the plain filter draws it.
IFilter g_filter = new KaleidoscopeClip(new KaleidoscopeMirror(new FilterPlain(), g_baseTriangle), g_baseTriangle);


int rnd(int n) {return (int)random(n);} // oh ffs!!1!

void setup()
{
  global = this;
  
  size(900, 600);
 
  setupWheelMouse();
  
  int nRange = 100;

  for (int n = 0; n < 1000; ++n)
  {
    int x = rnd(width);
    int y = rnd(height);

    Triangle t = new Triangle();
    t.x1 = x + rnd(nRange * 2) - nRange;
    t.y1 = y + rnd(nRange * 2) - nRange;
    t.x2 = x + rnd(nRange * 2) - nRange;
    t.y2 = y + rnd(nRange * 2) - nRange;
    t.x3 = x + rnd(nRange * 2) - nRange;
    t.y3 = y + rnd(nRange * 2) - nRange;
    t.nRed = rnd(255);
    t.nGreen = rnd(255);
    t.nBlue = rnd(255);

    g_vecTriangles.add(t);
  }

  noStroke();
}

void mouseWheel(int delta)
{
  g_baseTriangle.nRadius += delta * 5;
  g_baseTriangle.nRadius = max(50, g_baseTriangle.nRadius);
  g_baseTriangle.nRadius = min(200, g_baseTriangle.nRadius);
}

void draw()
{
  background(128);

  updatePosition();

  g_baseTriangle.calculate((int)xPosition, (int)yPosition);

  for (int n = 0; n < g_vecTriangles.size(); ++n)
  {
    Triangle tri = g_vecTriangles.get(n);
    fill(tri.nRed, tri.nGreen, tri.nBlue);
    g_filter.triangle(tri);
  }
}

interface IFilter
{
  void triangle(int x1, int y1, int x2, int y2, int x3, int y3);
  void triangle(Triangle tri);
};

class FilterPlain implements IFilter
{
  void triangle(int x1, int y1, int x2, int y2, int x3, int y3) {global.triangle(x1, y1, x2, y2, x3, y3);}
  void triangle(Triangle tri) {triangle(tri.x1, tri.y1, tri.x2, tri.y2, tri.x3, tri.y3);}
};

//
// Our position is defined by the mouse.  Unless there's a key press, or no mouse input for a while,
// in which case make some automatic movements
//

float xPosition = 500.0;
float yPosition = 500.0;
int nLastMouse = 0;
float fSpeed = 0.0;
float fAng = 0.0;
float fSteer = 0.0;

void updatePosition()
{
  if (mouseX != pmouseX || mouseY != pmouseY)
  {
    nLastMouse = millis();
  }
  
  if (keyPressed)
  {
    nLastMouse = -50000;
  }
  
  if ((nLastMouse + 20000) > millis())
  {
    xPosition = mouseX;
    yPosition = mouseY;
    return;
  }

  xPosition += fSpeed * cos(fAng);
  yPosition += fSpeed * sin(fAng);
  
  if (xPosition > width)
  {
    fAng = -PI;
    xPosition = width;
  }

  if (xPosition < 0)
  {
    fAng = 0;
    xPosition = 0;
  }

  if (yPosition > height)
  {
    fAng = PI + HALF_PI;
    yPosition = height;
  }

  if (yPosition < 0)
  {
    fAng = HALF_PI;
    yPosition = 0;
  }

  fSpeed = min(fSpeed + 0.1, 2);
  fAng += fSteer;
  float fAngAcc = 0.02;
  fSteer += random(fAngAcc) - (fAngAcc/2);
  fSteer = constrain(fSteer, -0.03, 0.03);
}

/**
Wheel mouse taken from http://wiki.processing.org/index.php/Wheel_mouse
@author Rick Companje
*/
 
void setupWheelMouse()
{
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
  }}); 
}
 

