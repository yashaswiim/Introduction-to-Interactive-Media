//window 
size(500,500);

int faceWidth=260;
int faceHeight=400;

//neck
fill(242,227,164);
beginShape();
curveVertex(width/2-60, height/2+faceHeight/2-40);
curveVertex(width/2-60, height/2+faceHeight/2-40);
curveVertex(width/2-60, height/2+faceHeight/2+30);
curveVertex(50, height/2+faceHeight/2+30);
curveVertex(50, height+50);

curveVertex(width-50, height+50);
curveVertex(width-50, height/2+faceHeight/2+30);
curveVertex(width/2+60, height/2+faceHeight/2+30);
curveVertex(width/2+60, height/2+faceHeight/2-40);
curveVertex(width/2+60, height/2+faceHeight/2-40);
endShape();

//hair
noStroke();
fill(33,30,14);
ellipse(width/2, height/2-faceHeight/3, faceWidth+2*40, 160);
rect(width/2-(faceWidth+2*40)/2, height/2-faceHeight/3, faceWidth+2*40, 160);

fill(90,81,37);
rect(width/2-(faceWidth+2*40)/2, height/2-faceHeight/3+160, faceWidth+2*40, 160);

fill(183,166,81);
rect(width/2-(faceWidth+2*40)/2, height/2-faceHeight/3+2*160, 130, 160);
rect(width/2+(faceWidth+2*40)/2-130, height/2-faceHeight/3+2*160, 130, 160);

//face
fill(242,227,164);
stroke(0);
arc(width/2, height/2, faceWidth, faceHeight, radians(320), radians(560), CHORD);

//eyes
int eyeWidth=65;
int eyeHeight=28;
int eyeballRadius=eyeHeight;
fill(255);
ellipse(width/2-faceWidth/4, height/2-faceHeight/20, eyeWidth, eyeHeight);
ellipse(width/2+faceWidth/4, height/2-faceHeight/20, eyeWidth, eyeHeight);
fill(0);
ellipse(width/2-faceWidth/4, height/2-faceHeight/20, eyeballRadius,eyeballRadius);
ellipse(width/2+faceWidth/4, height/2-faceHeight/20, eyeballRadius,eyeballRadius);

//eyebrows
arc(width/2-faceWidth/4, height/2-faceHeight/20, eyeWidth+2*40, eyeHeight+2*25, radians(240),radians(300),CHORD);
arc(width/2+faceWidth/4, height/2-faceHeight/20, eyeWidth+2*40, eyeHeight+2*25, radians(240),radians(300),CHORD);

//nose
int noseHeight=80;
int noseWidth=50;
noFill();
beginShape();
curveVertex(width/2,height/2);
curveVertex(width/2,height/2);
curveVertex(width/2-noseWidth/5, height/2+noseHeight/2);
curveVertex(width/2-noseWidth/2, height/2+noseHeight/2+noseHeight/3);
curveVertex(width/2, height/2+noseHeight);
curveVertex(width/2+noseWidth/2, height/2+noseHeight/2+noseHeight/3);
curveVertex(width/2+noseWidth/2, height/2+noseHeight/2+noseHeight/3);
endShape();

//lips
int lipsWidth=90;
int lipsHeight=30;
int lipPositionY=height/2+noseHeight+50;
fill(255,0,0,90);
//lowerlip
arc(width/2, lipPositionY,lipsWidth,lipsHeight,0,radians(180),CHORD);
//upperlip
beginShape();
curveVertex(width/2-lipsWidth/2, lipPositionY);
curveVertex(width/2-lipsWidth/2, lipPositionY);
curveVertex(width/2-lipsWidth*2/6, lipPositionY-10);
curveVertex(width/2-lipsWidth/6, lipPositionY-15);
curveVertex(width/2, lipPositionY-10);
curveVertex(width/2+lipsWidth/6, lipPositionY-15);
curveVertex(width/2+lipsWidth*2/6, lipPositionY-10);
curveVertex(width/2+lipsWidth/2, lipPositionY);
curveVertex(width/2+lipsWidth/2, lipPositionY);
endShape();
