/*
Submitted by: Yashaswi Malla (ym1929)
Submitted Date: June 21, 2020

Concept:
* There is a basket moving to and fro from left to right.
* There are 10 objects on the top of the screen that appear one by one
* When the switch is pressed, the items are dropped
* The goal is to drop the items such that they fall into the basket
* The score is the number of items collected in the basket
* The green LED is turned on when the item is successfully collected
* The red LED is turned on when the item is missed

Communication used:
* Processing receives the signal from Arduino when the switch is pressed.
* Processing sends signal to Arduino when it is time to:
  * turn on the green LED
  * turn on the red LED
  * turn off both LEDs
 
 */
//==================================//==================================//==================================

import processing.serial.*;
Serial myPort;
int incomingSignal=0;
PFont font;

Game myGame;                                            // new instance of the Game class

void setup() {
  size(600, 500);
  myGame=new Game();
  println(Serial.list());                               // List all the available serial ports
  myPort = new Serial(this, Serial.list()[1], 9600);    // Open the port that is being used
  myPort.bufferUntil('\n');                             // don't generate a serialEvent() unless you get a newline character
}

void draw() {
  background(255, 230, 165);
  if (myGame.finish) {                                  // check if game has finished
    background(170, 245, 250);
    fill(0);
    font = createFont("Rockwell-Italic", 32);
    textSize(25);
    textFont(font);
    text("Score: "+myGame.score, width/2-50, 100);
    fill(130,170,130);
    textSize(30);
    text("CLICK ANYWHERE TO RESTART", width/2-200, height/2);
  } else {                                              // if game has not finished:
    myGame.display();                                
    myGame.startGame();
    if (incomingSignal==1) {                            // if switch is pressed:
      myGame.drop=true;                                 // drop the item from the top
    }
    if (myGame.drop) {          
      myGame.dropObject();
      if (myGame.checkBottom()) {                       //if object has reached bottom:
        myGame.drop=false;                              //stop dropping
        if (myGame.checkBasket()) {                     //check if it droppen into the basket
          myGame.score++;                               //if it falls into the basket score +1
          myPort.write('G');                            //send signal to turn on green LED
        } else {
          myPort.write('R');                            //otherwise, send signal to turn on red LED
        }
        myGame.objectReachedBottom=true;
      }
    }
  }
}

void mouseClicked() {
  if (myGame.finish) {
    myGame=new Game();                                  //restart game on mouse click after finishing
  }
}
//
void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');       // get the ASCII string:

  if (inString != null) {
    inString = trim(inString);                          // trim off any whitespace:
    incomingSignal = int(inString);                     // convert into an integer:

    if (incomingSignal==0) {                              // if signal is 0, i.e. switch not pressed: 
      myPort.write('L');                                //send signal to turn LEDs off
    }
  }
}
