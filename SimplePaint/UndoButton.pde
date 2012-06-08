
class UndoButton extends Button
{
  UndoButton(char key)
  {
    cKey = key;
  }

  void buttonPressed(int mouseButton)
  {
    canvas.undo();
  }
  
  boolean drawIcon()
  {
    int head = 10;

    strokeWeight(3);
    if (canvas.canUndo())
      stroke(0,0,255);
    else
      stroke(160);
    smooth();
    noFill();
    float arcHeight = height * 0.5;
    arc(width * 0.2 + 3, (height + arcHeight) * 0.5, width, arcHeight, 1.5 * PI, TWO_PI);
    line(width * 0.2, height * 0.5, (width * 0.2) + head, (height * 0.5) + head);
    line(width * 0.2, height * 0.5, (width * 0.2) + head, (height * 0.5) - head);

    return true;
  }

};

class RedoButton extends Button
{
  RedoButton(char key)
  {
    cKey = key;
  }

  void buttonPressed(int mouseButton)
  {
    canvas.redo();
  }

  boolean drawIcon()
  {
    int head = 10;

    strokeWeight(3);
    if (canvas.canRedo())
      stroke(0,0,255);
    else
      stroke(160);
    smooth();
    noFill();
    float arcHeight = height * 0.5;
    arc(width * 0.8 - 3, (height + arcHeight) * 0.5, width, arcHeight, PI, 1.5 * PI);
    line(width * 0.8, height * 0.5, (width * 0.8) - head, (height * 0.5) + head);
    line(width * 0.8, height * 0.5, (width * 0.8) - head, (height * 0.5) - head);

    return true;
  }
};

