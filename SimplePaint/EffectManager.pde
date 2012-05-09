
PVector pvButtonSize = new PVector(50,50);

EffectManager effectManager = new EffectManager();
PFont toolbarFont;

class EffectManager extends PGraphics
{
  public class EffectInner
  {
  };

  void addEffect(Effect effect)
  {
    effect.index = vecEffects.size();
    vecEffects.add(effect);
  }

  Effect getEffect(char c)
  {
    c = toUpperCase(c);

    for (int n = 0; n < vecEffects.size(); ++n)
    {
      Effect eff = vecEffects.get(n);
      if (eff.effectKey == c)
      {
        return eff;
      }
    }

    return null;
  }

  void action(char actionChar)
  {
    Effect effect = getEffect(actionChar);
    if (effect != null)
    {
      effect.action();
    }
  }

  void draw()
  {
  }

  char toUpperCase(char mixed)
  {
      if (mixed >= 'a' && mixed <= 'z')
      {
        return (char)(mixed - 'a' + 'A');
      }
      else
      {
        return mixed;
      }
  }

  void mousePressed()
  {
    if (mouseButton == LEFT && mouseY < pvButtonSize.y)
    {
      int button = int(mouseX / pvButtonSize.x);

      if (button >= 0 && button < vecEffects.size())
      {
        vecEffects.elementAt(button).action();
      }
    }
  }

  private Vector<Effect> vecEffects = new Vector<Effect>();
};

class Effect extends EffectManager.EffectInner
{
  Effect()
  {
    effectManager.super();
  }

  void setup() {}
  void draw() {}
  void action() {}
  boolean isPicked() {return false;}
  
  boolean isPressed()
  {
    if (keyPressed)
    {
        if (effectManager.toUpperCase(key) == effectKey)
        {
          return true;
        }
    }
    
    if (mousePressed && (mouseButton == LEFT))
    {
      float x = index * pvButtonSize.x;
      if (mouseY > 0 && mouseY < pvButtonSize.y && mouseX > x && mouseX < x + pvButtonSize.x)
      {
        return true;
      }
    }

    return false;
  }

  char effectKey = '\0';
  int index = -1;
};

void drawToolbar()
{
  pushStyle();

  stroke(0);
  strokeWeight(1);
  fill(255);

  rect(0, 0, width, pvButtonSize.y);

  for (int n = 0; n < effectManager.vecEffects.size(); ++n)
  {
    Effect effect = effectManager.vecEffects.elementAt(n);
    drawButton(n * pvButtonSize.x, effect);
  }

  popStyle();
}

void drawButton(float x, Effect effect)
{
  if (effect.isPressed())
  {
    fill(255, 0, 0);
  }
  else if (effect.isPicked())
  {
    fill(200, 200, 0); // dirty ugly yellow color which all my other colors show up against
  }
  else
  {
    fill(200);
  }
  
  stroke(0);
  strokeWeight(1);
  rect(x, 0, pvButtonSize.x, pvButtonSize.y);

  boolean iconDrawn = false;
  
  if (keyPressed == false || key != CODED || keyCode != ALT)
  {
    iconDrawn = drawIcon(x, effect);
  }
  
  if (iconDrawn == false)
  {
    drawSimpleIcon(x, effect);
  }
}

void drawSimpleIcon(float x, Effect effect)
{
  fill(0);
  stroke(0);
  strokeWeight(1);

  textFont(toolbarFont, 16);
  float nWidth = textWidth(effect.effectKey);
  text(effect.effectKey, x + (pvButtonSize.x * 0.5) - (nWidth * 0.5), (pvButtonSize.y * 0.5) + 8);
}


