// Code inspired by and partly 
// adapted from "The Nature of Code"
// Daniel Shiffman
// http://natureofcode.com

LSystem lsys;
Turtle turtle;
Serial myPort;     // Create object from Serial class

import processing.serial.*;

final char HEADER = 'M';    // character to identify the start of a message
final short LF = 10;        // ASCII linefeed
final short portIndex = 0;  // select the com port, 0 is the first port

int counter = 0;
String[] gens; 
float[] angles;

int[] weight_vec = {1, 100, 0, 1, 10};
float orig_len = height/3;
Rule[] ruleset = new Rule[5];
int countLimit = 5;
boolean arduinoActive = true;
boolean weightedAngleActive = false;
boolean verbose = false;

void setup() {
  fullScreen();
  //size(800, 800);

  if (arduinoActive == true) {
    setupArduino();
  }

  int[][] ruleColors = {{31, 92, 84}, {97, 145, 102}, {48, 69, 71}, {197, 114, 0}, {74, 99, 94}};

  ruleset[0] = new Rule('F', "F[+F]+[+F-F-F]-F[-F][-F-F]", 35, ruleColors[0]);
  ruleset[1] = new Rule('F', "FF[+FF][-F+F][FFF]F", 22.5, ruleColors[1]);
  ruleset[2] = new Rule('F', "F[+FF][-FF]F[-F][+F]F", 120, ruleColors[2]);  
  ruleset[3] = new Rule('F', "F[+F]+[-F-F]-FF[-F-F][-F][F]", 90, ruleColors[3]);
  ruleset[4] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]", 25, ruleColors[4]);    

  setupLSystem(weight_vec);
}

void draw() {
  background(255, 239, 206);
  //background(255);  
  fill(0);
  translate(width/2, height);
  rotate(-PI/2);
  turtle.render();
  noLoop();
}

////// L-SYSTEM SETUP //////

void setupLSystem(int[] weight_vec_) {
  //Rule[] ruleset = new Rule[2];
  //ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]", 22.5);
  //ruleset[1] = new Rule('F', "F[+FF][-FF]F[-F][+F]F", 35);
  //ruleset[2] = new Rule('F', "-F++F-", 45);
  int[] weight_vector = weight_vec_;//, 10};
  lsys = new LSystem("F", ruleset, weight_vector);
  //float rand_ang = random(0.75, 1)*TWO_PI;
  float angle = radians(25);
  if (weightedAngleActive) {
    angle = lsys.getWeightedAngle();
  } 
  turtle = new Turtle(lsys.getSentence(), height/3, angle, lsys.getWeightedColor());
  gens = generate_sentences();
}

String[] generate_sentences() {
  String[] gens = new String[countLimit];

  for (int i = 0; i < countLimit; i++) {
    // bool input --> rulechange_withingen
    // if true, then intra-gen rule change occurs
    lsys.generate(true);
    gens[i] = lsys.getSentence();
    //print("this", gens[i]);
  }
  return gens;
}

///// EVENT LOGIC ///// 

void mouseClicked() {
  eventTrigger(weight_vec);
}


void eventTrigger(int[] weight_vector) {
  println("Triggered: ");
  printArray(weight_vector);
  println();
  setupLSystem(weight_vector);
  while (counter < countLimit) {
    pushMatrix();
    if (verbose) {
      println(gens[counter]);
      println();
    }
    turtle.setToDo(gens[counter]);
    //turtle.setAngle(angles[counter]);
    turtle.changeLen(0.5);
    popMatrix();
    redraw();
    counter++;
  }
  counter = 0;
  redraw();
}

///// ARDUINO SECTION /////

void setupArduino() {
  println(" Connecting to -> " + Serial.list()[portIndex]);
  myPort = new Serial(this, Serial.list()[portIndex], 9600);
}

void serialEvent(Serial p) {
  try {
    String message = myPort.readStringUntil(LF); // read serial data
    //print(message);
    if (message != null)
    {
      //print(message);
      String [] data  = trim(message.split(",")); // Split the comma-separated message
      //data[1] = data[1].substring(0, data[1].length()-1);
      //print(data[1]);
      //if (data[0].charAt(0) == HEADER) // check for header character in the first field
      //{
      if ( data.length > 1)
      {
        int a = Integer.parseInt(data[0]);
        int b = Integer.parseInt(data[1]);
        int c = Integer.parseInt(data[2]);
        int d = Integer.parseInt(data[3]);
        int e = Integer.parseInt(data[4]);
        //print("a= " + a);
        //println(", b= " + b);
        //println(", c= " + c);
        //println(", d= " + d);
        //println(", e= " + e);
        int[] vec = {a, b, c, d, e};
        eventTrigger(vec);
        //lsys.setWeightVector(vec);
      }
      //}
    }
  }  
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}