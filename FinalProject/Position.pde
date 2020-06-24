//Class for the position box
class Position {
  String title;                                                        //title of the box i.e. winner
  Person player;                                                       //player that holds this position/ is in the box 
  int xPosition, yPosition;                

  Position(String title_, int x) {
    title=title_;
    xPosition=x;
    yPosition=height-100-(POSITIONBOXHEIGHT/2);
  }

  void display() {
    rectMode(CENTER);
    fill(0);
    stroke(255, 0, 0);
    rect(xPosition, yPosition, POSITIONBOXWIDTH, POSITIONBOXHEIGHT);
    textSize(35);
    fill(255);
    text(title, xPosition-65, yPosition);
  }
}
