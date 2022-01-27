float radius = 500;
float xCenter = 100;
float yCenter = 300 - radius;

float pointSize = 5;

PFont myFont;

enum EPos {
  below,
  above,
  left,
  right
}

void label(EPos pos, int n, float x, float y) {
  pushStyle();
  stroke(0);
  fill(0);
  float textHeight = 25;
  textSize(textHeight);

  float tWidth = textWidth("t");
  x -= tWidth;
  
  switch(pos)
  {
    case above:
      y -= pointSize * 3;
      break;
    case below:
      y += textHeight;
      break;
    case left:
      x -= pointSize * 4;
      break;
    case right:
      x += pointSize * 4;
      y += textHeight * 0.5;
      break;
  }

  text('t', x, y);
  
  textSize(textHeight * 0.75);
  x += tWidth;
  y += 5;
  text(String.valueOf(n), x, y);
  
  popStyle();
}

void setup() {
  size(1280, 800);
  background(255);
  ellipseMode(RADIUS);

  myFont = createFont("Arial", 32);
  textFont(myFont);

  stroke(128);
  noFill();
  
  strokeWeight(5);
  ellipse(xCenter, yCenter, radius, radius);
  line(850, 100, 950, 100);  

  strokeWeight(1);
  stroke(0);
    
  for (int n = 0; n < 6; ++n) {
    float step = 90;
    float radialStep = step / radius;
    float angle = HALF_PI - (n * radialStep);
    float x = xCenter + (radius * cos(angle));
    float y = yCenter + (radius * sin(angle));
    
    ellipse(x, y, pointSize, pointSize);
    label(EPos.above, n, x, y);

    x = xCenter + (n * step);
    y = yCenter + radius;
    
    ellipse(x, y, pointSize, pointSize);
    label(EPos.below, n, x, y);

    float fallen = 15 * n * n;
    x = 900;
    y = 100 + fallen;
    
    ellipse(x, y, pointSize, pointSize);
    label(n == 0 ? EPos.above : EPos.right, n, x, y);
 }

  textSize(53);
  text("Falling off a ringworld vs. falling off Cloud City", 100, 700);
  
  saveFrame("ringworld.png");
}
