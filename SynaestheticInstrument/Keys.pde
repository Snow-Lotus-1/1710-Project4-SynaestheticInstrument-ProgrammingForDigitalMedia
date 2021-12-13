void keyPressed() {  
  if (key == 'u') {
    for(int i = 0; i < buttons.size(); ++i)
    {
      buttons.get(i).steps[buttons.get(i).stepId] = false;
    }
  }
  
  if (key == 'h') {
    for(int i = 0; i < buttons.size(); ++i)
    {
      if (buttons.get(i).ui == 255){
        buttons.get(i).ui = 0;
        ui = 0;
        ui2 = 0;
      }
      else{
        buttons.get(i).ui = 255;
        ui = 255;
        ui2 = 100;
      }
    }
  }
}
