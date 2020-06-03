/*
Memory Game - A card game in which all the cards are laid face down.
 Two cards are flipped face up over at a time. 
 The objective of the game is to turn over all the pairs of matching cards.
 */

//Class for cards required for the game 
class Card {
  int cardWidth, cardHeight;       //width and height of the card
  int cardNumber;                  //card number to determine whether the right pair has been turned over
  int[] cardColor=new int[3];      //color of the card to distinguish each pair of matching cards from the other pairs
  boolean solved;                  //to check if the card and its pair is already turned over
  boolean open;                    // to check if the card is facing up or down
  Card pair;                       //the card which is paired to this card, i.e. having same color

  Card(int myWidth, int cardNumber) {                      //Constructor
    this.cardWidth=myWidth;
    this.cardHeight=myWidth;
    this.cardNumber=cardNumber;
    this.solved=false;                                     //all cards are unsolved at the beginning
    this.open=true;                                        //all cards are facing up initially to allow the player to memorize
  }

  void setColor(int[] colors) {                            //sets the color for each card
    for (int i=0; i<3; i++) {
      cardColor[i]=colors[i];
    }
  }

  void displayClosed(float topLeftX, float topLeftY) {    //makes the card face down and places it at the given position
    fill(0);
    rect(topLeftX, topLeftY, cardWidth, cardHeight);
  }

  void displayOpened(float topLeftX, float topLeftY) {    //makes the card face up and places it at the given position
    fill(cardColor[0], cardColor[1], cardColor[2]);
    rect(topLeftX, topLeftY, cardWidth, cardHeight);
  }
}


//Class for the game itself
class Game {
  Card[] myCards=new Card[20];                      //An array of 20 cards for the game
  int score;                                        //Keeps record of how many pairs have been matched by the player
  int time;                                         //Keeps record of time
  boolean started=false;                            //Checks if the game has been started or not
  int[] shuffledList=new int[20];                   //An array that stores the card numbers in shuffled order
  int[] openCards=new int[2];                       //Keeps record of the two cards that the player currently turned over
  int openCardsSize=0;                              //size of the above array to ensure only two cards can be turned over at a time

  Game() {                                                                  //Constructor
    time=0;                                                                 //time starts from 0
    score=0;                                                                //score is initially 0 as no matches are made
    for (int i=0; i<myCards.length; i++) {                                  //initializing all 20 cards
      myCards[i]=new Card(100, i+1);
    }
    int[][] colors={{255, 152, 161}, {237, 152, 255}, {86, 44, 160},        //distinguished colors for all 10 pairs of cards
      {157, 172, 255}, {157, 248, 255}, {157, 255, 187}, {76, 152, 26}, 
      {244, 247, 75}, {255, 176, 18}, {255, 0, 0}};
    int j=0;
    for (int i=0; i<myCards.length; i+=2) {                                 //assigning same color to two cards each and pairing them
      myCards[i].setColor(colors[j]);                                              //assigning color
      myCards[i+1].setColor(colors[j]);
      j++;
      myCards[i].pair=myCards[i+1];                                                //pairing
      myCards[i+1].pair=myCards[i];
    }
  }

  void shuffleCards() {                                                     //shuffles the card numbers and stores them in a different array
    IntList nums=new IntList();                                             //to ensure that all the pairs dont lie next to each other
    for (int i=1; i<21; i++) {
      nums.append(i);
    }
    nums.shuffle();
    shuffledList=nums.array();
  }

  void display() {                                                          //displays all the cards on the canvas
    int count=0;
    int h=0;
    int w=0;
    for (int i=0; i<myCards.length; i++) {
      if (myCards[shuffledList[i]-1].solved==false) {                       //if the card is already matched, no need to display it again
        if (myCards[shuffledList[i]-1].open) {
          myCards[shuffledList[i]-1].displayOpened(w*100+10*(w+1),          //displays the card face up using the method of Card class
            h*100+10*(h+1));
        } else {
          myCards[shuffledList[i]-1].displayClosed(w*100+10*(w+1),          //displays the card face down using the method of Card class
            h*100+10*(h+1));
        }
      }
      count++;
      w++;
      if (count==4) {                                                       //to display 4 cards in a row
        h++;
        w=0;
        count=0;
      }
    }
  }

  Card getCard(int row, int column) {                                       //returns the respective card according to the rown and column number
    int position= row*4+column;
    int myPos=shuffledList[position];                                       //using the shuffledList array because the cards are initially placed according to its order
                                                                            //this returns the card number placed in that position
    return myCards[myPos-1];                                                //card number is one more than its index in the mycards array 
                                                                            //(we used i+1 while initializing)                                                
  }

  void openCard(int row, int column) {                                      //To change the attribute 'open' to true for an individual card
                                                                            //based on row and column
    Card myCard=getCard(row, column);
    if (myCard.open==false && openCardsSize<2) {
      openCards[openCardsSize]=myCard.cardNumber;                           //adds card number to the array of open cards
      openCardsSize++;                                                      //increase size of open cards array
    }
    myCard.open=true;
  }

  void closeCard(int row, int column) {                                     //To change the attribute 'open' to false for an individual card
                                                                            //based on row and column
    Card myCard=getCard(row, column);
    myCard.open=false;
  }


  boolean compare() {                                                       //Checks if the two cards turned over are a match
    Card myCard1=myCards[openCards[0]-1];
    Card myCard2=myCards[openCards[1]-1];

    if (myCard1.pair==myCard2) {

      score++;
      myCard2.solved=true;
      myCard1.solved=true;
      openCardsSize=0;                                                      //eliminating solved cards
      return true;
    } else {
      myCard1.open=false;
      myCard2.open=false;
      openCardsSize=0;                                                      //closing cards that formed incorrect pair
      return false;
    }
  }


  boolean checkWin() {                                                      //checks if the player has completed the game
    if (score==10) {
      return true;
    } else {
      return false;
    }
  }
}

Game myGame=new Game();                                                     //creating instance of the game

void setup() {
  size(450, 560);
  frameRate(60);
  background(154, 224, 219);
  fill(185, 56, 132);
  textSize(12);                                                             //Starting with instructions page
  text("Welcome to THE MEMORY GAME.\n"+                                     //Instructions for the game
    "You will be shown 20 cards of different colors for 3 seconds.\n"+
    "The cards will then be turned downwards.\n"+
    "Each card has a pair, i.e. there are two same colored cards.\n"+
    "Your task is to match all the pairs as quickly as possible.\n"+
    "The time you took to solve this game will be shown as the end.\n\n"+
    "Enjoy playing :)", 50, 180);
  myGame.shuffleCards();
}

void draw() {
  if (myGame.started && !myGame.checkWin()) {                              //starting to count time after game has started and stopping after the game is finished
    myGame.time+=1;                                                        //adding one unit to the time, everytime the frame is redrawn
    if (myGame.time/60==3) {                                               //dividing time by 60 to get the time in seconds (the frameRate is 60)
                                                                           //displaying the cards for 3 seconds before facing all of them down
      for (int i=0; i<5; i++) {                                            //closing down the cards in all rows and columns
        for (int j=0; j<4; j++) {
          myGame.closeCard(i, j);
        }
      }
      myGame.display();
    }
  } else if (myGame.checkWin()) {                                          //after finishing the game, displaying the time the player took to finish
    background(154, 224, 219);
    fill(185, 56, 132);
    textSize(25);
    text("YOU HAVE COMPLETED THE GAME", 25, 200);
    fill(92, 185, 48);
    text("IN "+ myGame.time/60 + " SECONDS", 130, 300);
  }
}

void mousePressed() {                                                      //Determining what action to perform every time mouse is clicked
  if (myGame.checkWin()==false) {
    if (myGame.started==false) {                                           //If game has not started, display all cards faced up and start the game 
      background(154, 224, 219);
      myGame.display();
      myGame.started=true;
    }else{                                                                 //Allow player to open the card at the mouse position
      int column=(mouseX-(10*(mouseX/100+1)))/100;
      int row=(mouseY-(10*(mouseY/100+1)))/100;
      myGame.openCard(row, column);
      myGame.display();
      if(myGame.openCardsSize==2){                                         //If two cards have already been opened, check for match
        myGame.compare();
      }   
    }
  }
}
