
Toolbar toolbar;
Canvas canvas;
 
String sSections = "CC"; // Reference, canvas, both

void setup()
{
  size(900,600);
  background(255);

  toolbar = new Toolbar();
  canvas = new Canvas();

  canvas.setSize(width, height - Button.height);
  canvas.setup(this);
  
  ArrayList<Button> vecButtons = new ArrayList<Button>();
  
  if (online == false)
  {
    vecButtons.add(new SaveButton('S', canvas));
  }

  vecButtons.add(new ZoomButton('+', 2,   canvas));
  vecButtons.add(new ZoomButton('-', 0.5, canvas));
  
  vecButtons.add(new PanButton('P',  canvas));
  
  vecButtons.add(new UndoButton('Z', canvas));
  vecButtons.add(new RedoButton('Y', canvas));

  toolbar.setButtons(vecButtons);
  
  setupWheelMouse();
  setupZoomCursors(toolbar.font);  
}

class Canvas extends CanvasBase
{
  void draw(float mouseX, float mouseY, boolean mousePressed)
  {
    if (mouseButton == LEFT)
    {
      smooth();
      stroke(0);
      strokeWeight(1);

      if (mousePressed && pmousePressed)
      {
        line(pmouseX, pmouseY, mouseX, mouseY);
      }
      else if (mousePressed)
      {
        point(mouseX, mouseY);
      }
    }
    
    pmouseX = mouseX;
    pmouseY = mouseY;
    pmousePressed = mousePressed;
  }

  boolean pmousePressed = false;
  float pmouseX;
  float pmouseY;
};

void draw()
{
  background(128);

  float sectionWidth = width / sSections.length();

  for (int nSection = 0; nSection < sSections.length(); ++nSection)
  {
    float sectionStart = nSection * width / sSections.length();
    
    char sect = sSections.charAt(nSection);
    
    switch(sect)
    {
    case 'C': // Canvas
      canvas.doDraw(mouseX, mouseY - Button.height, mousePressed);
      noSmooth();
      image(canvas, sectionStart + canvas.pannedX, canvas.pannedY + Button.height, canvas.zoomedWidth / sSections.length(), canvas.zoomedHeight);
      drawGrid(canvas, Button.height);
      stroke(0);
      strokeWeight(1);
      break;
    }

    rect(sectionStart, Button.height, sectionWidth, height - Button.height);
  }
  
  toolbar.draw();
  
  drawloopComplete();
}

void keyPressed()
{
  loop(1);
}

void keyTyped()
{
  toolbar.buttonPressed(key);

  loop(1);
}

void keyReleased()
{
  loop(1);
}

void mousePressed()
{
  boolean bProcessed = toolbar.mousePressed();

  loop(2);
}

void mouseMoved()
{
  toolbar.mouseMoved();
}

void mouseDragged()
{
  toolbar.mouseDragged();

  loop(-1);
}

void mouseReleased()
{
  canvas.mouseReleased();

  loop(2);
}

void mouseWheel(int delta)
{
  if (delta > 0)
  {
    canvas.zoom(mouseX, mouseY - Button.height, sqrt(0.5));
  }
  else if (delta < 0)
  {
    canvas.zoom(mouseX, mouseY - Button.height, sqrt(2.0));
  }

  loop(2);
}


