
class SaveButton extends Button
{
  SaveButton(char key, CanvasBase myCanvas)
  {
    super(key);
    canvasBase = myCanvas;
  }
  
  void buttonPressed(int mouseButton)
  {
    canvasBase.save("SavedPainting.png");
  }

  boolean drawIcon()
  {
    stroke(0);
    fill(0,0,255);
    
    beginShape();
    vertex((width * 0.2),     (height * 0.8) - 3);
    vertex((width * 0.2) + 3, (height * 0.8));
    vertex((width * 0.8) - 1, (height * 0.8));
    vertex((width * 0.8),     (height * 0.8) - 1);
    vertex((width * 0.8),     (height * 0.2) + 1);
    vertex((width * 0.8) - 1, (height * 0.2));
    vertex((width * 0.2) + 1, (height * 0.2));
    vertex((width * 0.2),     (height * 0.2) + 1);
    endShape(CLOSE);
    
    fill(255);
    rect(width * 0.3, height * 0.2, width * 0.4, height * 0.3);
    
    fill(128);
    rect(width * 0.35, height * 0.6, width * 0.3, height * 0.2);

    fill(0,0,255);
    rect((width * 0.4), (height * 0.6) + 2, (width * 0.075) - 1, (height * 0.2) - 4);

    return true;
  }

  CanvasBase canvasBase;
}


