
boolean pmousePressed = false;

char currentColor = 'K'; // Black
char currentBrush = '1';

void setup()
{
  size(900,600);
  background(255);
  stroke(0);
  smooth();
  
  toolbarFont = loadFont("FreeSans-16.vlw");

  effectManager.addEffect(new BrushEffect('1', 1));
  effectManager.addEffect(new BrushEffect('2', 2));
  effectManager.addEffect(new BrushEffect('3', 4));
  effectManager.addEffect(new BrushEffect('4', 8));
  effectManager.addEffect(new BrushEffect('5', 14));
  effectManager.addEffect(new BrushEffect('6', 24));
  effectManager.addEffect(new BrushEffect('7', 41));

  effectManager.addEffect(new EffectColor('K', 0,     0,   0));  // black
  effectManager.addEffect(new EffectColor('W', 255, 255, 255));  // white
  effectManager.addEffect(new EffectColor('R', 255,   0,   0));  // red
  effectManager.addEffect(new EffectColor('G', 0,   255,   0));  // green
  effectManager.addEffect(new EffectColor('B', 0,     0, 255));  // blue
}

class EffectColor extends Effect
{
  EffectColor(char key, int r, int g, int b)
  {
    effectKey = key;
    m_color = color(r,g,b);
  }
  
  void action()
  {
    currentColor = effectKey;
    effectManager.stroke(m_color);  // Is different to stroke(m_color) unqualified.  Bang goes that theory.  Drat and double drat.
  }

  boolean isPicked()
  {
    return currentColor == effectKey;
  }
  
  color m_color;
}

class BrushEffect extends Effect
{
  BrushEffect(char key, int weight)
  {
    effectKey = key;
    m_weight = weight;
  }
  
  void action() {currentBrush = effectKey;}
  boolean isPicked() {return currentBrush == effectKey;}

  int m_weight;
}

void draw()
{
  if (mousePressed && pmousePressed)
  {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  else if (mousePressed)
  {
    point(mouseX, mouseY);
  }

  pmousePressed = mousePressed;
  
  drawToolbar();
  effectManager.draw();
}

void keyTyped()
{
  effectManager.action(key);
}

void mousePressed()
{
  effectManager.mousePressed();
}

boolean drawIcon(float x, Effect effect)
{
  if (effect instanceof EffectColor)
  {
    EffectColor ec = (EffectColor)effect;
    noStroke();
    
    fill(ec.m_color);
    
    int margin = 3;
        
    rect(x + margin, margin, pvButtonSize.x - margin - margin, pvButtonSize.y - margin - margin);
    
    return true;
  }

  if (effect instanceof BrushEffect)
  {
    BrushEffect be = (BrushEffect)effect;
    EffectColor ec = (EffectColor)effectManager.getEffect(currentColor);
    
    strokeWeight(be.m_weight);
    stroke(ec.m_color);
    point(x + (pvButtonSize.x * 0.5), pvButtonSize.y * 0.5);
    
    return true;
  }
  
  return false;
}


