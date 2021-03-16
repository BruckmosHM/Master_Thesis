#include <Wire.h>
#include <Adafruit_MotorShield.h>

String command = "";
String strArr[3];
String param1 = "";
int param2 = 0;

int tr = 43; //transmission ratio

int currentPos = 0;
int pos = 0;

int newSpeed = 20;
int steptype = MICROSTEP;


// Create the motor shield object with the default I2C address
Adafruit_MotorShield AFMS = Adafruit_MotorShield();  

// Connect a stepper motor with 200 steps per revolution (1.8 degree) to motor port #1 (M3 and M4)
Adafruit_StepperMotor *myMotor = AFMS.getStepper(200, 1);


void setup() {
  Serial.begin(9600);   //set up Serial library at 9600 bps
  help();
  currentSettings();
  
  AFMS.begin();         //create with the default frequency 1.6KHz
  
  myMotor->setSpeed(newSpeed);  //rpm   
}

void loop() {
  //handleSerial();
  serialInput();
}


void serialInput(){
  String rxString = "";

  if (Serial.available()) {
      //Keep looping until there is something in the buffer.   
      while (Serial.available()) {
          //Delay to allow byte to arrive in input buffer.
          delay(2);
          //Read a single character from the buffer.
          char ch = Serial.read();
          //Append that single character to a string.
          rxString += ch;
      }

      int stringStart = 0;
      int arrayIndex = 0;
      for (int i = 0; i<rxString.length(); i++) {
          //Get character and check if it's the "special" character.
          if (rxString.charAt(i) == ' ') {          
              //Clear previous values from array.
              strArr[arrayIndex] = "";
              //Save substring into array.
              strArr[arrayIndex] = rxString.substring(stringStart, i);
              //Set new string starting point.
              stringStart = (i + 1);
              arrayIndex++;
          }
      }
      strArr[arrayIndex] = rxString.substring(stringStart,rxString.length());      
      //Put values from the array into the variables.
      if (rxString.length() == 1){
        //empty command
        Serial.println("Empty Command. Repeating last command");
      }else {
        command = strArr[0];
        param1 = strArr[1];
        param2 = strArr[2].toInt();
      }      

      if (command == "m" || command == "M"){
        //change settings
        settings(param1,param2);
        
      }else if (command == "g" || command == "G"){
        //move command
        movement(param1,param2);
        curPosition();
        
      }else if (command == "t" || command == "T"){
        //move steps with transmission
        transmissionMovement(param1,param2);
        curPosition();   

      }else if (command == "c" || command == "C"){
        //move steps with transmission
        cycloidalMovement(param1,param2);
        curPosition(); 
        
      }else {
        //unknown command
        Serial.println("Unknown command");
      }     
  }  
}

void cycloidalMovement(String p1, int p2){
  //Commands to move the motor with a cycloidal transmission
  p2 = p2*tr;
  switch(p1.charAt(0)){
    case 'f':
      Serial.print(p2/tr);
      Serial.println(" steps forward movement. Cycloidal");
      myMotor->step(p2, FORWARD, steptype); 
      currentPos-=p2;
      myMotor->release();
      break;

    case 'b':
      Serial.print(p2/tr);
      Serial.println(" steps backward movement. Cycloidal");
      myMotor->step(p2, BACKWARD, steptype); 
      currentPos+=p2;
      myMotor->release();
      break;

    case 'm':
      pos = p2;
      int diff = pos-currentPos;
      if (diff>0){
        myMotor->step(diff,BACKWARD,steptype);
      }else if (diff<0){
        myMotor->step(-diff,FORWARD,steptype);
      }
      currentPos = pos;
      myMotor->release();
      break;

    default:
      break;          
  }  
  //myMotor->setSpeed(newSpeed);
  Serial.print("Cycloidal Transmission Position: ");
  Serial.print(currentPos/tr);
  Serial.print(" steps, ");
  Serial.print(currentPos/tr*1.8);
  Serial.println("°");
}

void transmissionMovement(String p1, int p2){
  //Commands to move the motor with a transmission
  //myMotor->setSpeed(50);
  //delay(10);
  p2 = p2*tr;
  switch(p1.charAt(0)){
    case 'f':
      Serial.print(p2);
      Serial.println(" steps forward movement");
      myMotor->step(p2, FORWARD, steptype); 
      myMotor->release();
      currentPos-=p2;
      break;

    case 'b':
      Serial.print(p2);
      Serial.println(" steps backward movement");
      myMotor->step(p2, BACKWARD, steptype); 
      myMotor->release();
      currentPos+=p2;
      break;

    case 'm':
      pos = p2;
      int diff = pos-currentPos;
      if (diff>0){
        myMotor->step(diff,BACKWARD,steptype);
      }else if (diff<0){
        myMotor->step(-diff,FORWARD,steptype);
      }
      currentPos = pos;
      myMotor->release();
      break;

    default:
      break;          
  }  
  //myMotor->setSpeed(newSpeed);
  Serial.print("Transmission Position: ");
  Serial.print(currentPos/tr);
  Serial.print("steps, ");
  Serial.print(currentPos/tr*1.8);
  Serial.println("°");
}

void movement(String p1,int p2){
  //Commands to move the motor
  switch(p1.charAt(0)){
    case 'f':
      Serial.print(p2);
      Serial.println(" steps forward movement");
      myMotor->step(p2, FORWARD, steptype); 
      //myMotor->release();
      currentPos-=p2;
      break;
  
    case 'b':
      Serial.print(p2);
      Serial.println(" steps backward movement");
      myMotor->step(p2, BACKWARD, steptype); 
      //myMotor->release();
      currentPos+=p2;
      break;
  
    case 'm':
      pos = p2;
      int diff = pos-currentPos;
      if (diff>0){
        myMotor->step(diff,BACKWARD,steptype);
      }else if (diff<0){
        myMotor->step(-diff,FORWARD,steptype);
      }
      currentPos = pos;
      //myMotor->release();
      break;
  
    default:
      break;          
  }  
}


void settings(String p1,int p2){
  //Commmands to change settings
  switch (p1.charAt(0)){
    case 's':
      //Change the speed of the motor
      Serial.print("Set speed to ");
      Serial.print(p2);
      Serial.println(" rpm");
      newSpeed = p2;
      myMotor->setSpeed(newSpeed);
      break;
  
    case 't':
      //Change the steptype of the motor
      Serial.print("Changed steptype to ");
      Serial.print(p2);
      steptype = p2;
      break;
  
    case 'z':     
      //Save current postion as z0       
      currentPos = 0;
      Serial.println("Current position is now 0");
      break;
  
    case 'p':
      //Display the current position as steps and degree
      curPosition();
      break;
  
    case 'c':
      //Display the current settings
      currentSettings();
      break;

    case 'n':
      //change transmission
      tr = p2;
      Serial.print("Transmission ratio set to ");
      Serial.println(tr);
      break;

    case 'r':
      //release Motor
      Serial.println("Motor released");
      myMotor->release();
      break;

    case 'h':
      //release Motor
      Serial.println("Motor hold");
      myMotor->step(10,BACKWARD,steptype);
      break;
  
    default:
      break;
  }  
}




void curPosition(){
  //display the current position
  Serial.print("Current Position: ");
  Serial.print(currentPos);
  Serial.print(" steps, ");
  Serial.print(currentPos*1.8);
  Serial.println("°");
}

//Output commands
void help(){
  Serial.println("~~~~~~~Commands:~~~~~~~~");
  Serial.println("M S [rpm]: set speed in rpm");
  Serial.println("M T [Int]: Single(1), Double(2), Interleave(3) and Microstep(4)");
  Serial.println("M P: current position in steps and degree");
  Serial.println("M Z: set current position as 0");
  Serial.println("M C: get current config");
  Serial.println("M N [tr]: set transmission ratio");
  Serial.println("M R: release motor");
  
  Serial.println("G/T/C F [steps]: Forward/clockwise movement in steps");
  Serial.println("G/T/C B [steps]: Backward/anticlockwise movement in steps");
  Serial.println("G/T/C M [steps]: Move to specified position");
  
  Serial.println("repeat last command with ENTER");
}

void currentSettings(){
  Serial.println("~~~~~~~Current Settings:~~~~~~~~");
  Serial.print("speed: ");
  Serial.print(newSpeed);
  Serial.println("rpm");

  Serial.print("steptype: ");
  Serial.println(steptype);

  Serial.print("transmission ratio: ");
  Serial.println(tr);
}
