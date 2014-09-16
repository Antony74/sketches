
// Automaton library is required!
// http://www.brics.dk/automaton/download.html
import dk.brics.automaton.*;

class Constraint
{
  String m_sRegExp;
  HexNode m_nodeStart;
  int m_nDirection;
  Automaton m_automaton;
  
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
    fill(0);
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


