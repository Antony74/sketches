
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
  ZoomButton(char key, float zoomFactor)
  {
    super(key);
    m_zoomFactor = zoomFactor;
  }

  void mousePressedOnCanvas()
  {
    canvas.zoom(mouseX, mouseY - Button.height, m_zoomFactor);
  }

  void setCursor()
  {
    if (m_zoomFactor > 1)
      cursor(imageZoomIn);
    else
      cursor(imageZoomOut);
  }

  float m_zoomFactor;
};

class PanButton extends Button
{
  PanButton(char key)
  {
    super(key);
  }

  void mouseDraggedOnCanvas()
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

  void setCursor()
  {
    cursor(MOVE);
  }

};


