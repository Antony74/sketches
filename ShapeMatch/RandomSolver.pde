// Maximum exploration, no exploitation.  A handy baseline, but not intended for serious use.

class RandomSolver<SOLUTION> implements Solver<SOLUTION>
{
  public void init(Problem<SOLUTION> problem)
  {
    m_problem = problem;
    m_best = problem.getRandomSolution();
    m_bestFitness = problem.assessFitness(m_best);
  }

  void step()
  {
    SOLUTION solution = m_problem.getRandomSolution();
    float fitness = m_problem.assessFitness(solution);
    if (m_problem.aFitterThanB(fitness, m_bestFitness))
    {
      m_best = solution;
      m_bestFitness = fitness;
    }
  }
  
  Problem<SOLUTION> m_problem;
  SOLUTION m_best;
  float m_bestFitness;
};


