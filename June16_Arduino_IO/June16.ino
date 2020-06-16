//variables
const int greenLEDpin = 11;
const int blueLEDpin = 6;

const int potentiometerPin = A0;
const int switchPin = A2;
const int lightSensorPin = A4;

int potentiometerValue;
int switchValue;
int lightSensorValue;

void setup() {
  //input pins
  pinMode(potentiometerPin, INPUT);
  pinMode(switchPin, INPUT);
  pinMode(lightSensorPin, INPUT);

  //output pins
  pinMode(blueLEDpin, OUTPUT);
  pinMode(greenLEDpin, OUTPUT);
}

void loop() {
  potentiometerValue = analogRead(potentiometerPin);                          //Read analog input from the potentiometer
  switchValue = digitalRead(switchPin);                                       //Read the digital input from the switch
  lightSensorValue = analogRead(lightSensorPin);                              //Read the analog input from the light sensor

  if (switchValue == 1) {                                                     //if switch is pressed:
    lightSensorValue = map(lightSensorValue, 0, 1023, 5000, 100);               //maps the input from light sensor within the range of 5000 to 100
                                                                                //to vary the alternating speed between two LEDs 
                                                                                //from 5 seconds (when no light is sensed) to 0.1 seconds (when max light is sensed)
    digitalWrite(greenLEDpin, HIGH);
    digitalWrite(blueLEDpin, LOW);
    delay(lightSensorValue);

    digitalWrite(blueLEDpin, HIGH);
    digitalWrite(greenLEDpin, LOW);
    delay(lightSensorValue);
  }
  else {                                                                       //if switch is not pressed:
                                                                                  //as the knob of the potentiometer is turned, one LED has its brightness increasing and the other has it decreasing
                                                                                  
    potentiometerValue = map(potentiometerValue, 0, 1023, 0, 255);                //maps the input from the potentiometer within the analog output range
    analogWrite(greenLEDpin, potentiometerValue);                                 //sets the brightness of the green LED as the reading in potentiometer 
    analogWrite(blueLEDpin, 255-potentiometerValue);                              //set the brightness of the blue LED as max brightness minus the reading in potentiometer

}
