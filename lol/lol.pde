
// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

RFont font;

void setup()
{
  size(640, 480);

  RG.init(this);

  font = new RFont( "FreeSansBold.ttf", 50);
}

void draw()
{
  PImage img = loadImage("shandy.jpg");
  
  image(img, 0, 0, width, height);
  
  stroke(0);
  strokeWeight(1);
  fill(255);
  noSmooth();

  translate(25,75);
  font.draw("No you can't");
  
  translate(0,75);
  font.draw("haz remote");

  save("noremote.jpg");

  noLoop();
}


