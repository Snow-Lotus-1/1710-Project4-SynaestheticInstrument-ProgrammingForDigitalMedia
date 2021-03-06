class Button 
{
  int x, y, widthB, heightB;
  boolean[] steps;
  int stepId;
  float ui = 255;
  
  public Button(int xIn, int yIn, boolean[] stepsIn, int idIn)
  {
    x = xIn;
    y = yIn;
    widthB = 30;
    heightB = 30;
    steps = stepsIn;
    stepId = idIn;
  }
  
  public void draw()
  {
    if ( steps[stepId] )
    {
      fill(255,255,255, ui);
    }
    else
    {
      fill(0,0,0,ui);
    }
    ellipseMode(RIGHT);
    ellipse(x,y,widthB,heightB);
  }
  
  public void mousePressed()
  {
    //if mouse is within the boarder of the button
    //toggle it on or off
    if (mouseX >= x && mouseX <= x+widthB && mouseY >= y && mouseY <= y+heightB)
    {
      steps[stepId] = !steps[stepId];
    }
  }
}
