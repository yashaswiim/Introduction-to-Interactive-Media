/*
Submitted by: Yashaswi Malla(ym1929)
 Submitted date: June 10, 2020
 
 Concept:
 All the 52 cards are divided among the two players 
 Before that one card of jack is removed from the stack so that one jack in the stack has no match. 
 From all the cards that the player has, he/she has to remove all the pairs. 
 Once both the players remove all pairs from their respective cards, 
 they alternately draw cards from each other's cards. 
 If it matches, then they remove that pair from their cards as well. 
 The first to finish all of his/her cards is the winner. 
 The one who is left with the unmatched jack is the loser/thief.
 */
//===========================//===========================//===========================

import processing.sound.*;
SoundFile matched;                                                        //sound for correct pair
SoundFile victory;                                                        //sound for victory
SoundFile lose;                                                           //sound for losing
PImage cardsImg;                                                          //image with all cards together
Gamee myGame=new Gamee();
int myDelay=0;                                                            //used to keep some display on screen for some time

void setup() {
  size(1440, 800);
  background(0, 100, 0);
  cardsImg=loadImage("/Users/yashaswi/Desktop/cards.png");
  cardsImg.resize(CARDWIDTH*13, CARDHEIGHT*4);

  matched = new SoundFile(this, "/Users/yashaswi/Desktop/ThrowPair.mp3");
  victory = new SoundFile(this, "/Users/yashaswi/Desktop/victory.mp3");
  lose = new SoundFile(this, "/Users/yashaswi/Desktop/lose.mp3");
}
void draw() {
  if (!myGame.started && !myGame.ins) {                                    //home page

    background(0, 100, 0);
    textSize(30);
    text("THE JACK THEIF", 600, 50);
    myGame.instructions.display();
    textSize(25);
    text("Click anywhere to start", 600, 650);
  } else if (!myGame.started && myGame.ins) {                              //instruction page

    background(0, 100, 0);
    text("THE JACK THEIF", 600, 50);
    fill(0, 100, 0);
    rect(400, 100, 600, 400);
    fill(0);
    textSize(15);
    text("All the 52 cards are divided among the two players\n"+
      "Before that one card of jack is removed from the stack \n"+
      "so that one jack in the stack has no match. \n"+
      "From all the cards that the player has, he/she has to remove all the pairs. \n"+
      "Once both the players remove all pairs from their respective cards, \n"+
      "they alternately draw cards from each other's cards. \n"+
      "If it matches, then they remove that pair from their cards as well.\n"+ 
      "The first to finish all of his/her cards is the winner. \n"+
      "The one who is left with the unmatched jack is the loser/thief.\n", 420, 130);
    textSize(25);
    text("Click anywhere to start", 600, 650);
  } else {

    if (myGame.myDelay) {                                                //delaying display of other things
      myDelay++;
      if (myDelay==60) {
        myGame.myDelay=false;
        myDelay=0;
      }
    }
    if (! myGame.checkEnd() && !myGame.myDelay) {                        //normal display

      background(0, 100, 0);
      myGame.display();
      if (myGame.pairThrown && !myGame.computer.turn && !myGame.player.turn) {

        if (myGame.player.cards.size()>myGame.computer.cards.size()) {    //checking for the first player to start

          myGame.myDelay=true;
          myGame.computer.turn=true;
          myGame.computer.drawCard(myGame.player, 
            (int)random(1, myGame.player.cards.size()+1));
        } else {

          myGame.player.turn=true;
          text("Press the number of the card you want to pick in your keyboard\n"+
            "1=1st, 2=2nd, ..., 9=9th, x=10th, j=11th, q=12th, k=13th", 600, 450);
        }
      } else if (myGame.pairThrown && myGame.computer.turn ) {             //drawing cards in respective turn            

        myGame.myDelay=true;
        myGame.computer.drawCard(myGame.player, (int)random(1, myGame.player.cards.size()+1));
      } else if (myGame.pairThrown && myGame.player.turn) {

        text("Press the number of the card you want to pick in your keyboard\n"+
          "1=1st, 2=2nd, 3=3rd, ..., 9=9th, x=10th, j=11th, q=12th, k=13th", 600, 450);
      }
    } else if (myGame.checkEnd()) {                                        //checking the end of game

      background(0, 100, 0);
      myGame.display();
      textSize(25);
      text("WINNER : "+myGame.returnWinner()+"!!!!!", 600, 400);
      text("Click anywhere to restart", 570, 500);
    }
  }
}

void mouseClicked() {
  if (!myGame.started && dist(mouseX, mouseY, 720, 400)<70) {            //check if player click instructions button
    myGame.ins=true;
  } else if (!myGame.started) {
    myGame.start();
  } else if (myGame.started && dist(mouseX, mouseY, 1390, 400)<50) {     //check if player clicks ThrowPair button 
    myGame.throwPairCards();
  }
  if (myGame.end) {                                                      //restarting game after end
    myGame=new Gamee();
  }
}

void keyPressed() {
  if (myGame.player.turn) {                                                //chcking correct key pressed
    if ( (myGame.computer.cards.size()<10 && 
      key>='1' && key<=str(myGame.computer.cards.size()).charAt(0) ) ||
      ( myGame.computer.cards.size()==10 &&
      ((key>='1' && key<='9') || key=='x') ) ||
      ( myGame.computer.cards.size()==11 &&
      ((key>='1' && key<='9') || key=='x' || key=='j') ) ||
      ( myGame.computer.cards.size()==12 &&
      ((key>='1' && key<='9') || key=='x' || key=='j'||key=='q') ) ||
      ( myGame.computer.cards.size()==13 &&
      ((key>='1' && key<='9') || key=='x' || key=='j'||key=='q'||key=='k')) ) {

      int myKeyInt=0;
      if (myGame.computer.cards.size()<10 || key<='9') {
        myKeyInt=int(str(key));
      } else {
        switch (key) {
        case 'x':
          myKeyInt=10;
          break;
        case 'j':
          myKeyInt=11;
          break;
        case 'q':
          myKeyInt=12;
          break;
        case 'k':
          myKeyInt=13;
          break;
        }
      }
      myGame.player.drawCard(myGame.computer, myKeyInt);                    //drawing card according to key pressed
    } else {
      text("Invalid key", 700, 500);
      myGame.myDelay=true;
    }
  }
}
