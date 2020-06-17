/*
  * Submitted by: Yashaswi Malla (ym1929)
  * Submitted Date: June 17, 2020

  * Plays the rhythm of 'Twinkle Twinkle Little Star' whenever the button is pressed.
  * Two buttons are used (green and yellow).
  * The yellow button plays the rhythm in a loop as long as the button is pressed.
  * The green button plays the notes of the rhythm in reverse order in a loop as long as the button is pressed.
  * The potentiometer is used as the analog sensor (input).
  * It is used to determine the tempo of the rhythm i.e. how fast the rhythm is played.
*/

// Variables
const int greenSwitchPin = A2;
const int yellowSwitchPin = A0;
const int potentiometerPin = A4;

const int loudspeakerPin = 9;

int potentiometerValue;
int greenSwitchValue;
int yellowSwitchValue;

void setup() {
  // Input pins
  pinMode(greenSwitchPin, INPUT);
  pinMode(yellowSwitchPin, INPUT);
  pinMode(potentiometerPin, INPUT);

  // Output pins
  pinMode(loudspeakerPin, OUTPUT);
}

unsigned long currentNoteStartingPoint = 0;
int millisToNextNote = 0;
int currentNote = 0;

void loop() {
  unsigned long currentMillis = millis();

  potentiometerValue = analogRead(potentiometerPin);                          //Read analog input from the potentiometer
  greenSwitchValue = digitalRead(greenSwitchPin);                             //Read the digital input from the green switch
  yellowSwitchValue = digitalRead(yellowSwitchPin);                           //Read the digital input from the yellow switch

  potentiometerValue = map(potentiometerValue, 0, 1023, 11, 30);              //Map analog input from the potentiometer into the range 11 to 30
  //this will later be divided by 10.0 to get values between 1.1 and 3.0

  int melody[] = {                                                            //The notes for the rhythm of Twinkle Twinkle Litte Star
    262, 262, 392, 392, 440, 440, 392, 349, 349, 330, 330, 294, 294, 262,
    392, 392, 349, 349, 330, 330, 294, 392, 392, 349, 349, 330, 330, 294
  };

  int noteDurations[] = {                                                     //Duration corresponding to each note in the melody[] array
    4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 2,
    4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 2
  };

  int totalNotes = sizeof(melody) / sizeof(melody[0]);                        //Total number of notes in the melody

  if (yellowSwitchValue == 1 || greenSwitchValue == 1) {                      //Checks if any of the two switches is pressed
    if (currentMillis - currentNoteStartingPoint >= millisToNextNote) {       //Checks if it is time to play the next note
      if (currentNote < totalNotes) {                                         //Checks if the currentNote is less than total number of notes
        int noteDuration;
        if (yellowSwitchValue == 1) {                                         //Checks if yellow switch is pressed
          noteDuration = 1000 / noteDurations[currentNote];                   //Plays the notes in right order
          tone(loudspeakerPin, melody[currentNote], noteDuration);
        }
        else if (greenSwitchValue == 1) {                                     //Checks if green switch is pressed
          noteDuration = 1000 / noteDurations[totalNotes - 1 - currentNote];  //Plays the notes in reverse order
          tone(loudspeakerPin, melody[totalNotes - 1 - currentNote], noteDuration);
        }

        millisToNextNote = noteDuration * (potentiometerValue / 10.0);         //Potentiometer determining the speed
        currentNoteStartingPoint = currentMillis;
        currentNote++;
      }
      else {
        noTone(loudspeakerPin);                                                //Stop after playing the rhythm once
      }
    }
  }
  else {                                                                       //If switch released, currentNote starts from beginning
    currentNote = 0;
  }
}
