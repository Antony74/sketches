
final int maxHistory = 20;

class CanvasBase extends PGraphicsJava2D
{
  void setup()
  {
    history = new color[maxHistory][width*height];

    beginDraw();
    background(255);
    
    PImage initialImage = null;
    
    if (online == false)
    {
      File file = new File(savePath("data\\SavedPainting.png"));
      if (file.exists())
      {
        initialImage = loadImage("SavedPainting.png");
      }
    }
  
    if (initialImage != null)
    {
      image(initialImage, 0, 0);
    }
    
    zoomedWidth = width;
    zoomedHeight = height;
    loadPixels();
    arrayCopy(pixels, history[0]);
    historyIndex = 0;
    historyMin = 0;
    historyMax = 0;
    endDraw();
  }
  
  void draw(float mouseX, float mouseY, boolean mousePressed) {}
  
  void doDraw(float mouseX, float mouseY, boolean mousePressed)
  {
    if (mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height)
    {
      mousePressed = false;
    }

    mouseX = (mouseX - pannedX) * width / zoomedWidth;
    mouseY = (mouseY - pannedY) * height / zoomedHeight;

    beginDraw();
    draw(mouseX, mouseY, mousePressed);
    endDraw();
  }
  
  void zoom(float x, float y, float zoomFactor)
  {
    // Only zoom if at least three pixels will still fit onto the screen horizantally
    if (3 * zoomedWidth * zoomFactor / width < width)
    {
      pannedX -= x;
      pannedY -= y;

      zoomedWidth *= zoomFactor;
      zoomedHeight *= zoomFactor;
  
      pannedX *= zoomFactor;
      pannedY *= zoomFactor;
  
      pannedX += (width/2);
      pannedY += (height/2);
  
      applyPanLimits();
    }
  }

  void pan(float x, float y)
  {
    pannedX += x;
    pannedY += y;
    
    applyPanLimits();
  }

  void applyPanLimits()
  {
    if (zoomedWidth < width || zoomedHeight < height)
    {
      zoomedWidth = width;
      zoomedHeight = height;
      pannedX = 0;
      pannedY = 0;
    }

    if (pannedX > 0)
    {
      pannedX = 0;
    }

    if (pannedY > 0)
    {
      pannedY = 0;
    }

    if (pannedX < width - zoomedWidth)
    {
      pannedX = width - zoomedWidth;
    }
    if (pannedY < height - zoomedHeight)
    {
      pannedY = height - zoomedHeight;
    }
  }
  
  void mouseReleased()
  {
    loadPixels();
    boolean bChanged = false;
    for (int n = 0; n < pixels.length; ++n)
    {
      if (pixels[n] != history[historyIndex][n])
      {
        bChanged = true;
        break;
      }
    }

    if (bChanged)
    {
      ++historyIndex;
      if (historyIndex >= history.length)
      {
        historyIndex = 0;
      }
      arrayCopy(pixels, history[historyIndex]);
      historyMax = historyIndex;
      if (historyMin == historyMax)
      {
        ++historyMin;
        if (historyMin >= history.length)
        {
          historyMin = 0;
        }
      }
    }
  }
  
  boolean canUndo()
  {
    return historyMin != historyIndex;
  }
  
  boolean canRedo()
  {
    return historyMax != historyIndex;
  }
  
  void loadHistory()
  {
    arrayCopy(history[historyIndex], pixels);
    updatePixels();
  }

  void undo()
  {
    if (canUndo())
    {
      --historyIndex;
      if (historyIndex < 0)
        historyIndex = history.length - 1;
        
      loadHistory();
    }
  }
  
  void redo()
  {
    if (canRedo())
    {
      ++historyIndex;
      if (historyIndex >= history.length)
        historyIndex = 0;
        
      loadHistory();
    }
  }

  float pannedX = 0;
  float pannedY = 0;
  float zoomedWidth;
  float zoomedHeight;

  color history[][];
  int historyIndex;
  int historyMin;
  int historyMax;
};

void drawGrid()
{
  if (canvas.zoomedWidth / canvas.width > 20)
  {
    noFill();
    strokeWeight(1);
    noSmooth();
    
    for (int x = 0; x < canvas.width; ++x)
    {
      float xZoomed = x * canvas.zoomedWidth / canvas.width;
      xZoomed += canvas.pannedX;
      
      if (xZoomed >= 0 && xZoomed < width)
      {
        for (int y = Button.height; y < height; ++y)
        {
          stroke((y%2) == 0 ? 64 : 192);
          point(xZoomed,y);
        }
      }
    }

    for (int y = 0; y < canvas.height; ++y)
    {
      float yZoomed = y * canvas.zoomedHeight / canvas.height;
      yZoomed += canvas.pannedY;
      
      if (yZoomed >= 0 && yZoomed < height - Button.height)
      {
        yZoomed += Button.height;
        
        for (int x = 0; x < width; ++x)
        {
          stroke((x%2) == 1 ? 64 : 192);
          point(x,yZoomed);
        }
      }
    }

  }
}

// Simple mechanism for not thrashing our processor core when we're not doing anything
 
int nLoop = 2;

void loop(int n)
{
  nLoop = n;
  loop();
}

void drawloopComplete()
{
  if (nLoop > 0)
  {
    --nLoop;
    if (nLoop == 0)
    {
      noLoop();
    }
  }
}

/**
Wheel mouse taken from http://wiki.processing.org/index.php/Wheel_mouse
@author Rick Companje
*/
 
void setupWheelMouse()
{
  if (online == false) // The wheel is already used to scroll the web page
  {
    addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
      public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
        mouseWheel(evt.getWheelRotation());
    }});
    } 
}


