
final int SCALE = 30;

void setup()
{
  size(900,500);
  smooth();
  
  initJS();
  
  importJS("Box2dWeb_2_1_a_3.js");
  importJS("YinYang.js");
  
  String sCode = "worldInit(" + width + ", " + height + ", " + SCALE + ");"; 
  // i.e. worldInit(900, 500, 30);

  evaluateJS(sCode);
}

void draw()
{
  background(128);

  evaluateJS("worldStep();");
  
  boolean bMore = Boolean.valueOf(evaluateJS("worldGetFirstBody();"));
  
  while (bMore)
  {
     float x = Float.parseFloat(evaluateJS("body.GetPosition().x"));
     float y = Float.parseFloat(evaluateJS("body.GetPosition().y"));
     float radius = Float.parseFloat(evaluateJS("body.GetUserData();"));
     float angle = Float.parseFloat(evaluateJS("body.GetAngle();"));
    
     yinYang(x * SCALE, y * SCALE, radius * SCALE * 2.0, angle);
     
     bMore = Boolean.valueOf(evaluateJS("worldGetNextBody();"));
  }
}

void yinYang(float x, float y, float diameter, float angle)
{
  pushMatrix();
  translate(x,y);
  rotate(angle);
  
  float radius = diameter / 2.0;
  float q = diameter / 4.0;
  float e = diameter / 8.0;
  
  stroke(0);

  fill(255);
  arc(0, 0, diameter, diameter, 0, PI);
 
  fill(0);
  arc(0, 0, diameter, diameter, PI, TWO_PI);

  noStroke();
  
  ellipse(0 - q, 0, radius, radius);

  fill(255);
  ellipse(0 + q, 0, radius, radius);

  ellipse(0 - q, 0, e, e);

  fill(0);
  ellipse(0 + q, 0, e, e);

  popMatrix();
}


