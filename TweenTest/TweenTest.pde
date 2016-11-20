
StickFigure start;
StickFigure end;

void setup() {
  size(800, 600);
  strokeWeight(18);
  start = new StickFigure(50);
  end = new StickFigure(50);
}

void draw() {
  background(255);

  stroke(0);
  fill(0);
  start.draw();
  start.drawPoints();

  stroke(0, 128);
  fill(0, 128);
  StickFigure tween = new StickFigure(50);
  tween.tween(0.5, start, end);
  tween.draw();
  
  stroke(0);
  fill(0);
  end.draw();
  end.drawPoints();
}

void mousePressed() {
    boolean bAccepted = end.mousePressed();

    if (bAccepted == false) {
      start.mousePressed();
    }
}

void mouseReleased() {
    boolean bAccepted = end.mouseReleased();

    if (bAccepted == false) {
      start.mouseReleased();
    }
}

void mouseDragged() {
    boolean bAccepted = end.mouseDragged();

    if (bAccepted == false) {
      start.mouseDragged();
    }
}