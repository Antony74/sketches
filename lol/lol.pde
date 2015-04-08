
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

RFont font;

void setup()
{
  size(480, 640);

  RG.init(this);

  font = new RFont( "FreeSansBold.ttf", 50);
}

void draw()
{
  PImage img = loadImage("brenin.jpg");
  
  image(img, 0, 0, width, height);
  
  stroke(0);
  strokeWeight(1);
  fill(255);
  noSmooth();

  pushMatrix();
  translate(45, 75);
  font.draw("Brand  \u2192");
  translate(0, 40);
  font.draw("new cat");
  translate(0, 40);
  font.draw("bed");
  popMatrix();
  
  translate(176, 418);
  font.draw("\u2190Cat");

  save("noremote.jpg");

  noLoop();
}

void mouseClicked()
{
  println(mouseX + ", " + mouseY);
}




