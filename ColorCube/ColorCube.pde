
int step = 255;
int mode = RGB;

void setup()
{
  size(600,600);
  noStroke();
}

void draw()
{
  background(128);
  
  int cubeSize = (255 / step) + 1;
  int sliceSize = width / (ceil(sqrt(cubeSize)));
  int blockSize = (sliceSize - 4) / cubeSize;
  
  int x = 0;

  pushMatrix();
  for (int r = 0; r <= 255; r += step)
  {
    pushMatrix();
    for (int g = 0; g <= 255; g += step)
    {
      pushMatrix();
      for (int b = 0; b <= 255; b += step)
      {
        fill(r,g,b);
        rect(0,0,blockSize,blockSize);
        translate(blockSize, 0);
      }
      popMatrix();
      translate(0, blockSize);
    }
    popMatrix();

    x += sliceSize;
    
    if (x + sliceSize > width)
    {
      popMatrix();
      x = 0;
      translate(0, sliceSize);
      pushMatrix();
    }
    else
    {
      translate(sliceSize, 0);
    }
  }
  popMatrix();
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    if (step <= 7)
      step = 255;
    else
      step /= 2;
  }
  else if (mouseButton == RIGHT)
  {
    if (mode == RGB)
    {
      mode = HSB;
    }
    else
    {
      mode = RGB;
    }
    colorMode(mode);
  }
}

