
PImage img;

void setup() {
  size(300, 300);
  
  // Draw a fan of colors

  translate(width/2, height/2);
  colorMode(HSB);
  background(128);
  strokeWeight(15);

  float radius = 0.45 * width;
  int spokes = 30;

  for (int n = 0; n < spokes; ++n) {
    stroke(255 * n / spokes, 255, 255);
    line(0, 0, radius*cos(n*TWO_PI/spokes), radius*sin(n*TWO_PI/spokes));
  }

  // Save as an image
  
  img = createImage(width, height, RGB);
  loadPixels();
  img.pixels = pixels;
  img.updatePixels();  

}

int toss() { 
    return (int)random(2); // returns either 0 or 1
}

void draw() {

  if (frameCount % 20 == 0) {
    PImage quarter = createImage(width/2, height/2, RGB);
    int x = toss() * width / 2;
    int y = toss() * height / 2;
    quarter.copy(img, x, y, width/2, height/2, 0, 0, width/2, height/2);
    x = toss() * width / 2;
    y = toss() * height / 2;
    image(quarter, x, y);
  }
}