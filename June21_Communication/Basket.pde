// Class Basket
class Basket {
  float xPosition;                              //x position of basket
  float yPosition;                              //y position of basket
  int bWidth;                                   //width of basket
  int bHeight;                                  //height of basket
  PImage basketImage;                           //image of basket

  Basket(float xPosition_, float yPosition_) {
    xPosition=xPosition_;
    yPosition=yPosition_;
    bWidth=BASKETWIDTH;
    bHeight=BASKETHEIGHT;
    basketImage=loadImage("Images/basket.png");
  }

  void display() {
    image(basketImage, xPosition, yPosition, bWidth, bHeight);
  }
}
