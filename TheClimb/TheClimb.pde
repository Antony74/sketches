
Poses poses = new Poses();
int nCurrentPose;
StickFigure stickFigure;
StickFigure onionSkin;
PImage background;

void setup() {
  size(800, 600);
  strokeWeight(18);

  background = loadImage("background.png");

  setCurrentPose(poses.walk.size() - 1);
}

void draw() {
  image(background, 0, 0);

  if (onionSkin != null) {
    stroke(0, 128);
    fill(0, 128);

    onionSkin.draw();
  }

  stroke(0, 255);
  fill(0, 255);

  if (stickFigure != null) {
    stickFigure.draw();
    stickFigure.drawPoints();
  }

  text("Current pose " + nCurrentPose, 10, 10);
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

  case 'n':
    poses.walk.add(stickFigure.copy());
    setCurrentPose(poses.walk.size() - 1);
    break;
  }

  switch (keyCode) {
  case LEFT:
    if (nCurrentPose > 0) {
      setCurrentPose(nCurrentPose - 1);
    }
    break;
    
  case RIGHT:
    if (nCurrentPose + 1 < poses.walk.size()) {
      setCurrentPose(nCurrentPose + 1);
    }
  }
}

void setCurrentPose(int nPose) {

  nCurrentPose = nPose;
  
  if (nPose >= 0 && nPose < poses.walk.size()) {
    stickFigure = poses.walk.get(nPose);
  } else {
    stickFigure = null;
  }

  if (nPose - 1 >= 0 && nPose - 1 < poses.walk.size()) {
    onionSkin = poses.walk.get(nPose - 1);
  } else {
    onionSkin = null;
  }
}