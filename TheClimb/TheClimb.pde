
PImage background;
Poses poses;
ArrayList<StickFigure> sequence;
AnimatedFigure fig1;
boolean bAnimate = false;

int nCurrentPose;
StickFigure stickFigure;
StickFigure onionSkin;

void setup() {
  size(800, 600);
  strokeWeight(18);

  background = loadImage("background.png");
  poses = new Poses();

  sequence = poses.walk;  // We set this to the sequence we're currently working on
  
  setCurrentPose(sequence.size() - 1); // And we usually want to start with the last frame

  fig1 = new AnimatedFigure();
  fig1.resetFig1();
}

void draw() {
  image(background, 0, 0);

  if (bAnimate == true) {
    stroke(0, 255);
    fill(0, 255);
    fig1.draw(frameCount % (sequence.size() * 10));
  } else {

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
}

void mousePressed() {
  if (bAnimate == false) {
    stickFigure.mousePressed();
  }
}

void mouseReleased() {
  if (bAnimate == false) {
    stickFigure.mouseReleased();
  }
}

void mouseDragged() {
  if (bAnimate == false) {
    stickFigure.mouseDragged();
  }
}

void keyPressed() {
  if (bAnimate == false) {
    char key = Character.toLowerCase((char)keyCode);
  
    switch(key) {
    case 'p':
      stickFigure.print();
      break;
  
    case 'n':
      sequence.add(stickFigure.copy());
      setCurrentPose(sequence.size() - 1);
      break;
    }
  
    switch (keyCode) {
    case LEFT:
      if (nCurrentPose > 0) {
        setCurrentPose(nCurrentPose - 1);
      }
      break;
      
    case RIGHT:
      if (nCurrentPose + 1 < sequence.size()) {
        setCurrentPose(nCurrentPose + 1);
      }
    }
  }
}

void setCurrentPose(int nPose) {

  nCurrentPose = nPose;
  
  if (nPose >= 0 && nPose < sequence.size()) {
    stickFigure = sequence.get(nPose);
  } else {
    stickFigure = null;
  }

  if (nPose - 1 >= 0 && nPose - 1 < sequence.size()) {
    onionSkin = sequence.get(nPose - 1);
  } else {
    onionSkin = null;
  }

}