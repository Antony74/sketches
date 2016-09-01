
float rect_radius = 10;

void setup()
{
  size(300, 300);
  rectMode(RADIUS);
  fill(255, 0, 0, 128);
  
  addPoint( 254 , 102 );
  addPoint( 226 , 63 );
  addPoint( 185 , 49 );
  addPoint( 146 , 74 );
  addPoint( 142 , 119 );
  addPoint( 117 , 169 );
  addPoint( 86 , 214 );
  addPoint( 40 , 200 );

  float a,b,c,d,e,f,g,h;
  
a =  199.58820651551;
b =  -282.729274733372;
c =  262.381286198212;
d =  68.7297914510659;
e =  687.752261379696;
f =  -739.350697299253;
g =  -46.382500063768;
h =  204.291098883492;

  for (float t = 0; t <= 1; t += 0.01)
  {
      float x = (a * t * t * t) + (b * t * t) + (c * t) + d;
      float y = (e * t * t * t) + (f * t * t) + (g * t) + h;

      point(x,y);
  }
}

void draw()
{
}

void mouseClicked()
{
  println("addPoint(", mouseX, ",", mouseY, ");");
  addPoint(mouseX, mouseY);
}

void addPoint(float x, float y)
{
  rect(x, y, rect_radius, rect_radius);
}
