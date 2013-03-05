
class HeartSolution implements Solution
{
  RMatrix matrix;
};

class HeartProblem implements Problem<HeartSolution>
{
  HeartProblem()
  {
    heart = new RPath(200,200);
    heart.addBezierTo(200, 100,   0, 200, 200, 400);
    heart.addBezierTo(400, 200, 200, 100, 200, 200);
  }
  
  float assessFitness(HeartSolution s)
  {
    float fitness = assessShapeMatch.pointsToPolylineFitness(arrTargetPoints, heartPolyline);
    return fitness;
  }
  
  boolean aFitterThanB(float a, float b)
  {
    return a < b;
  }

  HeartSolution getRandomSolution()
  {
    HeartSolution hs = new HeartSolution();
    float range = 20;
    float half = 10;
    hs.matrix = new RMatrix( random(range)-half, random(range)-half, width,
                             random(range)-half, random(range)-half, height);
    return hs;
  }
  
  HeartSolution tweak(HeartSolution hs1)
  {
    // NOT PROPERLY IMPLEMENTED
    HeartSolution hs2 = new HeartSolution();
    float range = 20;
    float half = 10;
    hs2.matrix = new RMatrix( random(range)-half, random(range)-half, width,
                              random(range)-half, random(range)-half, height);
    return hs2;
  }

  RPath heart;
  RPath heartPolyline;
  ArrayList<RPoint> arrTargetPoints = new ArrayList<RPoint>();
  AssessShapeMatch assessShapeMatch = new AssessShapeMatch();

};


