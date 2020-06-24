//Class for the players
class Person {
  String country;                                                            //country of the player
  int xPosition, yPosition;

  Person(String country_, int x) {
    country=country_;
    xPosition=(x+2)*PERSONWIDTH+50*(x+3);
    yPosition=320;
  }

  void display() {
    PImage myImg=loadImage("human.png");                                     //for the symbol of the player
    image(myImg, xPosition, yPosition, PERSONWIDTH, PERSONHEIGHT);
    PImage jersey;                                                           //for the jersey
    if (country=="France") {
      jersey=loadImage("france.png");
    } else {
      jersey=loadImage("croatia.png");
    }
    image(jersey, xPosition, yPosition-10, 70, 60);
  }
  boolean checkGreenBox() {                                                  //check if the player is in the position/winner box
    if (xPosition-PERSONWIDTH/2>winner.xPosition-POSITIONBOXWIDTH/2 && 
      xPosition+PERSONWIDTH/2<xPosition+POSITIONBOXWIDTH/2 && 
      yPosition-PERSONHEIGHT/2>(winner.yPosition-POSITIONBOXHEIGHT/2-240) && 
      yPosition+PERSONHEIGHT/2<winner.yPosition-POSITIONBOXHEIGHT/2) {
      return true;
    } else {
      return false;
    }
  }
}
