
float rect_radius = 10;

void setup()
{
  size(300, 300);
  rectMode(RADIUS);
  fill(255, 0, 0, 128);
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