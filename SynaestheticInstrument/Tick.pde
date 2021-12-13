// here's an Instrument implementation that we use 
// to trigger Samplers every sixteenth note. 
// Notice how we get away with using only one instance
// of this class to have endless beat making by 
// having the class schedule itself to be played
// at the end of its noteOff method. 
class Tick implements Instrument
{
  void noteOn( float dur )
  {
    if (hatRow[beat]){hat.trigger();}
    if (snrRow[beat]){snare.trigger();}
    if (kikRow[beat]){kick.trigger();}
    
    if (pngRow[beat]){pianoG.trigger();}
    if (pnaRow[beat]){pianoA.trigger();}
    if (pnbbRow[beat]){pianoBB.trigger();}
    if (pnbRow[beat]){pianoB.trigger();}
    if (pncbRow[beat]){pianoCB.trigger();}
    if (pncRow[beat]){pianoC.trigger();}
    if (pndRow[beat]){pianoD.trigger();}
    if (pnebRow[beat]){pianoEB.trigger();}
    if (pneRow[beat]){pianoE.trigger();}
    if (pnfbRow[beat]){pianoFB.trigger();}
    if (pnfRow[beat]){pianoF.trigger();}
    if (pngbRow[beat]){pianoGB.trigger();}
  }
  
  void noteOff()
  {
    // next beat
    beat = (beat+1)%32;
    // set the new tempo
    out.setTempo(bpm);
    // play this again right now, with a 32 note duration
    out.playNote(0, 0.25f, this);
  }
}
