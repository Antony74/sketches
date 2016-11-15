
StickMan stickMan;
PImage background;

void setup() {
  size(800, 600);
  strokeWeight(12);

  background = loadImage(sketchPath("background.png"));
  stickMan = new StickMan();
}

void draw() {
  image(background, 0, 0);
  stickMan.draw();
  stickMan.drawPoints();
}

void mousePressed() {
  stickMan.mousePressed();
}

void mouseReleased() {
  stickMan.mouseReleased();
}

void mouseDragged() {
  stickMan.mouseDragged();
}