/*
Submitted by: Yashaswi Malla (ym1929)
Submitted Date: 24 June, 2020

INFODIS 
  * stands for Information Dissemination
  * The concept is to create a system that can be used for the winner declaration in any two player of two team games 
  * For demo, I chose to perform the winner declaration of FIFA World Cup 2018
  * What happens is that the user is displayed a screen with 
    * a box for the winner position and 
    * two symbolics, one for each of the two players/ teams of the game
  * The user has to drag the symbol for the winning player/team into the box 
  * and press the switch on the breadboard 
  * the program will do the following things:
    * Raise the respective flag or symbol of the winner (using servo motor)
    * Light up the LED below the name board of the winner
    * Display the winner name below the "Congratulations!" message on the LCD
    * Also, play the theme tune of the game when the winner is announced

  * Since I chose to do the FIFA World Cup, 
  * The two teams are the finalist countries: France and Croatia
  * Their flags are their symbols on the servo motor 
  * Their jerseys are their symbols on the screen
  * Whenever one of the two symbols is dragged to the winner box, 
    * its flag is raised, 
    * the LED below its name is lit up 
    * the LCD displays "Congratulations! <country name>" 
    * while playing the official theme tune of FIFA World Cup 2018. 
  *All of these happen for 12 seconds and then go back to normal.
*/
//=================//=================//=================//=================//=================
#include <LiquidCrystal.h>          //the liquid crystal library contains commands for printing to the display
#include <Servo.h>                  //library to use the servo motor

class MyServo
{
    Servo servo;                    // the servo
    int pos;                        // current servo position
    int increment;                  // increment to move for each interval
    int  updateInterval;            // interval between updates
    unsigned long lastUpdate;       // last time position was updated

  public:
    MyServo(int interval)
    {
      updateInterval = interval;
      increment = 1;
    }

    void Attach(int pin)
    {
      servo.attach(pin);
    }
    
    void Set() {
      pos = 90;                     //initial position at 90 degrees
      servo.write(pos);
    }

    void UpdateLeft()               //rotate to the right and bring left flag up
    {
      while (pos <= 180) {
        if ((millis() - lastUpdate) > updateInterval) // time to update
        {
          lastUpdate = millis();
          pos += increment;
          servo.write(pos);
        }
      }
    }
    void UpdateRight()              //rotate to the left and bring right flag up
    {
      while (pos >= 0) {
        if ((millis() - lastUpdate) > updateInterval) // time to update
        {
          lastUpdate = millis();
          pos -= increment;
          servo.write(pos);
        }
      }
    }
};


LiquidCrystal lcd(13, 12, 11, 10, 9, 8);             // tell the RedBoard what pins are connected to the display
MyServo myservo(15);
const int yellowPin = 3;                             //connects to the yellow LED
const int greenPin = 4;                              //connects to the green LED
const int switchPin = A1;                            //connects to the switch
const int servoPin = 5;                              //connects to the servo motor


int switchValue;                                     //stores the digital input from the switch
int incomingByte;                                    // a variable to read incoming serial data into
long currentTime = 0;                                //variable to keep track of time
String names[] = {"France", "Croatia"};              //country names

void setup()
{
  Serial.begin (9600);                               //set up a serial connection with the computer

  myservo.Attach(servoPin);                          // attaches the servo on the servoPin to the servo object
  myservo.Set();

  lcd.begin(16, 2);                                  //tell the lcd library that we are using a display that is 16 characters wide and 2 characters high
  lcd.clear();

  //output pins
  pinMode(yellowPin, OUTPUT);                        //the pin will output voltage to the yellow LED
  pinMode(greenPin, OUTPUT);                         //the pin will output voltage to the green LED

  //input pins
  pinMode(switchPin, INPUT);                         //the pin will take input voltage from the switch

}

void loop() {

  switchValue = digitalRead(A1);
  Serial.println(switchValue);                       //print the switch value that was measured on serial monitor
  lcd.setCursor(0, 0);                               //set the cursor to the 0,0 position (top left corner)
  lcd.print("Congratulations!");

  if (Serial.available() > 0) {
    incomingByte = Serial.read();                    // read the oldest byte in the serial buffer:
    if (incomingByte == 'L') {                       // if it's a capital L (ASCII 76), turn on the green LED:
      digitalWrite(greenPin, HIGH);
      currentTime = millis();
      lcd.setCursor(0, 1);                           //set the cursor to the 0,1 position (second line left corner)
      lcd.print(names[0]);
      myservo.UpdateLeft();

    }
    else if (incomingByte == 'R') {                  // if it's a capital R (ASCII 82), turn on the yellow LED:
      digitalWrite(yellowPin, HIGH);
      currentTime = millis();
      lcd.setCursor(0, 1);                           //set the cursor to the 0,1 position (second line left corner)
      lcd.print(names[1]);
      myservo.UpdateRight();
    }
    else if (incomingByte == 'N' &&                  // if it's a capital N (ASCII 78), turn off the LED:
             millis() - currentTime >= 12000) {      // keep the LEDs on for 12 seconds then turn them off

      digitalWrite(greenPin, LOW);
      digitalWrite(yellowPin, LOW);
      lcd.setCursor(0, 1);                           //set the cursor to the 0,1 position (second line left corner)
      lcd.print("                ");                 //print nothing on the second line
      myservo.Set();                                 //bring servo back to 90 degrees after 12 seconds
    }
  }
}
