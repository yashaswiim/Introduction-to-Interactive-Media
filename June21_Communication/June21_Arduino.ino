/*
  Submitted by: Yashaswi Malla (ym1929)
  Submitted Date: June 21, 2020

  Concept:
 * There is a basket moving to and fro from left to right.
 * There are 10 objects on the top of the screen that appear one by one
 * When the switch is pressed, the items are dropped
 * The goal is to drop the items such that they fall into the basket
 * The score is the number of items collected in the basket
 * The green LED is turned on when the item is successfully collected
 * The red LED is turned on when the item is missed

  Communication used:
 * Processing receives the signal from Arduino when the switch is pressed.
 * Processing sends signal to Arduino when it is time to:
   * turn on the green LED
   * turn on the red LED
   * turn off both LEDs

*/
//==================================//==================================//==================================

//variables
const int redPin = 6;                                 //connects to the red LED
const int greenPin = 11;                              //connects to the green LED
const int switchPin = A1;                             //connects to the switch

int switchValue;                                      //stores the digital input from the switch
int incomingByte;                                     // a variable to read incoming serial data into
long currentTime = 0;

void setup()
{
  Serial.begin (9600);                                //set up a serial connection with the computer

  //output pins
  pinMode(redPin, OUTPUT);                            //the pin will output voltage to the red LED
  pinMode(greenPin, OUTPUT);                          //the pin will output voltage to the red LED

  //input pins
  pinMode(switchPin, INPUT);                         //the pin will take input voltage from the switch

}

void loop() {

  switchValue = digitalRead(A1);
  //  digitalWrite(greenPin, HIGH);

  Serial.println(switchValue);                       //print the switch value that was measured on serial monitor
  if (Serial.available() > 0) {
    incomingByte = Serial.read();                    // read the oldest byte in the serial buffer:
    if (incomingByte == 'G') {                       // if it's a capital G (ASCII 71), turn on the green LED:
      digitalWrite(greenPin, HIGH);
      currentTime = millis();
    }
    else if (incomingByte == 'R') {                  // if it's a capital R (ASCII 82), turn on the red LED:
      digitalWrite(redPin, HIGH);
      currentTime = millis();
    }
    else if (incomingByte == 'L' &&                  // if it's a capital L (ASCII 76), turn off the LED:
             millis() - currentTime >= 1000) {       // keep the LEDs on for 1.5 seconds

      digitalWrite(greenPin, LOW);
      digitalWrite(redPin, LOW);
    }
  }
}
