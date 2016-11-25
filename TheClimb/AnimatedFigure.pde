
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

      boolean bLastKeyFrame = (n == keyFrames.size() - 1);
      
      KeyFrame prevKeyFrame = keyFrames.get(n);
      KeyFrame nextKeyFrame;

      if (bLastKeyFrame) {
        nextKeyFrame = prevKeyFrame;
      } else {
        nextKeyFrame = keyFrames.get(n + 1);
      }

      if (nFrame < nextKeyFrame.nFrame || bLastKeyFrame) {

        StickFigure prevFigure = prevKeyFrame.pose.copy();
        StickFigure nextFigure = nextKeyFrame.pose.copy();
        prevFigure.pv.set(prevKeyFrame.x, prevKeyFrame.y);
        nextFigure.pv.set(nextKeyFrame.x, nextKeyFrame.y);

        float tween = 0;
        
        if ( prevKeyFrame.nFrame == nextKeyFrame.nFrame) {
          tween = 0.5; // Any value, doesn't matter
        } else {
          tween = map(nFrame, prevKeyFrame.nFrame, nextKeyFrame.nFrame, 0, 1);
        }

        StickFigure figure = new StickFigure(50);
        figure.tween(tween, prevFigure, nextFigure);
        figure.draw();
        break;
      }
    }
  }
};