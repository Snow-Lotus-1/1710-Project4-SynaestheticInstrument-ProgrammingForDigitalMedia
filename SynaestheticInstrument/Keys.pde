void keyPressed() {  
  if (key == 'u') {
    for(int i = 0; i < buttons.size(); ++i)
    {
      buttons.get(i).steps[buttons.get(i).stepId] = false;
    }
  }
}
