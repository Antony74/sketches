
Poses poses = new Poses();
StickFigure stickFigure;
StickFigure onionSkin;
PImage background;

void setup() {
  size(800, 600);
  strokeWeight(18);
  stroke(0);
  fill(0);

  background = loadImage("background.png");

  setCurrentPose(poses.walk.size() - 1);
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

void keyPressed() {

  char key = Character.toLowerCase((char)keyCode);

  switch(key) {
  case 'p':
    stickFigure.print();
    break;
  }
}

void setCurrentPose(int nPose) {

  if (nPose < poses.walk.size()) {
    stickFigure = poses.walk.get(nPose);
  }

  if (nPose < poses.walk.size() - 1) {
    onionSkin = poses.walk.get(nPose - 1);
  }
}