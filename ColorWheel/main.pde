
PFont font;

void setup()
{
  size(900,600);
  colorWheel.setSize(width, height);
  colorWheel.setup();
  colorWheel.setHSB(255,255,255);

  font = loadFont("FreeMono-16.vlw");
}

void draw()
{
  colorWheel.draw();
  image(colorWheel, 0, 0);
  
  noStroke();
  fill(colorWheel.getRed(), colorWheel.getGreen(), colorWheel.getBlue());
  rect(0,0,150,400);
  
  int h  = round(colorWheel.getHue());
  int s  = round(colorWheel.getSaturation());
  int br = round(colorWheel.getBrightness());
  int r  = round(colorWheel.getRed());
  int g  = round(colorWheel.getGreen());
  int bl = round(colorWheel.getBlue());
  
  // Yes, I'm breaking the guidelines about how to construct a string efficiently :-)
  String sInfo = "       Hue: " + pad(h)  + " (0x" + hex(h,2)  + ")\n"
               + "Saturation: " + pad(s)  + " (0x" + hex(s,2)  + ")\n"
               + "Brightness: " + pad(br) + " (0x" + hex(br,2) + ")\n\n"
               + "       Red: " + pad(r)  + " (0x" + hex(r,2)  + ")\n"
               + "     Green: " + pad(g)  + " (0x" + hex(g,2)  + ")\n"
               + "      Blue: " + pad(bl) + " (0x" + hex(bl,2) + ")";

  fill(0);
  textFont(font);
  text(sInfo, 10, height * 0.75);

}

String pad(int n)
{
  String s = str(n);
  switch (s.length())
  {
  case 1:
    s = "  " + s;
    break;
  case 2:
    s = " " + s;
    break;
  }

  return s;
}

void mousePressed()
{
  colorWheel.mousePressed(mouseX, mouseY, mouseButton);
}


