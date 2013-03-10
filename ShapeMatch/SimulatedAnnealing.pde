
class SimulatedAnnealing<SOLUTION> implements Solver<SOLUTION>
{
  SimulatedAnnealing(float initialTemperature)
  {
    m_temperature = initialTemperature;
  }
  
  public void init(Problem<SOLUTION> problem)
  {
    m_problem = problem;
    m_best = problem.getRandomSolution();
    m_bestFitness = problem.assessFitness(m_best);
    m_candidate = m_best;
    m_candidateFitness = m_bestFitness;
  }

  void step()
  {
    SOLUTION solution = m_problem.tweak(m_candidate);
    float fitness = m_problem.assessFitness(solution);
    boolean bUse = false;
    
    if (m_problem.aFitterThanB(fitness, m_candidateFitness))
    {
      bUse = true;
    }
    else
    {
      float probability = exp(-abs(fitness - m_candidateFitness)/m_temperature);
      if (random(1) < probability)
      {
        bUse = true;
      }
    }

    if (bUse)
    {
      m_candidate = solution;
      m_candidateFitness = fitness;
    }
    
    if (m_problem.aFitterThanB(fitness, m_bestFitness))
    {
      m_best = solution;
      m_bestFitness = fitness;
    }

    --m_temperature;
  }
  
  Problem<SOLUTION> m_problem;

  SOLUTION m_best;
  float m_bestFitness;

  SOLUTION m_candidate;
  float m_candidateFitness;

  float m_temperature;
};


