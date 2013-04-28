
PImage img;
LugPoints lugPoints;

void setup()
{
  size(480, 640);
  rectMode(RADIUS);
  
  lugPoints = new LugPoints(this);
  
  img = loadImage("pic.jpg");
  image(img, 0, 0, width, height);
}

void draw()
{
  image(img, 0, 0, width, height);
  
  beginShape(LINES);
  pv_vertex(lugPoints.getNamed("test", 100, 100));  
  endShape();
  
  lugPoints.activate("test", true);
  lugPoints.draw();
}

void mousePressed()
{
  lugPoints.mousePressed(mouseX, mouseY);
}

void mouseDragged()
{
  lugPoints.mouseDragged(mouseX, mouseY);
}


