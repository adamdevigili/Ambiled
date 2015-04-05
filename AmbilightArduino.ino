/* TLC5940 16-port LED driver
 = Paden Hogeland - Adjusted for use of 4 RGB LED's
 * Peter Mackey  June 2007  Pratt Digital Arts  pmackey@pratt.edu
 * direct adressing to PORTB, smooth flickerless fading (thanks to Amp on the Arduino forum)
 * additional logic from David Cuartielles's & Marcus Hannerstig's LEDdriver demo
 = see the TLC5940 data sheet for the logic behind these pulse sequences
 */

// Name the Arduino pins to the TLC5940 pin names
#define VPRG 2 
#define SIN 3 
#define SCLK 7 
#define XLAT 4
#define BLANK 5
#define DCPRG 6
#define GSCLK 8 //note: but using PORTB method

#define MSINTRVL 0 // could be used to delay updating of incrementFades()
#define FADEMIN 0 // lowest fade level LEDs will reach (min would be 0, max 4065)
#define FADEINCR 64   // determines how many steps it takes to run the desired range (lower=longer)

// Array to hold the port values 0 min - 4095 max
int port[] = {
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; 
int faderNdx = 0;  //counter used in this fading sequence

int fadeState[] = {
  1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; //stores the direction of fading for each port 1,0,-1
//start with first port

int next; //used for limit checking in fading function
float prevMillis; //used for a timing delay

int myword[] = {0,0,0,0,0,0,0,0,0,0,0,0}; //temp storage for reversing bits in a word (for greyscale setting)
// Declare the RGB varables
double red,green,blue;

// Set up 
void setup() {
  // Assign the output pins
  pinMode(VPRG, OUTPUT);    
  pinMode(SIN, OUTPUT);    
  pinMode(SCLK, OUTPUT); 
  pinMode(XLAT, OUTPUT);    
  pinMode(BLANK, OUTPUT);    
  pinMode(DCPRG, OUTPUT);    
  pinMode(GSCLK, OUTPUT);       // Could also set DDRB directly

  // Initalize Serial Connection
  Serial.begin(9600);
  
  // Initalize unused TLC5940 pins 
  port[1] = 0;
  port[2] = 0;
  port[15] = 0;
  port[0] = 0;
  
  preset();    //input �Dot Correction� data
}

// Main Loop
void loop () {
  setGreys(); 
  feedPorts();    
  // If have passed the interval
  if (millis() > (prevMillis+MSINTRVL)){
    // Set the RGB values
    setRGB();
    // Set new previous time
    prevMillis=millis();
  }
} 

// Set the RGB values
void setRGB() {
  // If correct amount of serial is avaiable
  if(Serial.available() >= 13 ){
    // If we are at the first chunk of data
    if(Serial.read() == 0xff){
      
      // Set the top Left Side
      red = Serial.read();
      blue = Serial.read();
      green = Serial.read();
      // Get the percentage of each value then update port accordinly
      port[12] = (4095)*(red/255);
      port[13] = (4095)*(blue/255);
      port[14] = (4095)*(green/255);


      // Set the Top right Side
      red = Serial.read();
      blue = Serial.read();
      green = Serial.read();
      // Get the percentage of each value then update port accordinly
      port[9] = (4095)*(red/255);
      port[11] = (4095)*(green/255);
      port[10] = (4095)*(blue/255);
      
      // Set the bottom Right Side
      red = Serial.read();
      blue = Serial.read();
      green = Serial.read();
      // Get the percentage of each value then update port accordinly
      port[6] = (4095)*(red/255);
      port[8] = (4095)*(green/255);
      port[7] = (4095)*(blue/255);
           
      // Set the bottom left Side
      red = Serial.read();
      blue = Serial.read();
      green = Serial.read();
      // Get the percentage of each value then update port accordinly
      port[3] = (4095)*(red/255);
      port[4] = (4095)*(blue/255);
      port[5] = (4095)*(green/255);
     
    }
  }
}

//=======5940 control======================================
void setGreys()  {
  
  // For the each port (12 bit word * 16 ports =192 bits in this loop)...
  for (int i=15; i>=0; i--) { 
    // Initalize the data
    int datb = port[i];    

    // Load fade level bits into the temp array BACKWARDS
    for (int j=11; j>=0; j--) { 
      myword[j]=(datb & 1); //& bitwise AND	
      datb >>= 1;        //shift right and assign
      // (maybe there's a slicker way to do this!? but this works...)
    }
    // Send the data to the 5940
    for (int j=0; j<12; j++) { 
      digitalWrite(SIN,myword[j]);  
      pulseSCLK();
    }  
  }  
  digitalWrite(XLAT, HIGH);
  digitalWrite(XLAT, LOW);
}

void feedPorts() { 
  // The actual sequencing of the PWM data into the LEDs, must do constantly...
  digitalWrite(BLANK, HIGH);    
  digitalWrite(BLANK, LOW);	//=all outputs ON, start PWM cycle

  for (int i=0; i<4096; i++) {
    pulseGSCLK();
  }
}

//DOT CORRECTION...do once
void preset() {
  //Input �DotCorrex� Data
  //16 outputs, 64 posssible levels of adjustment, 6 bits/chan = 96 bits total
  //[use if any LEDs in array are physically too bright]

  digitalWrite(DCPRG, HIGH);	//leaving it H is my arbitrary choice (="write to register not EEPROM")  
  digitalWrite(VPRG, HIGH);     //=inputting data into dot correx register

  digitalWrite(BLANK, HIGH);	//=all outputs off, when this goes high it resets the greyscale counter
  digitalWrite(SIN, LOW);       //to start dot correction
  digitalWrite(XLAT, LOW);	

  //begin loading in the dot correx data, most significant bit first...
  //but here we are not correcting anything, so LSB is going first!
  for (int i=0; i<16; i++) { //16 ports
    for (int j=0; j<6; j++) { //6 bits of data for each port
      digitalWrite(SIN,	HIGH);	//for now, 111111 for everybody
      pulseSCLK();
      digitalWrite(SIN,	LOW);
    }
  }

  //----doing the FIRST GREYSCALE SETTING here becuz of the unique 193rd clock pulse

  digitalWrite(XLAT, HIGH);   //latch the dot data into the dot correx register
  digitalWrite(XLAT, LOW);
  digitalWrite(VPRG, LOW);    //entering greyscale mode

  for (int i=0; i<16; i++) { //16 ports
    int datb = 4095;        //using same fade level for all ports this first time

    for (int j=0; j<12; j++) { //data for each port, all the same value to start
      digitalWrite(SIN,	datb & 01);	
      pulseSCLK();
      datb>>=1;
    }  
  }  
  digitalWrite(XLAT, HIGH);  //latch the greyscale data 
  digitalWrite(XLAT, LOW);
  pulseSCLK();               //193rd clock pulse only need to do the FIRST time after dot correx

  digitalWrite(BLANK, LOW);  //=all outputs ON, start PWM cycle... moved here
}

//SCLK used in dot correx and greyscale setting
void pulseSCLK() {
  digitalWrite(SCLK, HIGH);
  digitalWrite(SCLK, LOW);
}

void pulseGSCLK() {
  //ultra fast pulse trick, using digitalWrite caused flickering
  PORTB=0x01; //bring PORTB0 high (pin 8), other ports go low [0x01 does only pin 8, 0x21 also lifts pin 13]
  //16nanosecs is the min pulse width for the 5940, but no pause seems needed here
  PORTB=0x20;  //keep pin13 high [0x00 would be all low]
}

