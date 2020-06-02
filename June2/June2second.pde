//Variables
//positions for the tiny circles in the outer layer
float xPosition;
float yPosition;

//positions for the lines in the inner layer
float xPosition1;
float yPosition1;
float xPosition2;
float yPosition2;

//for the rotating effect
int angleChange=0;

void setup(){
  size(500,500);
  frameRate(5);
}

void draw(){
  background(255,218,203);
  stroke(0);
  strokeWeight(2);
    
  fill(230,232,136);
  ellipse(width/2,height/2,400,400);
  fill(233,234,187);
  ellipse(width/2,height/2,350,350);
  
  fill(157,229,242);
  ellipse(width/2,height/2,150,150);
  fill(255,218,203);
  ellipse(width/2,height/2,100,100);
  
  //The star in the middle
  noStroke();
  fill(62,247,147);
  triangle(width/2+50*cos(radians(90)),height/2+-50*sin(radians(90)),width/2+50*cos(radians(210)),height/2-50*sin(radians(210)),width/2+50*cos(radians(330)),height/2-50*sin(radians(330)));
  triangle(width/2+50*cos(radians(30)),height/2-50*sin(radians(30)),width/2+50*cos(radians(150)),height/2-50*sin(radians(150)),width/2+50*cos(radians(270)),height/2-50*sin(radians(270)));
  stroke(0);
  strokeWeight(2);
  
  //circles in the outer layer
  for(int i=0;i<360;i+=20){
    xPosition = 375/2 * cos(radians(i+angleChange));
    yPosition = 375/2 * sin(radians(i+angleChange));
    fill(255,0,0);
    ellipse(width/2+xPosition,height/2-yPosition,15,15);
  }
  
  //lines in the inner layer
  for(int i=0;i<360;i+=20){
    xPosition1 = 150/2 * cos(radians(i-angleChange));
    yPosition1 = 150/2 * sin(radians(i-angleChange));
    xPosition2 = 100/2 * cos(radians(i-angleChange));
    yPosition2 = 100/2 * sin(radians(i-angleChange));
    stroke(255,0,0);
    line(width/2+xPosition1,height/2-yPosition1,width/2+xPosition2,height/2-yPosition2);
  }
  angleChange+=5;
  
  //big circles in the middle layer
  for(int i=0;i<360;i+=45){
    fill(255,219,129);
    stroke(70,106,32);
    strokeWeight(5);
    xPosition = 250/2 * cos(radians(i));
    yPosition = 250/2 * sin(radians(i));
    ellipse(width/2+xPosition,height/2-yPosition,100,100);
  }
}
