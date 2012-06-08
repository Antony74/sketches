
char currentColor = 'K'; // Black
char currentTool = '1';  // Thin brush
char currentBrush = '1'; // Thin brush

Toolbar toolbar;
Canvas canvas;

void setup()
{
  size(900,600);
  background(255);

  toolbar = new Toolbar();
  canvas = new Canvas();

  canvas.setSize(width, height - Button.height);
  canvas.setup();
  
  colorWheel.setSize(width, height - Button.height);
  colorWheel.setup();
  
  Button buttons[] = {
    new ColorButton('K', 0,     0,   0),
    new ColorButton('W', 255, 255, 255), // white
    new ColorButton('R', 255,   0,   0), // red
    new ColorButton('G', 0,   255,   0), // green
    new ColorButton('B', 0,     0, 255), // blue

    new BrushButton('1', 1),
    new BrushButton('2', 2),
    new BrushButton('3', 4),
    new BrushButton('4', 8),
    new BrushButton('5', 14),
    new BrushButton('6', 24),
    new BrushButton('7', 41),
  
    new ZoomButton('+', 2),
    new ZoomButton('-', 0.5),
    
    new PanButton('P'),
    
    new UndoButton('Z'),
    new RedoButton('Y')
  };

  buttons = addSaveButton(buttons, 'S');

  toolbar.setButtons(buttons);
  
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
    drawGrid();
  }
  
  toolbar.draw();
  
  drawloopComplete();
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


