
StickMan stickMan;

void setup() {
  size(800, 600);
  strokeWeight(3);
  
  stickMan = new StickMan();
}

void draw() {
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