
final int SCALE = 30;

void setup()
{
  size(900,500);
  smooth();

  String sCode;

  if (getIsJava())
  {
    Context cx = Context.enter();
    
    // Rhino's default mode of operation is to compile JavaScipt into JVM-byte-code and run it.
    // Remove these optimizations and make it run in interpreted mode instead.
    // There are two reasons for doing this.
    // 1. You can't put self-modifying byte-code in a Java applet... I can see why that might be a security concern ;-)
    // 2. Once we're up and running we feed Rhino a lot of throw away stuff to evaluate, so we actually get better
   //     performance by not bothering to compile everything first.
    cx.setOptimizationLevel(-1);
    
    context = cx;
    scope = cx.initStandardObjects();
  
    sCode = getFileAsString("Box2dWeb_2_1_a_3.js");
    evaluate(sCode);
  
    sCode = getFileAsString("YinYang.js");
    evaluate(sCode);
  }

  sCode = "worldInit(" + width + ", " + height + ", " + SCALE + ");"; 

  evaluate(sCode);
}

void draw()
{
  background(128);

  evaluate("worldStep();");
  
  boolean bMore = Boolean.valueOf(evaluate("worldGetFirstBody();"));
  
  while (bMore)
  {
     float x = Float.parseFloat(evaluate("body.GetPosition().x"));
     float y = Float.parseFloat(evaluate("body.GetPosition().y"));
     float radius = Float.parseFloat(evaluate("body.GetUserData();"));
     float angle = Float.parseFloat(evaluate("body.GetAngle();"));
    
     yinYang(x * SCALE, y * SCALE, radius * SCALE * 2.0, angle);
     
     bMore = Boolean.valueOf(evaluate("worldGetNextBody();"));
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


