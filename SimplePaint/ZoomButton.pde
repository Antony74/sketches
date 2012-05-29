
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

};


