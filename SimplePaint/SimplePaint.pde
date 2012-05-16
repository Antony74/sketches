
boolean pmousePressed = false;

char currentColor = 'K'; // Black
char currentBrush = '1';

Toolbar toolbar;

void setup()
{
  size(900,600);
  background(255);
  stroke(0);
  smooth();

  toolbar = new Toolbar();

  Button buttons[] = {
    new BrushButton('1', 1),
    new BrushButton('2', 2),
    new BrushButton('3', 4),
    new BrushButton('4', 8),
    new BrushButton('5', 14),
    new BrushButton('6', 24),
    new BrushButton('7', 41),
  
    new ColorButton('K', 0,     0,   0),
    new ColorButton('W', 255, 255, 255), // white
    new ColorButton('R', 255,   0,   0), // red
    new ColorButton('G', 0,   255,   0), // green
    new ColorButton('B', 0,     0, 255) // blue
  };

  toolbar.buttons = buttons;
  
}

class ColorButton extends Button
{
  ColorButton(char key, int r, int g, int b)
  {
    cKey = key;
    m_color = color(r,g,b);
  }
  
  void action()
  {
    currentColor = cKey;
    stroke(m_color);
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

class BrushButton extends Button
{
  BrushButton(char key, int weight)
  {
    cKey = key;
    m_weight = weight;
  }
  
  void action()
  {
    currentBrush = cKey;
    strokeWeight(m_weight);
  }

  boolean isPicked() {return currentBrush == cKey;}

  boolean drawIcon()
  {
    ColorButton ec = (ColorButton)toolbar.getButton(currentColor);
    
    strokeWeight(m_weight);
    stroke(ec.m_color);
    point(width * 0.5, height * 0.5);

    return true;
  }

  int m_weight;
}

void draw()
{
  if (toolbar.hitTest(mouseX, mouseY) == false)
  {
    if (mousePressed && pmousePressed)
    {
      line(pmouseX, pmouseY, mouseX, mouseY);
    }
    else if (mousePressed)
    {
      point(mouseX, mouseY);
    }
  }

  pmousePressed = mousePressed;
  
  toolbar.draw();
}

void keyTyped()
{
  toolbar.buttonPressed(key);
}

void mousePressed()
{
  toolbar.mousePressed();
}


