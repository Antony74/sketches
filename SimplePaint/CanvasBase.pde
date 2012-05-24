
class CanvasBase extends PGraphicsJava2D
{
  void setup()
  {
    beginDraw();
    background(255);
    endDraw();
  }
  
  void draw(float mouseX, float mouseY, boolean mousePressed) {}
  
  void doDraw()
  {
    boolean mouseOnCanvas = (toolbar.hitTest(mouseX, mouseY) == false);

    beginDraw();
    draw(mouseX, mouseY - Button.height, mouseOnCanvas && mousePressed);
    endDraw();
  }
  
  void zoom(float x, float y, float zoomFactor)
  {
    println(x);
  }
};

class ZoomButton extends Button
{
  ZoomButton(char key, float zoomFactor)
  {
    cKey = key;
    m_zoomFactor = zoomFactor;
  }

  void action()
  {
    currentTool = cKey;
  }

  boolean isPicked() {return currentTool == cKey;}

  void mousePressed()
  {
    canvas.zoom(mouseX, mouseY, m_zoomFactor);
  }

  float m_zoomFactor;
};


