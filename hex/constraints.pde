
// Automaton library is required!
// http://www.brics.dk/automaton/download.html
import dk.brics.automaton.*;

import java.util.Set;
import java.util.TreeSet;

class Constraint
{
  String m_sRegExp;
  HexNode m_nodeStart;
  int m_nDirection;
  Automaton m_automaton;
  boolean m_bValid;
  
  Constraint(HexNode nodeStart, int nDirection, String sRegExp)
  {
    m_sRegExp = sRegExp;
    m_nodeStart = nodeStart;
    m_nDirection = nDirection;
    
    RegExp r = new RegExp(sRegExp);
    m_automaton = r.toAutomaton();
  }
  
  void draw()
  {
    if (m_bValid)
    {
      fill(0, 128, 0);
    }
    else
    {
      fill(255, 0, 0);
    }
    
    stroke(0);
    PVector pt = m_nodeStart.m_pt;

    pushMatrix();

    translate(pt.x, pt.y); 
    rotate(arrUnitVectors[m_nDirection].heading());
    translate(-textWidth(m_sRegExp) - (0.5*nSpacing), 10);
    
    text(m_sRegExp, 0, 0);

    popMatrix();
  }
};

ArrayList<Constraint> listConstraints;

void assembleConstraints()
{
  listConstraints = new ArrayList<Constraint>();

  // Shorter variable names for brevity
  ArrayList<Constraint> list = listConstraints;
  ArrayList<HexNode> all = listAllNodes;
  
  list.add(new Constraint(all.get(0), DIR_DOWN_LEFT, "(ND|ET|IN)[^X]*"));
  list.add(new Constraint(all.get(1), DIR_DOWN_LEFT, "[CHMNOR]*I[CHMNOR]*"));
  list.add(new Constraint(all.get(2), DIR_DOWN_LEFT, "P+(..)\\1.*"));
}

void checkConstraint(Constraint constraint)
{
  HexNode node = constraint.m_nodeStart;
  TreeSet<State> states = new TreeSet<State>();
  states.add(constraint.m_automaton.getInitialState());

  while (node != null)
  {
    char c = solution.get(node.m_nIndex);
    TreeSet<State> allNext = new TreeSet<State>();
    
    for (State s: states)
    {
      TreeSet<State> possibleNext = new TreeSet<State>();
      
      if (c == ' ')
      {
        // We're using space as a special case to mean we haven't filled in this part of the solution yet and want to consider all transitions
        Set<Transition> setTrans = s.getTransitions();
        for (Transition t: setTrans)
        {
          possibleNext.add(t.getDest());
        }
      }
      else
      {
        s.step(c, possibleNext);
      }
      
      allNext.addAll(possibleNext);
    }
    
    if (allNext.size() == 0)
    {
      constraint.m_bValid = false;
      return;
    }
    
    states = allNext;
    node = node.m_arrNeighbours[constraint.m_nDirection];
  }
  
  states.retainAll(constraint.m_automaton.getAcceptStates());
  
  if (states.size() == 0)
  {
    constraint.m_bValid = false;
  }
  else
  {
    constraint.m_bValid = true;
  }
}



