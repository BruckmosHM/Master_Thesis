#include <Wire.h>
#include <AccelStepper.h>
#include <Adafruit_MotorShield.h>

float newSpeed = 150.0;
float newAccel = 60.0;
int steptype = DOUBLE;
String serialData;
int cmdInt;
boolean stateChanged = true;
double slwFkt = 0.77;

// Create the motor shield object
// Adafruit_MotorShield AFMS = Adafruit_MotorShield();
Adafruit_MotorShield bottomShield(0x61);


// Connect a stepper motors
Adafruit_StepperMotor *joint2 = bottomShield.getStepper(200, 1);
Adafruit_StepperMotor *joint3 = bottomShield.getStepper(200, 2);

// ---------------- //
// Stepperfunctions //
// ---------------- //
void clockwiseJoint2() {
  joint2->onestep(FORWARD, steptype);
}
void anticlockwiseJoint2() {
  joint2->onestep(BACKWARD, steptype);
}
void clockwiseJoint3() {
  joint3->onestep(FORWARD, steptype);
}
void anticlockwiseJoint3() {
  joint3->onestep(BACKWARD, steptype);
}

// ------------------------------------------ //
// wrap the stepper in an AccelStepper object //
// ------------------------------------------ //
AccelStepper stepperJoint2(clockwiseJoint2, anticlockwiseJoint2);
AccelStepper stepperJoint3(clockwiseJoint3, anticlockwiseJoint3);


// ----- //
// Setup //
// ----- //
void setup() {
  Serial.begin(9600);   //set up Serial library at 9600 bps
  bottomShield.begin(); //create with the default frequency 1.6KHz

  stepperJoint2.setMaxSpeed(newSpeed * 43 / 30);
  stepperJoint2.setAcceleration(newAccel * 43 / 30);
  stepperJoint3.setMaxSpeed(newSpeed * slwFkt);
  stepperJoint3.setAcceleration(newAccel * slwFkt);
}

// ---- //
// Loop //
// ---- //
void loop() {
  // run the steppers until target reached, then check and wait for new commands
  if ((stepperJoint2.distanceToGo() == 0) && (stepperJoint3.distanceToGo() == 0))
  {
    // send the current postion to the GUI once when target reached
    if (stateChanged) {      
      Serial.print("Echo: Positions 0 ");
      Serial.print(stepperJoint2.currentPosition());
      Serial.print(" ");
      Serial.print(stepperJoint3.currentPosition());
      Serial.println(" 0 0");
      stateChanged = false;
    }

    // Check and wait for new commands
    readSerial();    
  } else {
    stepperJoint2.run();
    stepperJoint3.run();
  }
}

// -------------------- //
// Handle Serial Inputs //
// -------------------- //
void readSerial() {
  String rxString = ""; 
  
  if (Serial.available()) {
    // Bytes are available in the Serial
        
    while (Serial.available()) {
      // Fill the buffer until all bytes are received and Serial is empty
      
      //Delay to allow byte to arrive in input buffer
      delay(2);
      
      //Read a single character from the buffer
      char ch = Serial.read();
      
      //Append that single character to a string
      rxString += ch;
    }

    // Process received data
    onDataRead(rxString);    
  }
}

void onDataRead(String rxString){  
  // process the read data and save all parameters inside cmd Array
  String cmdArray[10] = {""};
  int stringStart = 0;
  int arrayIndex = 0;

  // Loop through the entire read data
  for (int i = 0; i < rxString.length(); i++) {
    // check current character if it's the split character
    if (rxString.charAt(i) == ' ') {
      // clear previous values from array
      cmdArray[arrayIndex] = "";

      // save substring into array
      cmdArray[arrayIndex] = rxString.substring(stringStart, i);

      // set new string starting point
      stringStart = (i + 1);
      arrayIndex++;
    }
  }
  cmdArray[arrayIndex] = rxString.substring(stringStart,rxString.length());
  
  // parse to corresponding function
  if (cmdArray[0] == "S"){
    // change settings    
    changeSettings(cmdArray);
    
  } else if (cmdArray[0] == "M"){
    // move the arm    
    moveArm(cmdArray);    
    
  } else {
    // unknown command
    Serial.println("Echo: Unknown Command");
  }
}


// --------------- //
// Change Settings //
// --------------- //
void changeSettings(String parameter[]) {
  char p1 = parameter[1].charAt(0);
  int p2 = parameter[2].toInt();
  Serial.println("Echo: " + parameter[1] + "-" + p2);
  
  //Commmands to change settings
  switch (p1) {
    case 'S':
      // Change the max speed of the motors
      newSpeed = p2;
      stepperJoint2.setMaxSpeed(newSpeed * 43 / 30);
      stepperJoint3.setMaxSpeed(newSpeed * slwFkt);
      break;

    case 'A':
      // Change the max acceleration of the motor
      newAccel = p2;
      stepperJoint2.setAcceleration(newAccel * 43 / 30);
      stepperJoint3.setAcceleration(newAccel * slwFkt);
      break;

    case 'T':
      // change the steptype of the motors
      steptype = p2;
      break;

    case 'R':
      // release all motors
      joint2->release();
      joint3->release();

    case 'E':
      // reset all motor positions
      stepperJoint2.setCurrentPosition(0);
      stepperJoint3.setCurrentPosition(0);
      Serial.print("Echo: Positions 0 ");
      Serial.print(stepperJoint2.currentPosition());
      Serial.print(" ");
      Serial.print(stepperJoint3.currentPosition());
      Serial.println(" 0 0");
      break;

    default:
      break;
  }
}

// ----------- //
// move Motors //
// ----------- //
void moveArm(String parameter[]) {
  // check if all positions are valid
  boolean valid = true;
  
  for (int i=0;i<6;i++){
    if (parameter[i] == ""){
      valid = false;
    }
  }

  // all positions are valid
  if(valid){
    int p1 = parameter[1].toInt();
    int p2 = parameter[2].toInt();
    int p3 = parameter[3].toInt();
    int p4 = parameter[4].toInt();
    int p5 = parameter[5].toInt();
    Serial.println("Echo: Move to " + parameter[1] + " " + parameter[2] + " " + parameter[3] + " " + parameter[4] + " " + parameter[5]);
    
    //declare new final positions of the joints
    stepperJoint2.move(p2);
    stepperJoint3.move(p3);
    stateChanged = true;
  } else {
    Serial.println("Echo: wrong amount of input arguments or nonvalid inputs");
  }
}
