
class Vertex {

  // Generic tree-vertex member variables
  int index;
  Vertex parent;
  ArrayList<Vertex> children;

  // StickFigure specific member variables
  PVector pv;
  float heading; // We need to be able to track the heading in order to be able to tween in the correct direction
  // (bisecting an angle has two solutions)

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

    // Update heading - to do this the angle needs to be expressed within the range -PI to PI
    angle = angle - TWO_PI * floor( angle / TWO_PI );      
    
    if (angle > PI)
      angle -= TWO_PI;
    
    heading += angle;
    // Done updating heading
    
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

  void tween(float t, Vertex parentA, Vertex parentB) {

    if (children.size() != parentA.children.size() || children.size() != parentB.children.size()) {
      println("Can't tween, trees differ");
      return;
    }

    for (int n = 0; n < children.size(); ++n) {
      Vertex a = parentA.children.get(n);
      Vertex b = parentB.children.get(n);
      Vertex c = children.get(n);
      
      float heading = map(t, 0, 1, a.heading, b.heading);
      
      float angle = heading - c.heading;
    
      c.rotate(pv, angle, false);
      c.tween(t, a, b);
    }

  }

};

//
// StickFigure
//
class StickFigure {
  
  float size;
  float pointSize = 10;
  int currentDrag = -1;

  ArrayList<Vertex> vertices;

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
  
  StickFigure(float _size) {
    size = _size;
    reset();
}
  
  StickFigure(
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
    
    for (int n = 0; n < vertices.size(); ++n) {
      Vertex v = vertices.get(n);
      v.heading = v.pv.heading();
    }
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
 /*
    if (alpha(g.strokeColor) == 255) {
      pushStyle();
      stroke(0, 255, 255);
      vertices.get(LEFT_KNEE).draw();
      popStyle();
    }
*/
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

  boolean mousePressed() {
    for (int n = 0; n < VERTEX_COUNT; ++n) {

      PVector pv = vertices.get(n).pv;
      
      if ( (abs(pv.x - mouseX) <= pointSize) && abs(pv.y - mouseY) <= pointSize) {
        currentDrag = n;
        return true;
      }
    }
    
    return false;
  }

  boolean mouseReleased() {
    if (currentDrag == -1) {
      return false;
    } else {
      currentDrag = -1;
      return true;
    }
  }

  boolean mouseDragged() {

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
      
      return true;
    } else {
      return false;
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

  void tween(float t, StickFigure a, StickFigure b) {

    float x = map(t, 0, 1, a.pelvis().x, b.pelvis().x);
    float y = map(t, 0, 1, a.pelvis().y, b.pelvis().y);
    moveTo(x, y);

    vertices.get(PELVIS).tween(t, a.vertices.get(PELVIS), b.vertices.get(PELVIS));

  }

  StickFigure copy() {
    return new StickFigure(
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