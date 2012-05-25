
class BrushButton extends Button
{
  BrushButton(char key, int weight)
  {
    cKey = key;
    m_weight = weight;
  }
  
  void action(int mouseButton)
  {
    currentTool = cKey;
  }

  boolean isPicked() {return currentTool == cKey;}

  boolean drawIcon()
  {
    ColorButton ec = (ColorButton)toolbar.getButton(currentColor);
    
    strokeWeight(m_weight);
    stroke(ec.m_color);
    point(width * 0.5, height * 0.5);

    return true;
  }

  int m_weight;
};

