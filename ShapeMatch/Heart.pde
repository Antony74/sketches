
class HeartSolution
{
  float n00, n01, n02;
  float n10, n11, n12;
  
  RMatrix getMatrix()
  {
    return new RMatrix(n00, n01, n02,
                       n10, n11, n12);
  }
};

class HeartProblem implements Problem<HeartSolution>
{
  HeartProblem()
  {
    heart = new RPath(200,200);
    heart.addBezierTo(175, 100,   0, 200, 200, 350);
    heart.addBezierTo(400, 200, 225, 100, 200, 200);
    
//    RPoint centre = heart.getCenter();
//    heart.translate(-centre.x, -centre.y);
    
    heartPolyline = new RPath(heart.commands[0].startPoint);
    for (int nCmd = 0; nCmd < heart.commands.length; ++nCmd)
    {
      RCommand cmd = heart.commands[nCmd];
      for (float t = 0.2; t < 1.05; t += 0.2)
      {
        heartPolyline.addLineTo(cmd.getPoint(t));
      }
    }
  }
  
  float assessFitness(HeartSolution s)
  {
    RPath transformed = new RPath(heartPolyline);
    transformed.transform(s.getMatrix());

    float fitness = assessShapeMatch.pointsToPolylineFitness(arrTargetPoints, transformed);

    float solutionWidth = transformed.getWidth();
    float solutionHeight = transformed.getHeight();
/*
    if (solutionWidth > targetWidth)
    {
      float diff = solutionWidth - targetWidth;
      fitness += 0.25 * (diff * diff);
    }
    
    if (solutionHeight > targetHeight)
    {
      float diff = solutionHeight - targetHeight;
      fitness += 0.25 * (diff * diff);
    }
*/
    return fitness;
  }
  
  boolean aFitterThanB(float a, float b)
  {
    return a < b;
  }

  HeartSolution getRandomSolution()
  {
    HeartSolution hs = new HeartSolution();
    float range = 6;
    float half = range/2;
    hs.n00 = random(range)-half; hs.n01 = random(range)-half; hs.n02 = random(width);
    hs.n10 = random(range)-half; hs.n11 = random(range)-half; hs.n12 = random(height);
    return hs;
  }
  
  HeartSolution tweak(HeartSolution hs1)
  {
    HeartSolution hs2 = new HeartSolution();

    hs2.n00 += (0.5 * (float)rng.nextGaussian());
    hs2.n01 += (0.5 * (float)rng.nextGaussian());
    hs2.n10 += (0.5 * (float)rng.nextGaussian());
    hs2.n11 += (0.5 * (float)rng.nextGaussian());

    hs2.n02 += (5 * (float)rng.nextGaussian());
    hs2.n12 += (5 * (float)rng.nextGaussian());

    return hs2;
  }
  
  void draw(HeartSolution hsl)
  {
    RPath transformed = new RPath(heart);
    transformed.transform(hsl.getMatrix());
    transformed.draw();
  }

  void setTargetPoints(ArrayList<RPoint> arr)
  {
    arrTargetPoints = arr;
    
    float targetXMin = 0;
    float targetXMax = width;
    float targetYMin = 0;
    float targetYMax = height;
  
    for (int n = 0; n < arr.size(); ++n)
    {
      RPoint pt = arr.get(n);
      targetXMin = min(targetXMin, pt.x);
      targetXMax = max(targetXMax, pt.x);
      targetYMin = min(targetYMin, pt.y);
      targetYMax = max(targetYMax, pt.y);
    }
    
    targetWidth  = targetXMax - targetXMin;
    targetHeight = targetYMax - targetYMin;
  }

  RPath heart;
  RPath heartPolyline;
  ArrayList<RPoint> arrTargetPoints = new ArrayList<RPoint>();
  float targetWidth = 0;
  float targetHeight = 0;
  AssessShapeMatch assessShapeMatch = new AssessShapeMatch();

  Random rng = new Random();
};


