
import java.io.*;

int nUnitLength;
int nStoneLength;
int nTextSize = 14;

Vector<String> moves = new Vector<String>();
Vector<String> sgfFiles = new Vector<String>();

int nCurrentFile = 0;
int nCurrentMove = 0;

void setup()
{
  size(650,650);
  smooth();
  textSize(nTextSize);
  nUnitLength = width / 22;
  nStoneLength = (nUnitLength * 9) / 10;
  
  String dirlist[] = (new File(savePath(""))).list();
  for (int n = 0; n < dirlist.length; ++n)
  {
    String sFilename = dirlist[n];
    if (sFilename.endsWith(".sgf"))
    {
      sgfFiles.add(sFilename);
    }
  }

  load(savePath(sgfFiles.elementAt(0)));
}

void keyPressed()
{
  switch(keyCode)
  {
  case LEFT:
    if (nCurrentMove > 0)
    {
      --nCurrentMove;
      loop();
    }
    break;
  case RIGHT:
    if (nCurrentMove < moves.size())
    {
      ++nCurrentMove;
      loop();
    }
    break;
  case UP:
    --nCurrentFile;
    if (nCurrentFile < 0)
      nCurrentFile = sgfFiles.size() - 1;
    load(savePath(sgfFiles.elementAt(nCurrentFile)));
    break;
  case DOWN:
    ++nCurrentFile;
    nCurrentFile %= sgfFiles.size();
    load(savePath(sgfFiles.elementAt(nCurrentFile)));
    break;
  }
}

void load(String sFilename)
{
  moves.clear();

  try
  {
    BufferedReader reader = new BufferedReader(new FileReader(sFilename));
    String sLine = reader.readLine();
    while (sLine != null)
    {
      if (sLine.length() == 6 && sLine.charAt(0) == ';')
      {
        moves.add(sLine);
//        println(sLine);
      }
      sLine = reader.readLine();
    }
  }
  catch(FileNotFoundException e)
  {
    println(e);
  }
  catch(IOException e)
  {
    println(e);
  }
  
  nCurrentMove = moves.size();
  loop();
}

void draw()
{
  translate(nUnitLength * 2, nUnitLength * 2);
  
  drawBoard();
  String sMsg = "(file " + (nCurrentFile+1) + " of " + sgfFiles.size() + ") " + sgfFiles.elementAt(nCurrentFile) + " (move " + nCurrentMove + " of " + moves.size() + ")";
  text(sMsg, 0, height - (nUnitLength*3));
  
  for (int nMove = 0; nMove < nCurrentMove; ++nMove)
  {
    String sMove = moves.elementAt(nMove);
    int nTextColour = 128;
    
    switch(sMove.charAt(1))
    {
    case 'B':
      fill(0);
      nTextColour = 255;
      break;
      
    case 'W':
      fill(255);
      nTextColour = 0;
      break;
      
    default: // wtf?
      fill(255,0,0);
    }
    
    int x = coord(sMove.charAt(3));   
    int y = coord(sMove.charAt(4));   
    ellipse(x, y, nStoneLength, nStoneLength);
    fill(nTextColour);
    String sText = ((Integer)(nMove + 1)).toString();
    float nTextWidth = textWidth(sText);
    text(sText, x - (nTextWidth/2), y + (nTextSize/2) - 1);
  }
  
  noLoop();
}

void drawBoard()
{
  background(255,126,0);

  for (int x = 1; x <= 19; ++x)
  {
    line(coord(x), coord(1), coord(x), coord(19));
  }

  for (int y = 1; y <= 19; ++y)
  {
    line(coord(1), coord(y), coord(19), coord(y));
  }
  
  // Star points
  fill(0);
  ellipse(coord(4),  coord(4),  5, 5);
  ellipse(coord(10), coord(4),  5, 5);
  ellipse(coord(16), coord(4),  5, 5);
  ellipse(coord(4),  coord(10), 5, 5);
  ellipse(coord(10), coord(10), 5, 5);
  ellipse(coord(16), coord(10), 5, 5);
  ellipse(coord(4),  coord(16), 5, 5);
  ellipse(coord(10), coord(16), 5, 5);
  ellipse(coord(16), coord(16), 5, 5);
}

int coord(int nPos)
{
  return nUnitLength * (nPos - 1);
}

int coord(char cPos)
{
  return coord((int)(cPos - 'a' + 1));
}


