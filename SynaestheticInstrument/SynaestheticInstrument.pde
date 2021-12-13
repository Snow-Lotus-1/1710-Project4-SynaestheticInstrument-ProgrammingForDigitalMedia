//heavily based of the minim drumkit example (http://code.compartmental.net/minim/index.html)
//drumkit sounds came from the example
//piano sounds came from free sound (https://freesound.org/people/pinkyfinger/packs/4409/) more info in readme
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Sampler kick, snare, hat;
Sampler pianoA, pianoB, pianoBB, pianoC, pianoCB, pianoD, pianoE, pianoEB, pianoF, pianoFB, pianoG, pianoGB;

//check if sampler is on
boolean[] hatRow = new boolean[32];
boolean[] snrRow = new boolean[32];
boolean[] kikRow = new boolean[32];

//ordered from lowest to highest descending
boolean[] pngRow = new boolean[32];
boolean[] pnaRow = new boolean[32];
boolean[] pnbbRow = new boolean[32];
boolean[] pnbRow = new boolean[32];
boolean[] pncbRow = new boolean[32];
boolean[] pncRow = new boolean[32];
boolean[] pndRow = new boolean[32];
boolean[] pnebRow = new boolean[32];
boolean[] pneRow = new boolean[32];
boolean[] pnfbRow = new boolean[32];
boolean[] pnfRow = new boolean[32];
boolean[] pngbRow = new boolean[32];

//array for buttons 
ArrayList<Button> buttons = new ArrayList<Button>();

//beats per min
int bpm = 60;

int beat; // which beat we're on

BpmSlider bpmSlider; 

boolean[] hatRipple = new boolean[32];
boolean[] snrRipple = new boolean[32];
boolean[] kikRipple = new boolean[32];

boolean[] pngRipple = new boolean[32];
boolean[] pnaRipple = new boolean[32];
boolean[] pnbbRipple = new boolean[32];
boolean[] pnbRipple = new boolean[32];
boolean[] pncbRipple = new boolean[32];
boolean[] pncRipple = new boolean[32];
boolean[] pndRipple = new boolean[32];
boolean[] pnebRipple = new boolean[32];
boolean[] pneRipple = new boolean[32];
boolean[] pnfbRipple = new boolean[32];
boolean[] pnfRipple = new boolean[32];
boolean[] pngbRipple = new boolean[32];


int[] rippleSize = new int[32];
float[] rippleAlpha = new float[32];
float[] rippleX = new float[32];
float[] rippleY = new float[32];

void setup()
{
  size(1100, 900);
  minim = new Minim(this);
  out = minim.getLineOut();
  
  //(http://code.compartmental.net/minim/sampler_class_sampler.html)
  kick  = new Sampler("drum/kick.wav", 4, minim);
  snare = new Sampler("drum/snare.wav", 4, minim);
  hat   = new Sampler("drum/hat.wav", 4, minim);
  
  pianoG = new Sampler("piano/pG.wav", 4, minim); pianoA = new Sampler("piano/pA.wav", 4, minim); pianoBB = new Sampler("piano/pBB.wav", 4, minim);
  pianoB = new Sampler("piano/pB.wav", 4, minim); pianoCB = new Sampler("piano/pCB.wav", 4, minim); pianoC = new Sampler("piano/pC.wav", 4, minim);
  pianoD = new Sampler("piano/pD.wav", 4, minim); pianoEB = new Sampler("piano/pEB.wav", 4, minim); pianoE = new Sampler("piano/pE.wav", 4, minim); 
  pianoFB = new Sampler("piano/pFB.wav", 4, minim); pianoF = new Sampler("piano/pF.wav", 4, minim); pianoGB = new Sampler("piano/pGB.wav", 4, minim);
  
  // patch samplers to the output
  kick.patch(out); snare.patch(out); hat.patch(out);
  pianoG.patch(out); pianoA.patch(out); pianoBB.patch(out);
  pianoB.patch(out); pianoCB.patch(out); pianoC.patch(out);
  pianoD.patch(out); pianoEB.patch(out); pianoE.patch(out);
  pianoFB.patch(out); pianoF.patch(out); pianoGB.patch(out);
  
  for (int i = 0; i < 32; i++)
  {
    buttons.add(new Button(10+i*32, 50, hatRow, i));
    buttons.add(new Button(10+i*32, 100, snrRow, i));
    buttons.add(new Button(10+i*32, 150, kikRow, i));
    
    buttons.add(new Button(10+i*32, 250, pngRow, i)); buttons.add(new Button(10+i*32, 300, pnaRow, i)); buttons.add(new Button(10+i*32, 350, pnbbRow, i));
    buttons.add(new Button(10+i*32, 400, pnbRow, i)); buttons.add(new Button(10+i*32, 450, pncbRow, i)); buttons.add(new Button(10+i*32, 500, pncRow, i));
    buttons.add(new Button(10+i*32, 550, pndRow, i)); buttons.add(new Button(10+i*32, 600, pnebRow, i)); buttons.add(new Button(10+i*32, 650, pneRow, i));
    buttons.add(new Button(10+i*32, 700, pnfbRow, i)); buttons.add(new Button(10+i*32, 750, pnfRow, i)); buttons.add(new Button(10+i*32, 800, pngbRow, i));
    
    rippleSize[i] = 0;
    rippleAlpha[i] = 100;
    rippleX[i] = random(width);
    rippleY[i] = random(height);
  }
  
  beat = 0;
  
  // start the sequencer
  out.setTempo(bpm);
  out.playNote(0, 0.25f, new Tick());
  
  bpmSlider = new BpmSlider(bpm);
}

void draw()
{
  background(127);
  fill(255);
  text(frameRate, width - 60, 20);
  
  
  
  
   
  for(int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).draw();
  }
  
  stroke(128);
    
  // beat marker   
  fill(200);
  rect(10+beat*32, 35, 30, 9);
  
  //bpm slider background
  rect(1050, 245, 50, 265);
  
  bpmSlider.update();
  bpmSlider.draw();
  bpm = bpmSlider.bpm;
  out.setTempo(bpm);
  text("BPM: "+bpm, 1045, 240);
  
 
  rippleEffect(hatRow, hatRipple, 255, 255, 0);
  rippleEffect(snrRow, snrRipple, 255, 0, 255);
  rippleEffect(kikRow, kikRipple, 0, 255, 255);
  
  rippleEffect(pngRow, pngRipple, 200, 200, 0);
  rippleEffect(pnaRow, pnaRipple, 250, 150, 0);
  rippleEffect(pnbbRow, pnbbRipple, 0, 150, 250);
  rippleEffect(pnbRow, pnbRipple, 200, 0, 200);
  rippleEffect(pncbRow, pncbRipple, 255, 200, 200);
  rippleEffect(pncRow, pncRipple, 250, 0, 150);
  rippleEffect(pndRow, pndRipple, 0, 200, 150);
  rippleEffect(pnebRow, pnebRipple, 150, 250, 100);
  rippleEffect(pneRow, pneRipple, 100, 150, 250);
  rippleEffect(pnfbRow, pnfbRipple, 250, 100, 150);
  rippleEffect(pnfRow, pnfRipple, 100, 250, 100);
  rippleEffect(pngbRow, pngbRipple, 50, 100, 250); 
}

void rippleEffect(boolean[] row, boolean[] ripple, int r, int g, int b){
  if (row[beat]){  
    for(int i = 0; i < ripple.length; ++i){    
      if(ripple[i] == false){
        ripple[i] = true;
        break;
      }
    }  
  }
  for(int i = 0; i < ripple.length; ++i){  
    if (ripple[i]){
      fill(r, g, b, rippleAlpha[i]);
      ellipse(rippleX[i], rippleY[i], rippleSize[i], rippleSize[i]);
      rippleAlpha[i]--; rippleSize[i]+=5;
      if(rippleAlpha[i] == 0){
        rippleAlpha[i] = 100;
        rippleSize[i] = 0;
        ripple[i] = false;
      } 
    }
  } 
}

void mousePressed()
{  
  bpmSlider.mousePressed();
  
  for(int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).mousePressed();
  }
}

void mouseReleased()
{
  bpmSlider.mouseReleased();
}
