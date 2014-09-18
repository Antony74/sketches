
// Automaton library is required!
// http://www.brics.dk/automaton/download.html
import dk.brics.automaton.*;

import java.util.Set;
import java.util.TreeSet;

ArrayList<Constraint> listConstraints;

void assembleConstraints()
{
  listConstraints = new ArrayList<Constraint>();

  // Shorter variable names for brevity
  ArrayList<Constraint> list = listConstraints;
  ArrayList<HexNode> all = listAllNodes;
  
  list.add(new Constraint(all.get(  0), DIR_DOWN_LEFT, "(ND|ET|IN)[^X]*"));
  list.add(new Constraint(all.get(  1), DIR_DOWN_LEFT, "[CHMNOR]*I[CHMNOR]*"));
  list.add(new ConstraintWithGrouping(all.get(  2), DIR_DOWN_LEFT, "P+(..)\\1.*"));
  list.add(new Constraint(all.get(  3), DIR_DOWN_LEFT, "(E|CR|MN)*"));
  list.add(new Constraint(all.get(  4), DIR_DOWN_LEFT, "([^MC]|MM|CC)*"));
  list.add(new Constraint(all.get(  5), DIR_DOWN_LEFT, "[AM]*CM(RC)*R?"));
  list.add(new Constraint(all.get(  6), DIR_DOWN_LEFT, ".*"));
  list.add(new Constraint(all.get( 14), DIR_DOWN_LEFT, ".*PRR.*DDC.*"));
  list.add(new Constraint(all.get( 23), DIR_DOWN_LEFT, "(HHX|[^HX])*"));
  list.add(new Constraint(all.get( 33), DIR_DOWN_LEFT, "([^EMC]|EM)*"));
  list.add(new Constraint(all.get( 44), DIR_DOWN_LEFT, ".*OXR.*"));
  list.add(new Constraint(all.get( 56), DIR_DOWN_LEFT, ".*LR.*RL.*"));
  list.add(new Constraint(all.get( 69), DIR_DOWN_LEFT, ".*SE.*UE.*"));
  
  list.add(new Constraint(all.get(  0), DIR_RIGHT, ".*H.*H.*"));
  list.add(new Constraint(all.get(  7), DIR_RIGHT, "(DI|NS|TH|OM)*"));
  list.add(new Constraint(all.get( 15), DIR_RIGHT, "F.*[AO].*[AO].*"));
  list.add(new Constraint(all.get( 24), DIR_RIGHT, "(O|RHH|MM)*"));
  list.add(new Constraint(all.get( 34), DIR_RIGHT, ".*"));
  list.add(new Constraint(all.get( 45), DIR_RIGHT, "C*MC(CCC|MM)*"));
  list.add(new Constraint(all.get( 57), DIR_RIGHT, "[^C]*[^R]*III.*"));
  list.add(new ConstraintWithGrouping(all.get( 70), DIR_RIGHT, "(...?)\\1*"));
  list.add(new Constraint(all.get( 82), DIR_RIGHT, "([^X]|XCC)*"));
  list.add(new Constraint(all.get( 93), DIR_RIGHT, "(RR|HHH)*.?"));
  list.add(new Constraint(all.get(103), DIR_RIGHT, "N.*X.X.X.*E"));
  list.add(new Constraint(all.get(112), DIR_RIGHT, "R*D*M*"));
  list.add(new Constraint(all.get(120), DIR_RIGHT, ".(C|HH)*"));

  list.add(new Constraint(all.get(120), DIR_UP_LEFT, ".*G.*V.*H.*"));
  list.add(new Constraint(all.get(121), DIR_UP_LEFT, "[CR]*"));
  list.add(new Constraint(all.get(122), DIR_UP_LEFT, ".*XEXM*"));
  list.add(new Constraint(all.get(123), DIR_UP_LEFT, ".*DD.*CCM.*"));
  list.add(new Constraint(all.get(124), DIR_UP_LEFT, ".*XHCR.*X.*"));
  list.add(new ConstraintWithGrouping(all.get(125), DIR_UP_LEFT, ".*(.)(.)(.)(.)\\4\\3\\2\\1.*"));
  list.add(new Constraint(all.get(126), DIR_UP_LEFT, ".*(IN|SE|HI)"));
  list.add(new Constraint(all.get(119), DIR_UP_LEFT, "[^C]*MMM[^C]*"));
  list.add(new ConstraintWithGrouping(all.get(111), DIR_UP_LEFT, ".*(.)C\\1X\\1.*"));
  list.add(new Constraint(all.get(102), DIR_UP_LEFT, "[CEIMU]*OH[AEMOR]*"));
  list.add(new Constraint(all.get( 92), DIR_UP_LEFT, "(RX|[^R])*"));
  list.add(new Constraint(all.get( 81), DIR_UP_LEFT, "[^M]*M[^M]*"));
  list.add(new Constraint(all.get( 69), DIR_UP_LEFT, "(S|MM|HHH)*"));
}

void checkConstraints()
{
  for (Constraint constraint: listConstraints)
  {
    constraint.checkConstraint();
  }
}

class Constraint
{
  String m_sRegExp;
  HexNode m_nodeStart;
  int m_nDirection;
  Automaton m_automaton;
  int m_nValid; // +1 valid, -1 invalid, 0 unknown
  
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
    if (m_nValid > 0)
    {
      fill(0, 128, 0);
    }
    else if (m_nValid < 0)
    {
      fill(255, 0, 0);
    }
    else
    {
      fill(0);
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

  String getStringToMatch()
  {
    StringBuffer buffer = new StringBuffer();
    HexNode node = m_nodeStart;
    while (node != null)
    {
      char c = solution.get(node.m_nIndex);
      buffer.append(c);
      node = node.m_arrNeighbours[m_nDirection];
    }
    
    return buffer.toString();
  }

  void checkConstraint()
  {
    m_nValid = checkConstraint(getStringToMatch());
  }
  
  int checkConstraint(String str)
  {
    TreeSet<State> states = new TreeSet<State>();
    states.add(m_automaton.getInitialState());
  
    for (int n = 0; n < str.length(); ++n)
    {
      char c = str.charAt(n);
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
        return -1;
      }
      
      states = allNext;
    }
    
    states.retainAll(m_automaton.getAcceptStates());
    
    if (states.size() == 0)
    {
      return -1;
    }
    else
    {
      return +1;
    }
  }
};

class ConstraintWithGrouping extends Constraint
{
  ConstraintWithGrouping(HexNode nodeStart, int nDirection, String sRegExp)
  {
    super(nodeStart, nDirection, sRegExp);
  }
  
  int checkConstraint(String str)
  {
    if (str.indexOf(' ') != -1)
    {
      return 0;
    }
    else if (str.matches(m_sRegExp))
    {
      return +1;
    }
    else
    {
      return -1;
    }
  }
};



