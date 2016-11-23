
class Vertex_old {

  int index;
  Vertex_old parent;
  ArrayList<Vertex_old> children;
  PVector pv;

  Vertex_old(int _index) {
    index = _index;
    pv = new PVector();
    children = new ArrayList<Vertex_old>();
  }

  void addChild(Vertex_old child) {
    child.parent = this;
    children.add(child);
  }

  void normalize(float size) {
    pv = PVector.sub(pv, parent.pv);
    pv.setMag(size);
    pv.add(parent.pv);
  }

  float getAngle() {
    PVector relative = PVector.sub(pv, parent.pv);
    return relative.heading();
}

  // We have defined a tree model.  Now define some recursive functions which take advantage of it 

  void relativeToAbsolute() {
    for (int n = 0; n < children.size(); ++n) {
      Vertex_old child = children.get(n);
      child.pv.add(pv);
      child.relativeToAbsolute();
    }
  }

  void draw() {

    for (int n = 0; n < children.size(); ++n) {

      Vertex_old child = children.get(n);
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

      Vertex_old child = children.get(n);
      child.rotate(pivot, angle, false);
    }
  }

  void tween(float t, Vertex_old parentA, Vertex_old parentB) {
    if (children.size() != parentA.children.size() || children.size() != parentB.children.size()) {
      println("Can't tween, trees differ");
      return;
    }

    for (int n = 0; n < children.size(); ++n) {
      Vertex_old a = parentA.children.get(n);
      Vertex_old b = parentB.children.get(n);
      Vertex_old c = children.get(n);
      
      float headingA = a.pv.heading();
      float headingB = b.pv.heading();
      float headingC = c.pv.heading();

      float heading = map(t, 0, 1, headingA, headingB);
      
      c.rotate(pv, heading - headingC, false);
    }
  }

};

//
// StickFigure_old
//
class StickFigure_old {
  
  float size;
  float pointSize = 10;
  int currentDrag = -1;

  ArrayList<Vertex_old> vertices;

  static final int PELVIS = 0;
  static final int LEFT_KNEE = 1;
  static final int RIGHT_KNEE = 2;
  static final int LEFT_FOOT = 3;
  static final int RIGHT_FOOT = 4;
  static final int CHEST = 5;
  static final int NECK = 6;
  static final int HEAD = 7;
  static final int LEFT_ELBOW = 8;
  static final int RIGHT_ELBOW = 9;
  static final int LEFT_HAND = 10;
  static final int RIGHT_HAND = 11;
  static final int VERTEX_COUNT = 12;

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
  
  StickFigure_old(float _size) {
    size = _size;
    reset();
}
  
  StickFigure_old(
          float _size,
          PVector pelvis,
          PVector leftKnee,
          PVector rightKnee,
          PVector leftFoot,
          PVector rightFoot,
          PVector chest,
          PVector neck,
          PVector head,
          PVector leftElbow,
          PVector rightElbow,
          PVector leftHand,
          PVector rightHand) {

    reset();
    size = _size;
    pelvis().set(pelvis);
    leftKnee().set(leftKnee);
    rightKnee().set(rightKnee);
    leftFoot().set(leftFoot);
    rightFoot().set(rightFoot);
    chest().set(chest);
    neck().set(neck);
    head().set(head);
    leftElbow().set(leftElbow);
    rightElbow().set(rightElbow);
    leftHand().set(leftHand);
    rightHand().set(rightHand);
  }

  void reset() {

    vertices = new ArrayList<Vertex_old>();
    
    for (int n = 0; n < VERTEX_COUNT; ++n) {
      vertices.add(new Vertex_old(n));
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
    float radius = dist(head().x, head().y, neck().x, neck().y) * 0.5;

    pushStyle();
    ellipseMode(RADIUS);
    ellipse(center.x, center.y, radius, radius);
    popStyle();

    // Use this kind of trick if you need to be able to tell one limb from the other
    if (alpha(g.strokeColor) == 255) {
      pushStyle();
      stroke(0, 255, 255);
      vertices.get(LEFT_KNEE).draw();
      popStyle();
    }
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
        Vertex_old v = vertices.get(currentDrag);
        float angleBefore = v.getAngle();
        v.pv.set(mouseX, mouseY);
        v.normalize(size);
        float angleAfter = v.getAngle();
        
        v.rotate(v.parent.pv, angleAfter - angleBefore, true);
      }
    }
  }

  void moveTo(float x, float y) {
    PVector moveTo = new PVector(x, y);
    PVector moveBy = PVector.sub(moveTo, pelvis());

    for (int n = 0; n < VERTEX_COUNT; ++n) {

      PVector pv = vertices.get(n).pv;
      pv.add(moveBy);
    }
  }

  void tween(float t, StickFigure_old a, StickFigure_old b) {
    StickFigure_old c = new StickFigure_old(map(t, 0, 1, a.size, b.size));

    float x = map(t, 0, 1, a.pelvis().x, b.pelvis().x);
    float y = map(t, 0, 1, a.pelvis().y, b.pelvis().y);
    pelvis().set(x, y);

    c.vertices.get(PELVIS).tween(t, a.vertices.get(PELVIS), b.vertices.get(PELVIS));
  }

  StickFigure_old copy() {
    return new StickFigure_old(
                  size,
                  pelvis(),
                  leftKnee(),
                  rightKnee(),
                  leftFoot(),
                  rightFoot(),
                  chest(),
                  neck(),
                  head(),
                  leftElbow(),
                  rightElbow(),
                  leftHand(),
                  rightHand());
  }

  void printlnWithComment(String line, String comment) {

    while (line.length() < 41) {
      line = line + " ";
    }
    
    println(line + "// " + comment);
  }
  
  void printVector(PVector pv, String lineEnding, String comment) {
    String line = "    new PVector(" + pv.x + ", " + pv.y + ")" + lineEnding;
    printlnWithComment(line, comment);
  }
  
  void print() {
    println("sequence.add(new StickFigure(");
    printlnWithComment("    " + size + ",", "Size");

    printVector(pelvis(),     ",",  "Pelvis");
    printVector(leftKnee(),   ",",  "Left knee");
    printVector(rightKnee(),  ",",  "Right knee");
    printVector(leftFoot(),   ",",  "Left foot");
    printVector(rightFoot(),  ",",  "Right foot");
    printVector(chest(),      ",",  "Chest");
    printVector(neck(),       ",",  "Neck");
    printVector(head(),       ",",  "Head");
    printVector(leftElbow(),  ",",  "Left elbow");
    printVector(rightElbow(), ",",  "Right elbow");
    printVector(leftHand(),   ",",  "Left hand");
    printVector(rightHand(),  "));", "Right hand");

    println("");
  }

};