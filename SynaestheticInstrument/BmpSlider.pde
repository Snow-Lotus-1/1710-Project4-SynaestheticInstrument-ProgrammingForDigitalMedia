//Code based off of PixelExample7
class BpmSlider {  
  PVector position, target, mouse;
  float speed;
  float dotSize;
  int bpm;
  int counter = 0;
  boolean mp = false;
  
  BpmSlider(int bpmIn) {
    position = new PVector(1075,height/2);
    target = new PVector(1075,height/2);
    speed = 0.1;
    dotSize = 50;
    bpm = bpmIn;
  }
  
  void update() {
    mouse = new PVector(mouseX, mouseY);
    
    if (mp){
      if ((position.dist(mouse) < 20)){
        target.x = mouse.x;
        target.y = mouse.y;
      } 
      
      if(bpm > 30){
        while (target.y > position.y){
          position.y++;
          bpm--;
          if (bpm < 30){
            bpm = 30;
          }
        }
      }
      
      if(bpm < 240){
        while (target.y < position.y){
          position.y--;
          bpm++;
          if (bpm > 240){
            bpm = 240;
          }
        }
      }
    }
  }
  
  void draw() {
    ellipseMode(CENTER);
    noStroke();
    fill(0,0,255);
    ellipse(position.x, position.y, dotSize, dotSize);
  }
  
  void run() {
    update();
    draw();
  } 
  
  void mousePressed()
  {
    mp = true;
  }
  
  void mouseReleased()
  {
    mp = false;
  }
}
