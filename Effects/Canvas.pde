
class Canvas extends CanvasBase
{

  PImage setupEffectA()
  {
    return loadImage("SimplePaint.png");
  }
  
  void drawEffectA(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY)
  {
    if (mousePressed)
    {
      ellipse(mouseX, mouseY, pmouseX, pmouseY);
    }
  }

  PImage setupEffectB()
  {
    return null;
  }
  
  void drawEffectB(float mouseX, float mouseY, boolean mousePressed, float pmouseX, float pmouseY)
  {
  }

  // The framework has been set up so that you can carry on adding effects in the same way from A to J.
  
};


