void keyPressed() {
  if (key==' '||keyCode==33) { //REC works with space or pgdn from clicker
    doButtonRec();
  }

  if(key=='c'||key=='C'||keyCode==34){  //CAM works with C key or pgup from clicker
    doButtonCam();
  }
}

void mouseReleased(){
  if (buttons[buttonRecNum].clicked) { //REC
    doButtonRec();
  }
  
  else if (buttons[buttonOscNum].clicked) {  //OSC from OSCeleton
    doButtonOsc();
  }
  
  else if (buttons[buttonSaveNum].clicked) { //SAVE
    doButtonSave();
  }
  else if (buttons[buttonPlayNum].clicked) { //PLAY
    doButtonPlay();
  }
  else if (buttons[buttonStopNum].clicked) {  //STOP
    doButtonStop();
  }
  else if (buttons[buttonCamNum].clicked) {  //CAM
    doButtonCam();
  }

if (buttons[buttonRecNum].hovered) {
    sayTextPrefix = "Record skeleton data";

}else if (buttons[buttonOscNum].hovered) {
    sayTextPrefix = "Record OSC data";
    
}else if (buttons[buttonSaveNum].hovered) {
    sayTextPrefix = "Save all XML files for After Effects";
}else if (buttons[buttonPlayNum].hovered) {
    sayTextPrefix = "Play back last saved XML file";
}else if (buttons[buttonStopNum].hovered) {
    sayTextPrefix = "Stop recording";
}else if (buttons[buttonCamNum].hovered) {
    sayTextPrefix = "Toggle camera view";
}
}

void buttonHandler() {
  for (int i=0;i<buttons.length;i++) {
  if(modePreview){
    buttons[buttonCamNum].checkButton();
    buttons[buttonCamNum].drawButton();
  }else{
    buttons[i].checkButton();
    buttons[i].drawButton();
  }
  }
}

void buttonsRefresh() {
  for (int i=0;i<buttons.length;i++) {
    buttons[i].clicked = false;
  }
}

void modesRefresh() {
  countdown = new Countdown(8, 2);
  buttonsRefresh();
  counter=0;
  modeRec = false;
  modeOsc = false;
  modePlay = false;
  modeExport = false; 
  modeStop=false;
  modePreview=false;
}

void doButtonRec(){
    if(!modeRec){
    if (firstRun) {
      firstRun=false;
      setupUser(); //this sets up SimpleOpenNi
    }
    modesRefresh();
    xmlRecorderInit();
    modeRec = true;
    if (!needsSaving) {
      needsSaving = true;
      masterFileCounter++;
    }
  }else{
    modesRefresh();
    if (needsSaving) {
      countdown.foo.play();
      xmlSaveToDisk();
    }
    needsSaving=false;
  }
}


void doButtonOsc(){
    modesRefresh();
    xmlRecorderInit();
    modeOsc = true;
    if (!needsSaving) {
      needsSaving = true;
      masterFileCounter++;
    }
  }

void doButtonStop(){
    modesRefresh();
    if (needsSaving) {
      countdown.foo.play();
      xmlSaveToDisk();
    }
    needsSaving=false;
}

void doButtonPlay(){
    modesRefresh();
    if (needsSaving) {
      xmlSaveToDisk();
    }
    modePlay = true;
}

void doButtonSave(){
    modesRefresh();
    modeExport = true;
    if(savePins) aePinSaveToDisk(masterFileCounter);    
    if(savePoints) aePointSaveToDisk(masterFileCounter);    
    //if(saveJson) aeJsxSaveToDisk(masterFileCounter);    
    if(saveJsx) aeJsxSaveToDisk(masterFileCounter);    
    if(saveMaya) mayaSaveToDisk(masterFileCounter);
}

void doButtonCam(){
    if (modePreview) {
    modesRefresh();
      //modePreview=false;
    }
    else if (!modePreview) {
      if (firstRun) {
        firstRun=false;
        setupUser(); //this sets up SimpleOpenNi
      }
      modesRefresh();
      modePreview=true;
    }
    //needsSaving=false;
}