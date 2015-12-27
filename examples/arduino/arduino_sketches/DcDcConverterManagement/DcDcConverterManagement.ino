/* 
   Sends the raw voltage and current to the serial port and receives raw PWM value from the serial port. 
   
   Created by Tadatoshi Takahashi
*/

const int inputVoltageAnalogInputPin = 0;
const int inputCurrentAnalogInputPin = 1; 
const int outputVoltageAnalogInputPin = 2;
const int outputCurrentAnalogInputPin = 3;
const int pwmDigitalPin = 8; // Just in case, selected a pin number different from the ones used for input pins. 

void setup() {
  pinMode(pwmDigitalPin, OUTPUT);
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
    
    // 'p' for pwm (e.g. "p127": 127 out of between 0 and 255 gives 50% duty cycle):
    } else if (command == 'p') {
      
//      Serial.println("else if for p");
    
      int dutyCycle = Serial.parseInt();
//      Serial.print("duty cycle: ");
//      Serial.println(dutyCycle);
      
      setDutyCycle(pwmDigitalPin, dutyCycle);
//      Serial.println("duty_cycle_set");
    
    // 'o' for b'o'ost (set duty cycle for the second switch with the first one clsed = 255):
    }
  
  }
  
//  delay(1000);
  
}

void measureRawVoltageAndCurrent() {
  
//  Serial.println("in measureRawVoltageAndCurrent");

  // In order to have analog steps between 0 and 4095:
  analogReadResolution(12);
  
  int rawReadingForInputVoltage = analogRead(inputVoltageAnalogInputPin);
  int rawReadingForInputCurrent = analogRead(inputCurrentAnalogInputPin);
  int rawReadingForOutputVoltage = analogRead(outputVoltageAnalogInputPin);
//  int rawReadingForOutputCurrent = analogRead(outputCurrentAnalogInputPin); 
    
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

void setDutyCycle(int pwmPin, int dutyCycle) {
  analogWrite(pwmDigitalPin, dutyCycle);
  
//  delay(1000);
}  

