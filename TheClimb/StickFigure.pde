
class Vertex {

  int index;
  Vertex parent;
  ArrayList<Vertex> children;
  PVector pv;

  Vertex(int _index) {
    index = _index;
    pv = new PVector();
    children = new ArrayList<Vertex>();
  }

  void addChild(Vertex child) {
    child.parent = this;
    children.add(child);
  }

  void normalize(float size) {
    pv = PVector.sub(pv, parent.pv).setMag(size);
    pv.add(parent.pv);
  }

  float getAngle() {
    PVector relative = PVector.sub(pv, parent.pv);
    return relative.heading();
}

  // We have defined a tree model.  Now define some recursive functions which take advantage of it 

  void relativeToAbsolute() {
    for (int n = 0; n < children.size(); ++n) {
      Vertex child = children.get(n);
      child.pv.add(pv);
      child.relativeToAbsolute();
    }
  }

  void draw() {

    for (int n = 0; n < children.size(); ++n) {

      Vertex child = children.get(n);
      line(pv.x, pv.y, child.pv.x, child.pv.y);
      child.draw();
    }
    
  }

  void rotate(PVector pivot, float angle, boolean bSkip) {

    if (bSkip == false) {
      pv = PVector.sub(pv, pivot);
      pv.rotate(angle);
      pv.add(pivot);
    }

    for (int n = 0; n < children.size(); ++n) {

      Vertex child = children.get(n);
      child.rotate(pivot, angle, false);
  }
}

};

//
// StickFigure
//
class StickFigure {
  
  float size = 60;
  float pointSize = 10;
  int currentDrag = -1;

  ArrayList<Vertex> vertices;

  final int PELVIS = 0;
  final int LEFT_KNEE = 1;
  final int RIGHT_KNEE = 2;
  final int LEFT_FOOT = 3;
  final int RIGHT_FOOT = 4;
  final int CHEST = 5;
  final int NECK = 6;
  final int HEAD = 7;
  final int LEFT_ELBOW = 8;
  final int RIGHT_ELBOW = 9;
  final int LEFT_HAND = 10;
  final int RIGHT_HAND = 11;
  final int VERTEX_COUNT = 12;

  PVector pelvis()     { return vertices.get(PELVIS).pv;      }
  PVector leftKnee()   { return vertices.get(LEFT_KNEE).pv;   }
  PVector rightKnee()  { return vertices.get(RIGHT_KNEE).pv;  }
  PVector leftFoot()   { return vertices.get(LEFT_FOOT).pv;   }
  PVector rightFoot()  { return vertices.get(RIGHT_FOOT).pv;  }
  PVector chest()      { return vertices.get(CHEST).pv;       }
  PVector neck()       { return vertices.get(NECK).pv;        }
  PVector head()       { return vertices.get(HEAD).pv;        }
  PVector leftElbow()  { return vertices.get(LEFT_ELBOW).pv;  }
  PVector rightElbow() { return vertices.get(RIGHT_ELBOW).pv; }
  PVector leftHand()   { return vertices.get(LEFT_HAND).pv;   }
  PVector rightHand()  { return vertices.get(RIGHT_HAND).pv;  }
  
  StickFigure() {
    reset();
  }
  
  void reset() {

    vertices = new ArrayList<Vertex>();
    
    for (int n = 0; n < VERTEX_COUNT; ++n) {
      vertices.add(new Vertex(n));
    }

    addChild(LEFT_KNEE, PELVIS);
    addChild(RIGHT_KNEE, PELVIS);
    addChild(LEFT_FOOT, LEFT_KNEE);
    addChild(RIGHT_FOOT, RIGHT_KNEE);
    addChild(CHEST, PELVIS);
    addChild(NECK, CHEST);
    addChild(HEAD, NECK);
    addChild(LEFT_ELBOW, NECK);
    addChild(RIGHT_ELBOW, NECK);
    addChild(LEFT_HAND, LEFT_ELBOW);
    addChild(RIGHT_HAND, RIGHT_ELBOW);
    
    float EIGHTH_PI = PI/8;

    pelvis().set(width/2, height/2);
    leftKnee().set(0, size);
    rightKnee().set(0, size);
    leftKnee().rotate(EIGHTH_PI);
    rightKnee().rotate(-EIGHTH_PI);
    leftFoot().set(leftKnee());
    rightFoot().set(rightKnee());
    chest().set(0, -size);
    neck().set(0, -size);
    head().set(0, -size);
    leftElbow().set(-size, 0);
    leftElbow().rotate(-QUARTER_PI);
    rightElbow().set(size, 0);
    rightElbow().rotate(QUARTER_PI);
    leftHand().set(0, size);
    leftHand().rotate(EIGHTH_PI);
    rightHand().set(0, size);
    rightHand().rotate(-EIGHTH_PI);
    
    vertices.get(PELVIS).relativeToAbsolute();
}

  void addChild(int nVertex, int nParent) {
    vertices.get(nParent).addChild(vertices.get(nVertex));
  }

  void draw() {
  
    vertices.get(PELVIS).draw();

    PVector center = PVector.div( PVector.add( PVector.mult(neck(), 1), PVector.mult(head(), 2) ), 3);
    float radius = neck().dist(head()) * 0.5;

    pushStyle();
    ellipseMode(RADIUS);
    ellipse(center.x, center.y, radius, radius);
    popStyle();
}

  void drawPoints() {
    
    pushStyle();
    rectMode(RADIUS);
    noStroke();
    fill(255,0,0,128);
    
    for (int n = 0; n < VERTEX_COUNT; ++n) {
      drawPoint(vertices.get(n).pv);
    }
    
    popStyle();
  }

  void drawPoint(PVector pv) {
    rect(pv.x, pv.y, pointSize, pointSize);
  }

  void mousePressed() {
    for (int n = 0; n < VERTEX_COUNT; ++n) {

      PVector pv = vertices.get(n).pv;
      
      if ( (abs(pv.x - mouseX) <= pointSize) && abs(pv.y - mouseY) <= pointSize) {
        currentDrag = n;
        break;
      }
    }
  }

  void mouseReleased() {
    currentDrag = -1;
  }

  void mouseDragged() {

    if (currentDrag >= 0) {

      if (currentDrag == 0) {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector delta = PVector.sub(mouse, pelvis());

        for (int n = 0; n < VERTEX_COUNT; ++n) {
          vertices.get(n).pv.add(delta);
        }
      } else {
        Vertex v = vertices.get(currentDrag);
        float angleBefore = v.getAngle();
        v.pv.set(mouseX, mouseY);
        v.normalize(size);
        float angleAfter = v.getAngle();
        
        v.rotate(v.parent.pv, angleAfter - angleBefore, true);
      }
    }
  }

};