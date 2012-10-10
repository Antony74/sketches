
Object world;
final int SCALE = 30;

void setup()
{
  size(900,500);

  worldInit(width, height, SCALE);  
}

boolean bFirstTime = true;

void draw()
{
  background(128);

  worldStep();
  
  boolean bMore = eval("worldGetFirstBody();");
  
  while (bMore)
  {
     yinYang(body.GetPosition().x * SCALE, body.GetPosition().y * SCALE, body.GetUserData() * SCALE * 2.0, body.GetAngle());
     
     bMore = eval("worldGetNextBody();");
  }
}

void yinYang(double x, double y, double diameter, double angle)
{
  pushMatrix();
  translate(x,y);
  rotate(angle);
  
  double radius = diameter / 2.0;
  double q = diameter / 4.0;
  double e = diameter / 8.0;
  
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


