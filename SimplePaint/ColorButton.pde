
boolean showColorWheel = false;

boolean drawColorWheel(Toolbar toolbar)
{
  if (showColorWheel == true)
  {
    colorWheel.draw();
    image(colorWheel, 0, Button.height);
    
    ColorButton button = (ColorButton)toolbar.getButton(currentColor);
    button.m_color = color(colorWheel.getRed(), colorWheel.getGreen(), colorWheel.getBlue());    
    
    return true;
  }
  else
  {
    return false;
  }
}

class ColorButton extends Button
{
  ColorButton(char key, int r, int g, int b)
  {
    cKey = key;
    m_color = color(r,g,b);
  }
  
  void buttonPressed(int mouseButton)
  {
    if (mouseButton == RIGHT)
    {
      showColorWheel = true;
    }

    colorWheel.setHSB(hue(m_color),saturation(m_color),brightness(m_color));
    currentColor = cKey;
    currentTool = currentBrush;
  }

  boolean isPicked()
  {
    return currentColor == cKey;
  }

  boolean drawIcon()
  {
    noStroke();
    fill(m_color);
    
    int margin = 5;
    rect(margin, margin, width - margin - margin, height - margin - margin);

    return true;
  }
  
  color m_color;
}


