
/*
Tangible Interactive Computing MP1
Brian Brubach 
 
This is a barebones drawing program to demonstrate the 8-directional 
tilt sensor I built for this project. Although it only uses the 
first four digital pins, it reads from all of the Arduino 
Leonardo's inputs. I find this easier than specializing for these 
types of projects.

Input from the Arduino is of the form:
analog0, analog1, ..., analog5; digital0, digital1, ..., digital13
with analog and digital separated by a semi-colon.

The code below borrows lots of sample code from:
http://arduino.cc/en/tutorial/graph
https://processing.org/examples/
 */
 
 import processing.serial.*;
 
 Serial myPort;        // The serial port
 int xPos = width/2;         // horizontal position of the graph
 int yPos = height/2;         // horizontal position of the graph
 
 
 void setup () {
 // set the window size:
 size(400, 300); 
 if (frame != null) {
    frame.setResizable(true);
 } 
 
 xPos = width/2;         // horizontal position of the graph
 yPos = height/2;         // horizontal position of the graph
  
 
 // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[5], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 // set inital background:
 background(0);
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   
   // parse input from the arduino
   String[] analogDigital = split(inString, ';');
   String[] aIn = split(analogDigital[0], ',');
   String[] digIn = split(analogDigital[1], ',');

   float[] inByte = new float[6];
   float[] sizedInByte = new float[6];
   int[] inDigit = new int[14];

   // convert analog input to floats mapped to screen height and
   // digital input to ints
   // this project only uses the first four digital pins
   for (int i = 0; i < 5; i++) {
     inByte[i] = float(aIn[i]);
     sizedInByte[i] = map(inByte[i], 0, 1023, height/6, height);
   }
   for (int i = 0; i < 14; i++) {
     inDigit[i] = int(digIn[i]);
   }
 
 

  // drawing with the pen
  // uncomment the following line to redraw background and make 
  // a moving dot
  // background(0);
  stroke(255,255,255);
  fill(255,255,255);
  rect(xPos, yPos/2, 10, 10);
  
  // move the pen based on digital input from the tilt sensor
  if (inDigit[0] > 0.8) {
    yPos -= 2;
  }
  
  if (inDigit[1] > 0.8) {
    xPos += 2;
  }
  
  if (inDigit[2] > 0.8) {
    yPos += 2;
  }
  
  if (inDigit[3] > 0.8) {
    xPos -= 2;
  }
  
  
 }
 }
 




