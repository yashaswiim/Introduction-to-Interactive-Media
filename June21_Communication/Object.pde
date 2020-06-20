// Class Object
class Object {
  int xPosition;                           //x position of object
  int yPosition;                           //y position of object
  int oWidth;                              //width of object
  int oHeight;                             //height of object

  Object() {
    xPosition=width/2-OBJECTWIDTH/2;      //always placed in the middle of screen
    yPosition=0;                          //always placed at the top
    oWidth=OBJECTWIDTH;
    oHeight=OBJECTHEIGHT;
  }

  void display(int index) {               //display the object
    PImage objImage=loadImage("Images/obj"+index+".png");
    image(objImage, xPosition, yPosition, oWidth, oHeight);
  }

  void drop() {                          //drop the object by changing its y position
    if (!checkBottom()) {
      yPosition+=6;
    }
  }

  boolean checkBottom() {                //check if it is at the bottom of the screen
    if (yPosition>height-BASKETHEIGHT/2) {
      return true;
    } else {
      return false;
    }
  }
}
