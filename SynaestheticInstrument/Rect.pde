class Button 
{
  int x, y, widthB, heightB;
  boolean[] steps;
  int stepId;
  
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
      fill(0,255,0);
    }
    else
    {
      fill(255,0,0);
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
