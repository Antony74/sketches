import processing.video.*;

Capture video;

PImage buffer[];

int nFrame = 0;
int nSkipped = 0;
int nSave = 0;
int nSaveSkip = 0;

void setup()
{
  size(640, 480);
  colorMode(HSB);
  
  video = new Capture(this,width,height,15);
  video.start();
  
  buffer = new PImage[5];
  for (int n = 0; n < buffer.length; ++n)
  {
    buffer[n] = new PImage(width, height);
    buffer[n].loadPixels();
  }
}

void draw()
{
  if (video.available())
  {
    video.read();

    if (nSkipped % 1 == 0)
    {
      loadPixels();
      video.loadPixels();
      
      if (nFrame >= buffer.length)
      {
        for (int nPixel = 0; nPixel < pixels.length; ++nPixel)
        {
          float h = 0;
          float s = 0;
          float b = 0;

          buffer[nFrame % buffer.length].pixels[nPixel] = video.pixels[nPixel];
          
          for (int n = 0; n < buffer.length; ++n)
          {
//            h += hue(buffer[n].pixels[nPixel]);
//            s += saturation(buffer[n].pixels[nPixel]);
            b += brightness(buffer[n].pixels[nPixel]);
          }
          
//          h /= buffer.length;
//          s /= buffer.length;
          b /= buffer.length;
          
//          s *= 0.9;
          b *= 0.7; 
          
          pixels[nPixel] = color(b);
        }
      }

      ++nFrame;
      updatePixels();
      filter(BLUR, 0.5);
    }
    
    ++nSkipped;
  }  

  if (nSaveSkip % 1 == 0 && nSave > 1)
  {
    saveFrame("me-######.png");
    --nSave;
    println(frameCount);
  }

  ++nSaveSkip;
}

void keyPressed()
{
  nSave = 5;
}


