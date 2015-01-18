
PImage img1;
PVector sizeCaption = new PVector(300, 150);
int nZoom = 3;

void setup()
{
  size(1800, 900);
  rectMode(CENTER);
  
  img1 = loadImage("sketch1.png");
}

void copy(PImage imgSrc, PImage imgDest, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh)
{
  imgDest.copy(imgSrc, (int)sx, (int)sy, (int)sw, (int)sh, (int)dx, (int)dy, (int)dw, (int)dh);
}

void draw()
{
  background(255);
  noSmooth();

  PGraphics pgFreeSpeech = freeSpeech();

  pushMatrix();
  scale(3);
  freeSpeechfreeHand(g);
  image(pgFreeSpeech, 0, 0);
  popMatrix();
  
  pushMatrix();
  scale(3);
  translate(0, sizeCaption.y);
  freeSpeechfreeHand(g);
  popMatrix();

  pushMatrix();
  scale(3);
  translate(sizeCaption.x, 0);
  image(pgFreeSpeech, 0, 0);
  popMatrix();

  pushMatrix();
  translate(sizeCaption.x * (nZoom + 1), sizeCaption.y * (nZoom + 1));
  image(pgFreeSpeech, 0, 0);
  popMatrix();

  noLoop();
}

void mouseClicked()
{
  print(mouseX / nZoom);
  print(", ");
  println(mouseY / nZoom);
}

void freeSpeechfreeHand(PImage img)
{
  copy(img1, img, 230, 440, sizeCaption.x, sizeCaption.y, 0, 0, sizeCaption.x, sizeCaption.y);
}

int brighten(int n)
{
  return (n + 255) / 2;
}

void ish(PGraphics img)
{
  PVector pvPos = new PVector(200, 13);
  PVector pvSize  = new PVector(50,  42);
  copy(img1, img, 1306, 400, pvSize.x, pvSize.y, pvPos.x, pvPos.y, pvSize.x, pvSize.y);
  
  for(int x = (int)pvPos.x; x < pvPos.x + pvSize.x; x += 1)
  {
    for(int y = (int)pvPos.y; y < pvPos.y + pvSize.y; y += 1)
    {
      color c = img.get(x, y);
      
      if (red(c) < 200)
      {
        float nFactor = 0.25;
        c = color(red(c) * nFactor, green(c) * nFactor, blue(c) * nFactor);
        img.set(x, y, c);
      }
    }
  }

}

Composite letterF = (new Composite())
                      .vertex(new Vertex("A", 90, 16))
                      .vertex(new Vertex("B", 68, 18))
                      .vertex(new Vertex("C", 68, 56))
                      .vertex(new Vertex("D", 88, 32))
                      .vertex(new Vertex("E", 68, 34))
                      .line("ABC")
                      .line("DE");

Composite letterR = (new Composite())
                      .vertex(new Vertex("A", 114, 17))
                      .vertex(new Vertex("B", 115, 53))
                      .vertex(new Vertex("C", 115, 31))
                      .vertex(new Vertex("D", 137, 48))
                      .vertex(new Vertex("g", 146,  9))
                      .vertex(new Vertex("h", 147, 31))
                      .line("AB")
                      .bezier("AghC")
                      .line("CD");

Composite letterP = (new Composite())
                      .vertex(new Vertex("A", 114, 17))
                      .vertex(new Vertex("B", 115, 53))
                      .vertex(new Vertex("C", 115, 31))
                      .vertex(new Vertex("D", 137, 48))
                      .vertex(new Vertex("g", 146,  9))
                      .vertex(new Vertex("h", 147, 31))
                      .line("AB")
                      .bezier("AghC");

Composite letterE = (new Composite())
                      .vertex(new Vertex("A", 180, 16))
                      .vertex(new Vertex("B", 163, 17))
                      .vertex(new Vertex("C", 164, 50))
                      .vertex(new Vertex("D", 181, 50))
                      .vertex(new Vertex("E", 174, 32))
                      .vertex(new Vertex("F", 164, 33))
                      .line("ABCD")
                      .line("EF");
                      
Composite letterS = (new Composite())
                      .vertex(new Vertex("A", 50,  88))
                      .vertex(new Vertex("b",  9, 105))
                      .vertex(new Vertex("c", 84, 118))
                      .vertex(new Vertex("D", 32, 128))
                      .bezier("AbcD");
                      
Composite letterC = (new Composite())
                      .vertex(new Vertex("A", 216,  95))
                      .vertex(new Vertex("b", 196,  97))
                      .vertex(new Vertex("c", 196, 123))
                      .vertex(new Vertex("D", 216, 127))
                      .bezier("AbcD");                      

Composite letterH = (new Composite())
                      .vertex(new Vertex("A", 244,  89))
                      .vertex(new Vertex("B", 242, 123))
                      .vertex(new Vertex("C", 258,  89))
                      .vertex(new Vertex("D", 260, 121))
                      .vertex(new Vertex("E", 242, 107))
                      .vertex(new Vertex("F", 260, 106))
                      .line("AB")
                      .line("CD")
                      .line("EF");
                      
PGraphics freeSpeech()
{
  PGraphics g = createGraphics((int)sizeCaption.x, (int)sizeCaption.y);
  g.beginDraw();

  // First line

  g.pushMatrix();

  block(g, letterF);
  g.translate(-10, 0);
  block(g, letterR);
  g.translate(-10, 0);
  block(g, letterE);
  g.translate(-10, 0);

  g.pushMatrix();
  g.translate(43, 0);
  block(g, letterE);
  g.popMatrix();

  g.popMatrix();

  // second line

  g.pushMatrix();
  g.translate(0, -10);

  block(g, letterS);
  g.translate(-12, 0);

  g.pushMatrix();
  g.translate(-30, 73);
  block(g, letterP);
  g.popMatrix();

  g.pushMatrix();
  g.translate(-40, 77);
  block(g, letterE);
  g.translate(43, 0);
  g.translate(-8, 0);
  block(g, letterE);
  g.popMatrix();
  g.translate(-14, 0);

  block(g, letterC);
  g.translate(-10, 0);
  block(g, letterH);

  g.popMatrix();

  ish(g);

  g.endDraw();

  return g;
}

void block(PGraphics g, Composite comp)
{
  g.noStroke();
  g.fill(0);
  
  for (float t = 0.0; t <= 1.0; t += 0.01)
  {
    PVector pv = comp.point(t);
    g.ellipse(pv.x, pv.y, 10, 10);
  }

}


