
class LineSolution
{
  LineSolution()
  {
    m_cmd = new RCommand(0,0,0,0);
  }

  RCommand m_cmd;
};

class LineProblem implements Problem<LineSolution>
{
  float assessFitness(LineSolution s)
  {
    m_path.commands[0] = s.m_cmd;
    float fitness = assessShapeMatch.pointsToPolylineFitness(arrTargetPoints, m_path);
    m_path.commands[0] = null;
    
    float targetDistance = dist(arrTargetPoints.get(0), arrTargetPoints.get(arrTargetPoints.size() - 1));
    float solutionDistance = dist(s.m_cmd.startPoint, s.m_cmd.endPoint);

    if (solutionDistance > targetDistance)
    {
      float diff = solutionDistance - targetDistance;
      fitness += 0.25 * (diff * diff);
    }

    return fitness;
  }
  
  boolean aFitterThanB(float a, float b)
  {
    return a < b;
  }
  
  LineSolution getRandomSolution()
  {
    LineSolution ls = new LineSolution();
    ls.m_cmd.startPoint.x = random(width);
    ls.m_cmd.startPoint.y = random(height);
    ls.m_cmd.endPoint.x = random(width);
    ls.m_cmd.endPoint.y = random(height);
    return ls;
  }
  
  LineSolution tweak(LineSolution s)
  {
    LineSolution ls = new LineSolution();
    ls.m_cmd.startPoint.x = tweak(s.m_cmd.startPoint.x, width);
    ls.m_cmd.startPoint.y = tweak(s.m_cmd.startPoint.y, height);
    ls.m_cmd.endPoint.x = tweak(s.m_cmd.endPoint.x, width);
    ls.m_cmd.endPoint.y = tweak(s.m_cmd.endPoint.y, height);
    return ls;
  }

  float tweak(float f1, float fMax)
  {
    float f2;
    for(;;)
    {
      f2 = f1 + (5 * (float)rng.nextGaussian()); 
      
      if (f2 >= 0 && f2 < fMax)
        return f2;
    }
  }
  
  void setTargetPoints(ArrayList<RPoint> arr)
  {
    arrTargetPoints = arr;
  }
  
  void draw(LineSolution s)
  {
    s.m_cmd.draw();
  }
  
  ArrayList<RPoint> arrTargetPoints = new ArrayList<RPoint>();
  AssessShapeMatch assessShapeMatch = new AssessShapeMatch();
  Random rng = new Random();
  RPath m_path = new RPath(new RCommand(0,0,0,0));
};


