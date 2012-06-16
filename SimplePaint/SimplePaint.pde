
Toolbar toolbar;
Canvas canvas;

void setup()
{
  size(900,600);
  background(255);

  currentColor = 'K'; // Black
  currentTool = '1';  // Thin brush
  currentBrush = '1'; // Thin brush

  toolbar = new Toolbar();
  canvas = new Canvas();

  canvas.setSize(width, height - Button.height);
  canvas.setup(this);
  
  colorWheel.setSize(width, height - Button.height);
  colorWheel.setup();
  
  Vector<Button> vecButtons = new Vector<Button>();
  
  if (online == false)
  {
    vecButtons.add(new SaveButton('S', canvas));
  }
  
  vecButtons.add(new ColorButton('K', 0,     0,   0)); // Black
  vecButtons.add(new ColorButton('W', 255, 255, 255)); // white
  vecButtons.add(new ColorButton('R', 255,   0,   0)); // red
  vecButtons.add(new ColorButton('G', 0,   255,   0)); // green
  vecButtons.add(new ColorButton('B', 0,     0, 255)); // blue

  vecButtons.add(new BrushButton('1', 1));
  vecButtons.add(new BrushButton('2', 2));
  vecButtons.add(new BrushButton('3', 4));
  vecButtons.add(new BrushButton('4', 8));
  vecButtons.add(new BrushButton('5', 14));
  vecButtons.add(new BrushButton('6', 24));
  vecButtons.add(new BrushButton('7', 41));

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
    Button tool = toolbar.getButton(currentTool);

    if (tool instanceof BrushButton)
    {
      ColorButton cb = (ColorButton)toolbar.getButton(currentColor);
      BrushButton bb = (BrushButton)tool;
    
      smooth();
      stroke(cb.m_color);
      strokeWeight(bb.m_weight);
      
      if (mouseButton == LEFT)
      {
        if (mousePressed && pmousePressed)
        {
          line(pmouseX, pmouseY, mouseX, mouseY);
        }
        else if (mousePressed)
        {
          point(mouseX, mouseY);
        }
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
  
  boolean drawn = drawColorWheel(toolbar);

  if (drawn == false)
  {
    canvas.doDraw(mouseX, mouseY - Button.height, mousePressed);
    noSmooth();
    image(canvas, canvas.pannedX, canvas.pannedY + Button.height, canvas.zoomedWidth, canvas.zoomedHeight);
    drawGrid(canvas, Button.height);
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
  showColorWheel = false;
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

  if (bProcessed == false)
  {
    if (showColorWheel)
    {
      if (mouseButton == LEFT)
      {
        boolean dismiss = colorWheel.mousePressed(mouseX, mouseY - Button.height, mouseButton);
        if (dismiss)
        {
          showColorWheel = false;
          mousePressed = false;
        }
      }
      else if (mouseButton == RIGHT)
      {
        showColorWheel = false;
      }
    }
  }

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


