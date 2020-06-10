//class button for creating the buttons

class Button{
  String title;
  float xPosition;
  float yPosition;
  int radius;
  
  Button(int x, int y, int r,String title_){
    title=title_;
    xPosition=x;
    yPosition=y;
    radius=r;    
  }
  
  void display(){
    fill(255);
    ellipse(xPosition, yPosition, radius*2, radius*2);
    textSize(15);
    fill(0);
    text(title,xPosition-40, yPosition);
  }
}
