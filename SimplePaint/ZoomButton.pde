
class ZoomButton extends Button
{
  ZoomButton(char key, float zoomFactor)
  {
    cKey = key;
    m_zoomFactor = zoomFactor;
  }

  void action(int mouseButton)
  {
    currentTool = cKey;
  }

  boolean isPicked() {return currentTool == cKey;}

  void mousePressed()
  {
    canvas.zoom(mouseX, mouseY - Button.height, m_zoomFactor);
  }

  float m_zoomFactor;
};

class PanButton extends Button
{
  PanButton(char key)
  {
    cKey = key;
  }

  void action(int mouseButton)
  {
    currentTool = cKey;
  }

  boolean isPicked() {return currentTool == cKey;}

  void mouseDragged()
  {
    canvas.pan(mouseX - pmouseX, mouseY - pmouseY);
  }
};


