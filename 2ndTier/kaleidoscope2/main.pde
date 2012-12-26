
void setup()
{
  size(900,600);
}

void draw()
{
  smooth();
  noStroke();
 
  randomSeed(1);
  
  for (int n = 0; n < 1000; ++n)
  {
    fill(random(255), random(255), random(255));
    ellipse(random(width), random(height), random(100), random(100));
  }
  
  loadPixels();
  
  applyMirrorEffect(pixels, width, height, 1, 1, -mouseY-mouseX, false);

  updatePixels();
}


