
final int maxHistory = 20;

class CanvasBase extends PGraphicsJava2D
{
  void setup(PApplet sketch)
  {
    parent = sketch;
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

  float pmouseX;
  float pmouseY;

  PImage setupEffectA() {return null;}
  PImage setupEffectB() {return null;}
  PImage setupEffectC() {return null;}
  PImage setupEffectD() {return null;}
  PImage setupEffectE() {return null;}
  PImage setupEffectF() {return null;}
  PImage setupEffectG() {return null;}
  PImage setupEffectH() {return null;}
  PImage setupEffectI() {return null;}
  PImage setupEffectJ() {return null;}

  void drawEffectA(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectB(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectC(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectD(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectE(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectF(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectG(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectH(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectI(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
  void drawEffectJ(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY) {}
   
  void draw(float mouseX, float mouseY, boolean mousePressed)
  {
    switch(currentTool)
    {
    case 'A':
      drawEffectA(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'B':
      drawEffectB(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'C':
      drawEffectC(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'D':
      drawEffectD(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'E':
      drawEffectE(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'F':
      drawEffectF(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'G':
      drawEffectG(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'H':
      drawEffectH(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'I':
      drawEffectI(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    case 'J':
      drawEffectJ(mouseX, mouseY, mousePressed, pmouseX, pmouseY);
      break;
    }

    pmouseX = mouseX;
    pmouseY = mouseY;
  }
  
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

void drawGrid(CanvasBase canvas, float yTranslate)
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
      xZoomed = round(xZoomed); // Makes no sense, but fixes a grid-drawing bug
      
      if (xZoomed >= 0 && xZoomed < width)
      {
        for (int y = (int)yTranslate; y < height; ++y)
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
      
      if (yZoomed >= 0 && yZoomed < height - yTranslate)
      {
        yZoomed += yTranslate;
        yZoomed = round(yZoomed);  // Makes no sense, but fixes a grid-drawing bug
        
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

PGraphics imageZoomIn;
PGraphics imageZoomOut;

void setupZoomCursors(PFont font)
{
  imageZoomIn = createGraphics(32,32,JAVA2D);
  imageZoomIn.beginDraw();
  imageZoomIn.fill(0);
  imageZoomIn.textFont(font, 48);
  imageZoomIn.text('+', 0, 32);
  imageZoomIn.endDraw();

  imageZoomOut = createGraphics(32,32,JAVA2D);
  imageZoomOut.beginDraw();
  imageZoomOut.fill(0);
  imageZoomOut.textFont(font,64);
  imageZoomOut.text('-', 0, 32);
  imageZoomOut.endDraw();
}

class ZoomButton extends Button
{
  ZoomButton(char key, float zoomFactor, CanvasBase myCanvas)
  {
    super(key);
    m_zoomFactor = zoomFactor;
    canvasBase = myCanvas;
  }

  void mousePressedOnCanvas()
  {
    canvasBase.zoom(mouseX, mouseY - Button.height, m_zoomFactor);
  }

  void setCursor()
  {
    if (m_zoomFactor > 1)
      cursor(imageZoomIn);
    else
      cursor(imageZoomOut);
  }

  float m_zoomFactor;
  CanvasBase canvasBase;
};

class PanButton extends Button
{
  PanButton(char key, CanvasBase myCanvas)
  {
    super(key);
    canvasBase = myCanvas;
  }

  void mouseDraggedOnCanvas()
  {
    canvasBase.pan(mouseX - pmouseX, mouseY - pmouseY);
  }

  boolean drawIcon()
  {
    noFill();
    stroke(0);
    strokeWeight(1);
    
    pushMatrix();

    translate(Button.width/2, Button.height/2);
    
    int buttonRadius = (Button.width > Button.height) ? Button.height : Button.width;
    buttonRadius /= 2;

    int margin = 10;
    int head = 5;
    
    for (int n = 0; n < 4; ++n)
    {
      noSmooth();
      line(buttonRadius-margin, 0, 0, 0);
      smooth();
      line(buttonRadius-margin, 0, buttonRadius-margin-6, -4);
      line(buttonRadius-margin, 0, buttonRadius-margin-6,  4);
      
      if (n == 1)
        rotate(HALF_PI);
      else
        scale(-1,1);
    }

    popMatrix();

    return true;
  }

  void setCursor()
  {
    cursor(MOVE);
  }

  CanvasBase canvasBase;
};


class UndoButton extends Button
{
  UndoButton(char key, CanvasBase myCanvas)
  {
    super(key);
    canvasBase = myCanvas;
  }

  void buttonPressed(int mouseButton)
  {
    canvasBase.undo();
  }
  
  boolean drawIcon()
  {
    int head = 10;

    strokeWeight(3);
    if (canvasBase.canUndo())
      stroke(0,0,255);
    else
      stroke(160);
    smooth();
    noFill();
    float arcHeight = height * 0.5;
    arc(width * 0.2 + 3, (height + arcHeight) * 0.5, width, arcHeight, 1.5 * PI, TWO_PI);
    line(width * 0.2, height * 0.5, (width * 0.2) + head, (height * 0.5) + head);
    line(width * 0.2, height * 0.5, (width * 0.2) + head, (height * 0.5) - head);

    return true;
  }

  CanvasBase canvasBase;
};

class RedoButton extends Button
{
  RedoButton(char key, CanvasBase myCanvas)
  {
    super(key);
    canvasBase = myCanvas;
  }

  void buttonPressed(int mouseButton)
  {
    canvasBase.redo();
  }

  boolean drawIcon()
  {
    int head = 10;

    strokeWeight(3);
    if (canvasBase.canRedo())
      stroke(0,0,255);
    else
      stroke(160);
    smooth();
    noFill();
    float arcHeight = height * 0.5;
    arc(width * 0.8 - 3, (height + arcHeight) * 0.5, width, arcHeight, PI, 1.5 * PI);
    line(width * 0.8, height * 0.5, (width * 0.8) - head, (height * 0.5) + head);
    line(width * 0.8, height * 0.5, (width * 0.8) - head, (height * 0.5) - head);

    return true;
  }

  CanvasBase canvasBase;
};


