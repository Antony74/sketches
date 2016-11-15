
class StickMan {
  
  float size = 60;
  float pointSize = 10;
  int currentDrag = -1;

  PVector pelvis;
  PVector leftKnee;
  PVector rightKnee;
  PVector leftFoot;
  PVector rightFoot;
  PVector chest;
  PVector neck;
  PVector head;
  PVector leftElbow;
  PVector rightElbow;
  PVector leftHand;
  PVector rightHand;


  PVector getVector(int n) {
    switch(n) {
    case  0: return pelvis;
    case  1: return leftKnee;
    case  2: return rightKnee;
    case  3: return leftFoot;
    case  4: return rightFoot;
    case  5: return chest;
    case  6: return neck;
    case  7: return head;
    case  8: return leftElbow;
    case  9: return rightElbow;
    case 10: return leftHand;
    case 11: return rightHand;
  }
    
    return null;
  }
  
  int getVectorCount() {
    return 12;
  }
  
  StickMan() {
    reset();
  }
  
  void reset() {

    float EIGHTH_PI = PI/8;
    
    pelvis = new PVector(width/2, height/2);
    leftKnee = new PVector(0, size);
    rightKnee = new PVector(0, size);
    leftKnee.rotate(EIGHTH_PI);
    rightKnee.rotate(-EIGHTH_PI);
    leftFoot = leftKnee.copy();
    rightFoot = rightKnee.copy();
    chest = new PVector(0, -size);
    neck = new PVector(0, -size);
    head = new PVector(0, -size);
    leftElbow = new PVector(-size, 0);
    leftElbow.rotate(-QUARTER_PI);
    rightElbow = new PVector(size, 0);
    rightElbow.rotate(QUARTER_PI);
    leftHand = new PVector(0, size);
    leftHand.rotate(EIGHTH_PI);
    rightHand = new PVector(0, size);
    rightHand.rotate(-EIGHTH_PI);
    
    // Convert relative coordinates to absolute
    leftKnee = PVector.add(leftKnee, pelvis);
    rightKnee = PVector.add(rightKnee, pelvis);
    leftFoot = PVector.add(leftFoot, leftKnee);
    rightFoot = PVector.add(rightFoot, rightKnee);
    chest = PVector.add(chest, pelvis);
    neck = PVector.add(neck, chest);
    head = PVector.add(head, neck);
    leftElbow = PVector.add(leftElbow, neck);
    rightElbow = PVector.add(rightElbow, neck);
    leftHand = PVector.add(leftHand, leftElbow);
    rightHand = PVector.add(rightHand, rightElbow);
}

  void draw() {
  
    pv_line(pelvis, leftKnee);
    pv_line(pelvis, rightKnee);
    pv_line(leftKnee, leftFoot);
    pv_line(rightKnee, rightFoot);
    pv_line(pelvis, chest);
    pv_line(chest, neck);
    pv_line(neck, head);
    pv_line(neck, leftElbow);
    pv_line(neck, rightElbow);
    pv_line(leftElbow, leftHand);
    pv_line(rightElbow, rightHand);

    PVector center = PVector.div( PVector.add( PVector.mult(neck, 1), PVector.mult(head, 2) ), 3);
    float radius = neck.dist(head) * 0.5;

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
    
    for (int n = 0; n < getVectorCount(); ++n) {
      drawPoint(getVector(n));
    }
    
    popStyle();
  }

  void drawPoint(PVector pv) {
    rect(pv.x, pv.y, pointSize, pointSize);
  }

  void pv_line(PVector pv1, PVector pv2) {
    line(pv1.x, pv1.y, pv2.x, pv2.y);
  }

  void mousePressed() {
    for (int n = 0; n < getVectorCount(); ++n) {

      PVector pv = getVector(n);
      
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
      PVector pv = getVector(currentDrag);
      pv.add(mouseX - pmouseX, mouseY - pmouseY);
    }
  }

};