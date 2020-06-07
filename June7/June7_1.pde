/*
Submitted by: Yashaswi Malla (ym1929)
Submission Date: June 7, 2020

Concept:
Horizontal axis =  dates 
Vertical axis =  temperatures in degree celsius. 
Circles width are scaled according to the respective temperatures. 
Circles are drawn for the temperatures ranging from the minimum to the maximum for each of the 10 dates.  
Also, transparency of the circles are scaled according to the temperatures. 

Data Source: https://weather.com/weather/tenday/l/0755f9b1a0f85388ca0d9510010eed3e6274c95ec9ecc1a8353af4782d304238
*/
//========================================================================================================================

int[][] data;                                                                    //2D array to store the data, making it global to access in both setup() and draw()

void setup() {
  size(1250, 650);

  String TemperatureData[]=loadStrings("data.csv");                              //loading my csv file, .csv file saved in same folder as .pde file
  data=new int[TemperatureData.length-1][];                                      //initializing the 2D array to be of the length of the file

  for (int i=1; i<TemperatureData.length; i++) {
    data[i-1]=int(split(TemperatureData[i], ','));                               //storing int arrays containing the date, min and max temperatures into the 2D array
  }
}

void draw() {
  background(182, 234, 156);
  fill(0);
  stroke(0);
  strokeWeight(2);
  line(50, 0, 50, height);                                                       //vertical axis
  line(0, height-50, width, height-50);                                          //horizontal axis
  
  textSize(20);                                                                  //title of the visualization
  text("ABU DHABI TEMPERATURE FORECAST FOR JUNE 8-17 (min to max)", 300, 25);
  
  textSize(15);                                                                  //axis titles
  text("45", 25, 15);
  text("26", 25, height-55);
  text("7", 55, height-35);
  text("18", width-20, height-35);
  text("Date", width/2, height-25);
  
  pushMatrix();                                                                  //rotating the vertical axis title   
  translate(30, height/2+50);
  rotate(radians(270));
  text("Temperature (degree Celsius)", 0, 0);
  popMatrix();
  
  for (int i=0; i<data.length; i++) {
    float xPosition=map(data[i][0], 7, 18, 50, width);                          //mapping the dates into the horizontal axis (from 7 to 18)
    float alpha=1;
    for (int j=data[i][1]; j<data[i][2]; j++) {
      float yPosition = map(j, 26, 45, height-50, 0);                           //mapping the temperatures into vertical axis (from 26 to 45)
      noStroke();
      fill(200, 0, 0, j*alpha);                                                 //scaling transparency according to temperature
      ellipse(xPosition, yPosition, j*4, j*4);                                  //scaling width of circle according to temperature
      alpha+=0.5;                  
    }
  }
}
