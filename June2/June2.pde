//Variables
float xPosition;
float yPosition;
int randomPointForX;
int randomPointForY;

//Radii for the center circle and corner circles
int radius=50;
int radiusTopRightCorner=round(random(60));
int radiusTopLeftCorner=round(random(60));
int radiusBottomRightCorner=round(random(60));
int radiusBottomLefttCorner=round(random(60));

void setup(){
  size(500,500);
  background(200,0,0);
  frameRate(5);
}

void draw(){
  // choosing a random color for each layer
  fill(random(255),random(255),random(255)); // choosing a random color for each layer
  
  //random starting point for the lines
  randomPointForX=round(random(width));
  randomPointForY=round(random(height));
  
  //ensuring the design does not exceed the width of the canvas
  if(radius+20<width/2){
    for(int i=0;i<360;i+=20){
      xPosition=radius * cos(radians(i));
      yPosition=radius * sin(radians(i));
      ellipse(width/2+xPosition,height/2-yPosition,10,10);
      line(randomPointForX, randomPointForY, width/2+xPosition, height/2-yPosition);
    }
    radius+=20;
  }
  topLeftCorner();
  topRightCorner();
  bottomLeftCorner();
  bottomRightCorner();
}

void topLeftCorner(){ // for design on the top left corner of the canvas
  fill(255);
  
  //ensuring the design does not overlap with the center design
  if(radiusTopLeftCorner+20<width/4){
    for(int i=0;i<360;i+=15){
      xPosition=radiusTopLeftCorner * cos(radians(i));
      yPosition=radiusTopLeftCorner * sin(radians(i));
      ellipse(xPosition,yPosition,10,10);
    }
    radiusTopLeftCorner+=20;
  }
}

void topRightCorner(){ // for design on the top right corner of the canvas
  fill(255);
  
  //ensuring the design does not overlap with the center design
  if(radiusTopRightCorner+20<width/4){
    for(int i=0;i<360;i+=15){
      xPosition=radiusTopRightCorner * cos(radians(i));
      yPosition=radiusTopRightCorner * sin(radians(i));
      ellipse(width+xPosition,yPosition,10,10);
    }
    radiusTopRightCorner+=20;
  } 
}
 
 
void bottomLeftCorner(){ // for design on the bottom left corner of the canvas
  fill(255);
  
  //ensuring the design does not overlap with the center design
  if(radiusBottomLefttCorner+20<width/4){
    for(int i=0;i<360;i+=15){
      xPosition=radiusBottomLefttCorner * cos(radians(i));
      yPosition=radiusBottomLefttCorner * sin(radians(i));
      ellipse(xPosition,height+yPosition,10,10);
    }
    radiusBottomLefttCorner+=20;
   }
}
 

void bottomRightCorner(){ // for design on the bottom right corner of the canvas
  fill(255);
  
  //ensuring the design does not overlap with the center design
  if(radiusBottomRightCorner+20<width/4){
    for(int i=0;i<360;i+=15){
      xPosition=radiusBottomRightCorner * cos(radians(i));
      yPosition=radiusBottomRightCorner * sin(radians(i));
      ellipse(width+xPosition,height+yPosition,10,10);
    }
    radiusBottomRightCorner+=20;
  } 
}
 
    
  
