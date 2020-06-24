/*
Submitted by: Yashaswi Malla (ym1929)
 Submitted Date: 24 June, 2020
 
 INFODIS 
 * stands for Information Dissemination
 * The concept is to create a system that can be used for the winner declaration in any two player of two team games 
 * For demo, I chose to perform the winner declaration of FIFA World Cup 2018
 * What happens is that the user is displayed a screen with 
 * a box for the winner position and 
 * two symbolics, one for each of the two players/ teams of the game
 * The user has to drag the symbol for the winning player/team into the box 
 * and press the switch on the breadboard 
 * the program will do the following things:
 * Raise the respective flag or symbol of the winner (using servo motor)
 * Light up the LED below the name board of the winner
 * Display the winner name below the "Congratulations!" message on the LCD
 * Also, play the theme tune of the game when the winner is announced
 
 * Since I chose to do the FIFA World Cup, 
 * The two teams are the finalist countries: France and Croatia
 * Their flags are their symbols on the servo motor 
 * Their jerseys are their symbols on the screen
 * Whenever one of the two symbols is dragged to the winner box, 
 * its flag is raised, 
 * the LED below its name is lit up 
 * the LCD displays "Congratulations! <country name>" 
 * while playing the official theme tune of FIFA World Cup 2018. 
 *All of these happen for 12 seconds and then go back to normal.
 */
//=================//=================//=================//=================//=================

import processing.serial.*;                                    //to use the serial port
import ddf.minim.*;                                            //library for playing audio files

Minim minim;
Serial myPort;                                                 
int incomingSignal=0;                                          //for incoming signal about switched pressed from Arduino
PFont font;                                                    //for creating font
AudioPlayer player;
PImage bgImage;                                                //for background image

//constants
final int POSITIONBOXWIDTH=150;
final int POSITIONBOXHEIGHT=200;
final int PERSONHEIGHT=150;
final int PERSONWIDTH=100;

Position winner;
Person[] players=new Person[2];                                //two players of the game
boolean[] move={false, false};

void setup() {
  size(1000, 900);
  imageMode(CENTER);
  bgImage=loadImage("fifa.png");                              //background image
  bgImage.resize(1000, 900);
  minim=new Minim(this);
  player=minim.loadFile("2018.mp3");                          //theme music

  println(Serial.list());                                     // List all the available serial ports
  myPort = new Serial(this, Serial.list()[1], 9600);          // Open the port that is being used
  myPort.bufferUntil('\n');                                   // don't generate a serialEvent() unless you get a newline character

  winner=new Position("Winner", width/2);                     //create the position box
  String countries[]={"France", "Croatia"};
  for (int i=0; i<2; i++) {                                   //create Person objects (players)
    players[i]=new Person(countries[i], (i*2));
  }
}

void draw() {
  image(bgImage, width/2, height/2);                          //set background
  font = createFont("Rockwell", 32);
  fill(255);
  textFont(font);
  textSize(35);
  text("INFODIS (WINNER DECLARATION)", width/4, height/10);  //name of the program
  textSize(15);
  text("Drag the winner to the green box and"+               //instructions
    "press the switch", width/4+80, height/8);
  winner.display();                                          //display the position box
  fill(0, 255, 0, 30);
  stroke(0, 255, 0);
  rect(winner.xPosition, 
    winner.yPosition-POSITIONBOXHEIGHT/2-120, 
    POSITIONBOXWIDTH, 240);
  for (int i=0; i<2; i++) {                                  //display the player symbols 
    players[i].display();
  }
  for (int i=0; i<2; i++) {                  
    if (move[i] && mousePressed) {                           //drag the player symbols
      players[i].xPosition=mouseX;
      players[i].yPosition=mouseY;
    }
  }
  if (incomingSignal==1) {                                   //check if the switch is pressed according to incoming signal
    winner.player=null;
    for (int i=0; i<2; i++) {
      if (players[i].checkGreenBox()) {                      //check which player is in the winner box
        winner.player=players[i];
      }
    }
    if (winner.player.country=="France") {                   //France=left=L
      myPort.write('L');
      player.play();                                         //play audio file
      player.rewind();
    } else if (winner.player.country=="Croatia") {           //Croatia=right=R
      myPort.write('R');
      player.play();                                         //play audio file
      player.rewind();
    } else {                                                 //check if button is being pressed without choosing the winner
      textSize(20);
      fill(255);
      text("First Announce the Winner", width/3+40, height/6);
    }
  }
}


void mousePressed() {                                         //check if the user clicked on the right position before dragging
  for (int i=0; i<2; i++) {
    if (mouseX>=players[i].xPosition-PERSONWIDTH/2 && 
      mouseX<=players[i].xPosition+PERSONWIDTH/2 && 
      mouseY>=players[i].yPosition-PERSONHEIGHT/2 && 
      mouseY<=players[i].yPosition+PERSONHEIGHT/2) {
      move[i]=true;
    }
  }
}
void mouseReleased() {                                        //do not move/drag the object if mouse Released
  for (int i=0; i<2; i++) {
    move[i]=false;
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');             // get the ASCII string:

  if (inString != null) {
    inString = trim(inString);                                // trim off any whitespace:
    incomingSignal = int(inString);                           // convert into an integer:
  }
  if (incomingSignal==0) {                                    // if signal is 0, i.e. switch not pressed: 
    myPort.write('N');                                        //send signal to turn everything off
  }
}
