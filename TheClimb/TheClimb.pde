
StickFigure stickFigure;
PImage background;

void setup() {
  size(800, 600);
  strokeWeight(18);
  stroke(0);
  fill(0);

  background = loadImage(sketchPath("background.png"));
  stickFigure = new StickFigure();
}

void draw() {
  image(background, 0, 0);
  stickFigure.draw();
  stickFigure.drawPoints();
}

void mousePressed() {
  stickFigure.mousePressed();
}

void mouseReleased() {
  stickFigure.mouseReleased();
}

void mouseDragged() {
  stickFigure.mouseDragged();
}