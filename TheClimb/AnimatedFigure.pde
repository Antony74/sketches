
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
    keyFrames.add(new KeyFrame( 0, poses.walk.get(0), 100, 360));
    keyFrames.add(new KeyFrame(10, poses.walk.get(1), 100, 360));
    keyFrames.add(new KeyFrame(20, poses.walk.get(2), 100, 360));
    keyFrames.add(new KeyFrame(30, poses.walk.get(2), 100, 360));
    keyFrames.add(new KeyFrame(40, poses.walk.get(3), 100, 360));
    keyFrames.add(new KeyFrame(50, poses.walk.get(4), 100, 360));
    keyFrames.add(new KeyFrame(60, poses.walk.get(5), 100, 360));
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