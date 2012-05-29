
class CanvasBase extends PGraphicsJava2D
{
  void setup()
  {
    beginDraw();
    background(255);
    zoomedWidth = width;
    zoomedHeight = height;
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
  
  float pannedX = 0;
  float pannedY = 0;
  float zoomedWidth;
  float zoomedHeight;
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


