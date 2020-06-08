/*
Submitted by: Yashaswi Malla(ym1929)
Submitted Date: June 8,2020
Topic: Image Manipulation

Concept: 
I have chosen two images: one for my background and one for the manipulation. 
I loaded the image of sun into the background of sky. 
I created an animation where it appears as if the sun is divided into small grids and each grid of the sun is changing its color or disappearing. 
When the code is run, it asks the user to click to start. 
When the mouse is clicked, the small grids change their colors for two rounds.
On the third round, the grids start to disappear.
Ultimately the sky and a shrinked sun remain in the background. 
*/
//=============================================================================


//Variables for the main image, the background image
//main image grids and background image grids
PImage myImage, myBackground, myImagePiece, myBackgroundPiece;   
int tileWidth, tileHeight;                                                  //size of the grids
final int numTilesInRow=10;                                                 //number of grids in one row

int columnNumber=0;                                                         //to keep tranck of which column it is in
int rowNumber=0;                                                            //to keep track of which row it is in
int countRounds=0;                                                          //to assign different effects to different rounds
boolean started=false;                                                      //to check if the user has clicked the mouse to start

void setup() {
  size(600, 600);

  myBackground=loadImage("bg.png");                                         //loading background image                                  
  myBackground.resize(width, height);                                       //resizing the image to fit the canvas exactly                          
  image(myBackground, 0, 0);

  myImage=loadImage("sun.png");                                             //loading main image
  myImage.resize(width, height);                                            //resizing the image to fit the canvas exactly
  image(myImage, 0, 0);
  
  textSize(15);                                                             //Beginning text
  text("Click to Start", 260, 290);
  
  tileWidth=myImage.width/numTilesInRow;
  tileHeight=myImage.height/numTilesInRow;
}

void draw() {
  if (started) {
    if (frameCount%(60/numTilesInRow) == 0 &&                               //to complete the effect for one row in one second
      columnNumber < numTilesInRow && rowNumber < numTilesInRow) {
      int xPosition = columnNumber * tileWidth;
      int yPosition = rowNumber * tileHeight;

      myImagePiece = myImage.get(xPosition, yPosition,                      //getting the image piece
        tileWidth, tileHeight);
      myBackgroundPiece = myBackground.get(xPosition, yPosition,            //getting the background image piece
        tileWidth, tileHeight);

      if (countRounds == 2) {                                               //disappearing effect for the third round
        noTint();
        image(myBackgroundPiece, xPosition, yPosition);
      } else {                                                              //color changing effect for the first two rounds
        tint(random(255), random(255), random(255));
        image(myImagePiece, xPosition, yPosition);
      }

      columnNumber++;

      if (columnNumber == numTilesInRow) {
        columnNumber = 0;
        rowNumber++;
      }

      if (rowNumber == numTilesInRow) {
        rowNumber = 0;
        if (countRounds == 2) {
          countRounds = 0;
          started=false;                                                    //stopping after the third round
        } else {
          countRounds++;
        }
      }
    }

    if (columnNumber == (numTilesInRow/2)+1 &&                              //displaying the shrinked sun at the third round when the grids disappear
      rowNumber == numTilesInRow/2 && countRounds==2) {
      push();
      translate(width/2, height/2);
      scale(0.2);
      noTint();
      image(myImage, 0-myImage.width/2, 0-myImage.height/2);
      pop();
    }
  } else {                                                                  //display of the main image before animation starts
    noTint();
    image(myImage, 0, 0);
    columnNumber = 0;
    rowNumber = 0;
    textSize(15);
    text("Click to Start", 260, 290);
  }
}

void mouseClicked() {                                                       //to start the animation after checking if the mouse is clicked
  if (!started) {
    noTint();
    image(myImage, 0, 0);
    started=true;
  }
}
