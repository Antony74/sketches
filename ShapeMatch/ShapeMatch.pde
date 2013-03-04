
import java.util.Random;

// Requires the Geomerative library
// http://www.ricardmarxer.com/geomerative/
import geomerative.*;

ArrayList<RPoint> arrPoints;

void setup()
{
  size(900, 600);
  RG.init(this);
  
  arrPoints = new ArrayList<RPoint>();
}

void draw()
{
}

void mouseDragged()
{
  stroke(255, 0, 0);
  strokeWeight(2);
  line(pmouseX, pmouseY, mouseX, mouseY);
  arrPoints.add(new RPoint(mouseX, mouseY));
}

void mouseReleased()
{
  if (arrPoints.size() > 0)
  {
    SimulatedAnnealing<LineSolution> solver = new SimulatedAnnealing<LineSolution>();
    LineProblem problem = new LineProblem();
    problem.arrTargetPoints = arrPoints; 
  
    solver.init(problem);
  
    for (int n = 200000; n > 0; --n)
    {
      solver.setTemperature(n);
      solver.step();
    }
  
    stroke(0);
    strokeWeight(1);
    
    solver.m_best.m_cmd.draw();
    
    arrPoints.clear();
  }
}

float dist(RPoint A, RPoint B)
{
  return dist(A.x, A.y, B.x, B.y);
}

class AssessShapeMatch
{
  float pointToLineDistance(RPoint P, RPoint A, RPoint B)
  {
   float distAB = dist(A, B);
   float distLine = abs((P.x - A.x) * (B.y - A.y) - (P.y - A.y) * (B.x - A.x)) / distAB;
   return distLine;
  }
  
  float pointToCommandDistance(RPoint P, RCommand cmd)
  {
    Rectangle rect = new Rectangle(cmd.startPoint.x, cmd.startPoint.y, cmd.endPoint.x, cmd.endPoint.y);
    rect.normalise();
    if (rect.containsPoint(P.x, P.y))
    {
      return pointToLineDistance(P, cmd.startPoint, cmd.endPoint);
    }
    else
    {
      float distAP = dist(cmd.startPoint, P);
      float distBP = dist(cmd.endPoint, P);
      return min(distAP, distBP);
    }
  }
  
  float pointToPolylineDistance(RPoint P, RPath path)
  {
    float least = pointToCommandDistance(P, path.commands[0]);
    for (int n = 1; n < path.commands.length; ++n)
    {
      float candidate = pointToCommandDistance(P, path.commands[n]);
      least = min(least, candidate);
    }
    return least;
  }
};

class LineSolution implements Solution
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
    float fitness = 0;
    
    for (int n = 0; n < arrTargetPoints.size(); ++n)
    {
      RPoint P = arrTargetPoints.get(n);
      float distance = assessShapeMatch.pointToCommandDistance(P, s.m_cmd);
      
      fitness += (distance * distance);
    }
    fitness /= arrTargetPoints.size();
    
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
  
  ArrayList<RPoint> arrTargetPoints = new ArrayList<RPoint>();
  AssessShapeMatch assessShapeMatch = new AssessShapeMatch();
  Random rng = new Random();
};


