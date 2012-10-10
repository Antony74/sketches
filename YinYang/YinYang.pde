
final int SCALE = 30;

void setup()
{
  size(900,500);
  smooth();

  String sCode;

  if (getIsJava())
  {
    Context cx = Context.enter();
    context = cx;
    scope = cx.initStandardObjects();
  
    sCode = getFileAsString(savePath("Box2dWeb_2_1_a_3.js"));
    evaluate(sCode);
  
    sCode = getFileAsString(savePath("YinYang.js"));
    evaluate(sCode);
  }

  sCode = "worldInit(" + width + ", " + height + ", " + SCALE + ");"; 
  evaluate(sCode);
}

void draw()
{
  background(128);

  evaluate("worldStep();");
  
  boolean bMore = evaluateBoolean("worldGetFirstBody();");
  
  while (bMore)
  {
     float x = evaluateFloat("body.GetPosition().x");
     float y = evaluateFloat("body.GetPosition().y");
     float radius = evaluateFloat("body.GetUserData();");
     float angle = evaluateFloat("body.GetAngle();");
    
     yinYang(x * SCALE, y * SCALE, radius * SCALE * 2.0, angle);
     
     bMore = evaluateBoolean("worldGetNextBody();");
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


