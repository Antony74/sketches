
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

    float SIXTH_PI = PI/6;
    
    pelvis = new PVector(width/2, height/2);
    leftKnee = new PVector(0, size);
    rightKnee = new PVector(0, size);
    leftKnee.rotate(SIXTH_PI);
    rightKnee.rotate(-SIXTH_PI);
    leftFoot = leftKnee.copy();
    rightFoot = rightKnee.copy();
    
    // Convert relative coordinates to absolute
    leftKnee = PVector.add(leftKnee, pelvis);
    rightKnee = PVector.add(rightKnee, pelvis);
    leftFoot = PVector.add(leftFoot, leftKnee);
    rightFoot = PVector.add(rightFoot, rightKnee);
  }

  void draw() {
  
    pv_line(pelvis, leftKnee);
    pv_line(pelvis, rightKnee);
    pv_line(leftKnee, leftFoot);
    pv_line(rightKnee, rightFoot);
}

  void drawPoints() {
    
    pushStyle();
    rectMode(RADIUS);
    noStroke();
    fill(255,0,0,128);
    
    drawPoint(pelvis);
    drawPoint(leftKnee);
    drawPoint(rightKnee);
    
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
       
      if ( (abs(pv.x - mouseX) <= pointSize) || abs(pv.y - mouseY) <= pointSize) {
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