
// Currently need to uncomment this to run in Java
//float eval(String sCode) {return 0.0;}

Object world;
final int SCALE = 30;

void setup()
{
  size(900,500);

  String sCode = "worldInit(" + width + ", " + height + ", " + SCALE + ");";  

  eval(sCode);
}

boolean bFirstTime = true;

void draw()
{
  background(128);

  eval("worldStep();");
  
  float bMore = eval("worldGetFirstBody();");
  
  while (bMore != 0.0)
  {
     float x = eval("body.GetPosition().x");
     float y = eval("body.GetPosition().y");
     float radius = eval("body.GetUserData();");
     float angle = eval("body.GetAngle();");
    
     yinYang(x * SCALE, y * SCALE, radius * SCALE * 2.0, angle);
     
     bMore = eval("worldGetNextBody();");
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


