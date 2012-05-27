
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


