
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