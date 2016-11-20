
class KeyFrame {
  int nFrame;
  StickFigure pose;
  float x;
  float y;

  KeyFrame(int _nFrame, StickFigure _pose, float _x, float _y) {
    nFrame = _nFrame;
    pose = _pose;
    x = _x;
    y = _y;
  }
}

class AnimatedFigure {

  ArrayList<KeyFrame> keyFrames = new ArrayList<KeyFrame>();

  void resetFig1() {
    keyFrames.clear();

//    println(poses.walk.size());
    
    for (int n = 0; n < poses.walk.size(); ++n) {
      keyFrames.add(new KeyFrame( n * 10, poses.walk.get(n), 100 + (n * 10), 360));
    }
    
  }
  
  void draw(int nFrame) {
    
    for (int n = 0; n < keyFrames.size(); ++n) {

      KeyFrame keyFrame = keyFrames.get(n);
      if (nFrame < keyFrame.nFrame || n == keyFrames.size() - 1) {

        StickFigure fig = keyFrame.pose.copy();
        fig.moveTo(keyFrame.x, keyFrame.y);
        fig.draw();
        break;
      }
    }
  }
};