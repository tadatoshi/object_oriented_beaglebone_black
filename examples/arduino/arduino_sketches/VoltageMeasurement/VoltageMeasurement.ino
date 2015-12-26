/* 
   Sends the raw voltage and current to the serial port. 
   
   Created by Tadatoshi Takahashi
*/

const int inputVoltagePin = 0;
const int inputCurrentPin = 1; 
const int outputVoltagePin = 2;
const int outputCurrentPin = 3;

void setup() {
  Serial.begin(9600, SERIAL_8N1); // send and receive at 9600 baud 
}

void loop() {
  
//  Serial.println("In loop");

  

//  delay(1000);
  
}  

void serialEvent() {  
  
//  Serial.println("Testing serialEvent method.");
  
  while (Serial.available()) {
    
//    Serial.println("In Serial.available()");

    char command = Serial.read();
    
//    Serial.print("command: ");
//    Serial.println(command);    

    // 'm' for measure:
    if (command == 'm') {
      
//      Serial.println("if for m");
      
      measureRawVoltageAndCurrent();
    
    }
  
  }
  
//  delay(1000);
  
}

void measureRawVoltageAndCurrent() {
  
//  Serial.println("in measureRawVoltageAndCurrent");

  // In order to have analog steps between 0 and 4095:
  analogReadResolution(12);
  
  int rawReadingForInputVoltage = analogRead(inputVoltagePin);
  int rawReadingForInputCurrent = analogRead(inputCurrentPin);
  int rawReadingForOutputVoltage = analogRead(outputVoltagePin);
//  int rawReadingForOutputCurrent = analogRead(outputCurrentPin); 
    
  Serial.print("{\"raw_reading_for_input_voltage\": ");
  Serial.print(rawReadingForInputVoltage);
  Serial.print(", \"raw_reading_for_input_current\": ");
  Serial.print(rawReadingForInputCurrent);
  Serial.print(", \"raw_reading_for_output_voltage\": ");
  Serial.print(rawReadingForOutputVoltage);  
//  Serial.print(", \"raw_reading_for_output_current\": ");
//  Serial.print(rawReadingForOutputCurrent);    
  Serial.println("}");
 
//  delay(1000); 
  
}
