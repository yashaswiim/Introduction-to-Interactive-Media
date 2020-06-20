//Class Game

//constants
final int BASKETWIDTH=120;
final int BASKETHEIGHT=80;
final int OBJECTWIDTH=30;
final int OBJECTHEIGHT=30;

class Game {
  Basket myBasket;                              //basket to catch the objects
  Object[] myObjects= new Object[10];           //10 objects to fall from the top

  boolean finish;                               //variable to check end of game
  int score;                                    //score of the player
  boolean objectReachedBottom;                  //variable to check if the dropped object has reached the bottom
  float shiftBasket;                            //variable to constantly keep moving the basket
  int objectNumber;                             //keeps track of the items to drop from the top
  boolean drop;                                 //variable to check if it is time to drop an object

  Game() {
    myBasket=new Basket(width/2-BASKETWIDTH/2, height-BASKETHEIGHT+10);
    shiftBasket=3;
    for (int i=0; i<myObjects.length; i++) {
      myObjects[i]=new Object();
    }
    objectNumber=0;
    objectReachedBottom=false;
    drop=false;
    finish=false;
  }

  void display() {
    myBasket.display();
    font = createFont("Rockwell-Italic", 25);
    textFont(font);
    textSize(15);
    fill(0);
    text("Score: "+score, width-100, 20);
  }

  void startGame() {
    moveBasket();
    if (objectNumber==4) {                    //increasing the speed of basket movement as the game progresses
      increaseShift(4);
    }
    if (objectNumber==8) {                    //increasing the speed of basket movement as the game progresses
      increaseShift(5);
    }
    myObjects[objectNumber].display(objectNumber+1);
    if (objectNumber<9 && 
      objectReachedBottom) {                  //checks if the objectNumber is within array boundary and if the object has reached bottom
      objectNumber++;
      objectReachedBottom=false;
    }
    if (objectNumber==9 && 
      objectReachedBottom) {                  //if all objects are dropped, game has finished
      finish=true;
    }
  }

  void dropObject() {                         //drops the object
    myObjects[objectNumber].drop();
  }

  void moveBasket() {                        //moves the basket
    myBasket.xPosition+=shiftBasket;
    if (myBasket.xPosition+BASKETWIDTH>=width || 
      myBasket.xPosition<=0) {
      shiftBasket=-shiftBasket;              //to and fro movement
    }
  }
  void increaseShift(int inc) {              //change movement speed of the basket
    if (shiftBasket>0) {
      shiftBasket=inc;
    }
  }

  boolean checkBottom() {                    //check if the object reached bottom
    boolean btm=myObjects[objectNumber].checkBottom();
    return btm;
  }

  boolean checkBasket() {                    //check if the object dropped into the basket
    if (myObjects[objectNumber].xPosition > myBasket.xPosition &&
      myObjects[objectNumber].xPosition < myBasket.xPosition + myBasket.bWidth-myObjects[objectNumber].oWidth) {
      return true;
    } else {
      return false;
    }
  }
}
