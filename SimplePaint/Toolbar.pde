
char currentTool;

class Button
{
  final static int width = 50;
  final static int height = 50;
  char cKey;
  Toolbar m_toolbar;

  Button(char key) {cKey = key;}
  void buttonPressed(int mouseButton) {currentTool = cKey;}
  boolean isPicked() {return currentTool == cKey;}
  boolean drawIcon() {return false;}
  void mousePressedOnCanvas() {}
  void mouseDraggedOnCanvas() {}

  void draw(boolean isPressed, PFont font)
  {
    if (isPressed)
    {
      fill(255, 0, 0);
    }
    else if (isPicked())
    {
      fill(200, 200, 0);
    }
    else
    {
      fill(200);
    }
    
    stroke(0);
    strokeWeight(1);
    rect(0, 0, width, height);
  
    boolean iconDrawn = false;
    
    if (keyPressed == false || key != CODED || keyCode != ALT)
    {
      iconDrawn = drawIcon();
    }
    
    if (iconDrawn == false)
    {
      drawSimpleIcon(font);
    }
  }
  
  void drawSimpleIcon(PFont font)
  {
    fill(0);
    stroke(0);
    strokeWeight(1);
  
    int nFontHeight = 32;
  
    textFont(font, nFontHeight);
    float nWidth = textWidth(cKey);
    text(cKey, (width * 0.5) - (nWidth * 0.5), (height * 0.40) + (nFontHeight * 0.5));
  }

  void setCursor()
  {
    cursor(ARROW);
  }
};

class Toolbar
{
  Toolbar()
  {
    font = loadFont("FreeSans-16.vlw");
  }

  void draw()
  {
    stroke(0);
    strokeWeight(1);
    fill(200);
  
    rect(0, 0, width, Button.height);
  
    pushMatrix();
    
    for (int n = 0; n < buttons.length; ++n)
    {
      Button button = buttons[n];
      button.draw(isPressed(n), font);
      translate(Button.width, 0);
    }

    popMatrix();  
  }

  void buttonPressed(char key)
  {
    Button button = getButton(key);
    if (button != null)
    {
      button.buttonPressed(LEFT);
    }
  }

  Button getButton(char key)
  {
    key = toUpperCase(key);

    for (int n = 0; n < buttons.length; ++n)
    {
      Button button = buttons[n];
      
      if (button.cKey == key)
      {
        return button;
      }
    }
    
    return null;
  }

  char toUpperCase(char key)
  {
      if (key >= 'a' && key <= 'z')
      {
        return (char)(key - 'a' + 'A');
      }
      else
      {
        return key;
      }
  }

  boolean hitTest(float x, float y)
  {
    return y < Button.height;
  }

  boolean mousePressed()
  {
    if (mouseY < Button.height)
    {
      int index = int(mouseX / Button.width);

      if (index >= 0 && index < buttons.length)
      {
        Button button = buttons[index];
        button.buttonPressed(mouseButton);
      }
      
      return true;
    }
    else
    {
      Button button = getButton(currentTool);
      if (button != null)
      {
        button.mousePressedOnCanvas();
      }
      
      return false;
    }
  }

  void mouseDragged()
  {
      Button button = getButton(currentTool);
      if (button != null)
      {
        button.mouseDraggedOnCanvas();
      }
  }

  void mouseMoved()
  {
    if (mouseY > Button.height)
    {
      Button button = getButton(currentTool);
      if (button != null)
      {
        button.setCursor();
      }
    }
    else
    {
      cursor(ARROW);
    }
  }

  boolean isPressed(int index)
  {
    if (keyPressed && index >= 0 && index < buttons.length)
    {
        Button button = buttons[index];
      
        if (toUpperCase(key) == button.cKey)
        {
          return true;
        }
    }
    
    if (mousePressed && (mouseButton == LEFT))
    {
      float x = index * Button.width;
      if (mouseY > 0 && mouseY < Button.height && mouseX > x && mouseX < x + Button.width)
      {
        return true;
      }
    }

    return false;
  }

  void setButtons(Button theButtons[])
  {
    for (int n = 0; n < theButtons.length; ++n)
    {
      theButtons[n].m_toolbar = this;
    }

    buttons = theButtons;
  }

  Button buttons[];  
  PFont font;
};


