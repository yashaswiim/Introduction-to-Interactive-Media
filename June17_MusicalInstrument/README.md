## JUNE 17 ASSIGNMENT

MUSICAL INSTRUMENT

### CONCEPT

The task in this assignment was to make a musical instrument using at least one digital sensor (switch) and at least one analog sensor (photoresistor, potentiometer, or distance measuring sensor). The project that I created is an instrument that plays the rhythm of 'Twinkle Twinkle Little Star' whenever the button is pressed. I have used two buttons (green and yellow). The yellow button plays the rhythm in a loop as long as the button is pressed. The green button plays the notes of the rhythm in reverse in a loop as long as the button is pressed. I have used the potentiometer as the analog sensor (input). The potentiometer here is used to determine the tempo of the rhythm i.e. how fast the rhythm is played.

### IMAGES

#### PHOTO OF PROJECT

![](June17_img.png)

#### PICTURE OF SCHEMATIC 

![](June17_Schematic.jpg)

[Video](https://github.com/ym1929/Introduction-to-Interactive-Media/blob/master/June17_MusicalInstrument/June17Video.mp4)

### CHALLENGES

The main challenge for me was to create the circuit with the digital sensor, analog sensor as well as the speaker. It took me a while to figure out proper connections for all the components I was using. Moreover, the bigger challenge was the code where I tried to avoid using the delay() function and tried to use different variables and conditionals (like we learnt in class) to produce sound at appropriate times. However, after I changed the code, it started playing the notes in a way that was different than expected. It happened because I placed certain parts of the code in wrong the place. It took me a lot of trial and error to make it finally work as I wanted. Also, I tried to avoid looping while playing the rhythm; I wanted the rhythm to play only once when the button is pressed and then stop playing when the full rhythm is played. However, for some reason, when I did that, it would not play any sound even when the button is released and pressed again. I tried hard to figure out what was happening, and finally I figured it out. The conditionals that I had used were not in correct order which caused the value of currentNote to never change back to 0 if the button was pressed for a longer time after completing the rhythm. So, I changed the order of the conditionals and it worked. Another problem I had was trying to map the input value from the potentiometer between 1.1 to 3 to vary the speed/tempo. The problem was that I read the analog input into an int variable 'potentiometerValue' and tried to use the same variable to store the mapped value, but since it was int, it could only store 1, 2 or 3 which was not what I wanted. So, what I did was mapped the value between 11 and 30 and later divided it by 10.0 when using with millisToNext. And this solved my problem but I later realized that I could have simply used another float variable to store the mapped value.

### REFLECTION

It was a good practice playing with the speaker and switches and the potentiometer together. I wanted use the servo motor as well in some way but I did not have enough time to come up with any idea for that as it took me a long time to complete what I have right now. The loosening of wires and creating interruptions was very annoying. Nonetheless, I am glad that I could complete the project in time. 
