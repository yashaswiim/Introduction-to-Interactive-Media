/*
Submitted by: Yashaswi Malla (ym1929)
 Submitted Date: June 7, 2020
 
 Concept:
 Using transformation to create simple art work
 Transformations used: translate(), rotate()
 
 Output: Three flowers are drawn with triangle petals. 
 One petal is drawn at a time.
 Drawing stops once 360 degrees rotation is completed.
 Stems are drawn at the end.
 
 Reference: https://processing.org/tutorials/transform2d/
 */
//========================================================================

//Variables
int flower1xPosition=200;
int flower1yPosition=300;
int flower2xPosition=450;
int flower2yPosition=200;
int flower3xPosition=700;
int flower3yPosition=100;


void setup() {
  size(800, 600);
  background(255, 180, 230);
}

void draw() {
  drawEllipse();                                             //centre circles for the flowers
  stem();                                                    //stem of the flower
  strokeWeight(3);
  stroke(200, 0, 0);
  if (frameCount*2<=360) {                                   //stops the drawing of petals one 360 degrees rotation is completed
    if (frameCount % 15 == 0) {                              //draws a petal on every 15th frame, 4 times a second
      flower(flower1xPosition, flower1yPosition);                        //first flower
      flower(flower2xPosition, flower2yPosition);                        //second flower
      flower(flower3xPosition, flower3yPosition);                        //third flower
    }
  }
}

void stem() {
  if (frameCount*2>=360) {                                   //draws the stem only when one rotation is completed and all the petals have been drawn
    noFill();
    stroke(0, 125, 0);
    strokeWeight(10);
    bezier(flower1xPosition, flower1yPosition, flower1xPosition+100, flower1yPosition+100, 
      flower1xPosition-100, flower1yPosition+200, 400, 600);
    bezier(flower2xPosition, flower2yPosition, flower2xPosition-100, flower2yPosition+150, 
      flower2xPosition+100, flower2yPosition+300, 400, 600);
    bezier(flower3xPosition, flower3yPosition, flower3xPosition-50, flower3yPosition+150, 
      flower3xPosition+50, flower3yPosition+300, 400, 600);
  }
}

void drawEllipse() {                                         //draws the centre circles for all three flowers
  stroke(200, 0, 0);
  strokeWeight(5);
  fill(255);
  ellipse(flower1xPosition, flower1yPosition, 20, 20);
  ellipse(flower2xPosition, flower2yPosition, 20, 20);
  ellipse(flower3xPosition, flower3yPosition, 20, 20);
}

void flower(int xPosition, int yPosition) {                  //takes the x and y positions for the flowers                       
  fill(random(255), random(255), random(255));               //choosing random color for the petals
  pushMatrix();
  translate(xPosition, yPosition);
  rotate(radians(frameCount * 2  % 360));                    //changes angle of rotation by multiples of 30, as petals are drawn in every 15th frame
  triangle(0, 0, -50, -100, 50, -100);
  popMatrix();
}
