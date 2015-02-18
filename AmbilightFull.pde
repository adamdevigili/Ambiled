import beads.*;
import org.jaudiolibs.beads.*;

import java.awt.Robot; // Use to take screenshots
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Dimension;
import processing.serial.*; // Used for serial communication

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;
import java.text.SimpleDateFormat;

import ddf.minim.*;

Serial port; //creates object "port" of serial class
Robot robby; //creates object "robby" of robot class

// Set up Loop
void setup(){
  // Set up the serial connection Note: May need to change serial port number
  port = new Serial(this, Serial.list()[1],9600);
  // Initalize the window size
  size(100, 100);
  // Try to create robot 
  try{
    robby = new Robot();
  }
  // If an error
  catch (AWTException e){
    println("Robot class not supported by your system!");
    exit();
  }
}

void ambilight()
{
  
  // Declare Variables hold the 32 bite result - ARGB(Alpha,Red,Green,Blue) - 8 bites each
  int pixel;
  // Initalize RGB variables
  float redTopLeft=0;
  float greenTopLeft=0;
  float blueTopLeft=0;
  float redTopRight=0;
  float greenTopRight = 0;
  float blueTopRight = 0;
  float redBotLeft = 0;  
  float greenBotLeft = 0;
  float blueBotLeft = 0;
  float redBotRight = 0;
  float greenBotRight = 0;
  float blueBotRight = 0;
  float r,g,b;
  
  while(true)
  {
    redTopLeft=0;
    greenTopLeft=0;
    blueTopLeft=0;
    redTopRight=0;
    greenTopRight = 0;
    blueTopRight = 0;
    redBotLeft = 0;  
    greenBotLeft = 0;
    blueBotLeft = 0;
    redBotRight = 0;
    greenBotRight = 0;
    blueBotRight = 0;
    
    // Get screenshot 
    BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(5760,1080)));
    int i,j;
  
  
    //TOP LEFT
    for(i = 100; i < 2780; i = i + 3){
      // For 900 pixles down (Height)
      for(j = 50; j < 490; j = j + 3){
        // Get pixel value - returns 32 bytes 
        pixel = screenshot.getRGB(i, j);
        // Position to red bytes and add up
        redTopLeft = redTopLeft+(int)(255&(pixel>>16));
        // Position to green bytes and add up
        greenTopLeft = greenTopLeft+(int)(255&(pixel>>8)); 
        // Position to blue bytes and add up
        blueTopLeft = blueTopLeft+(int)(255&(pixel));
      }
    }
    
    // Average the Colors (Remember we only added every other pixel)
    r = redTopLeft/((2680/3)*(440/3)); 
    g = greenTopLeft/((2680/3)*(440/3)); 
    b = blueTopLeft/((2680/3)*(440/3)); 
  
    if(r <=60){
      r=0;
    }
    if(g<=60){
      g=0;
    }
    if(b<=60){
      b=0;
    }
    
    //b = b/2;
    
    port.write(0xff); //write marker (0xff) for synchronization
    port.write((byte)(g)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(b)); //write blue value
  
    
    //TOP RIGHT
    for(i = 2980; i < 5660; i = i + 3){
        // For 900 pixles down (Height)
        for(j = 50; j < 490; j = j + 3){
          // Get pixel value - returns 32 bytes 
          pixel = screenshot.getRGB(i, j); 
          // Position to red bytes and add up
          redTopRight = redTopRight+(int)(255&(pixel>>16));
          // Position to green bytes and add up
          greenTopRight = greenTopRight+(int)(255&(pixel>>8)); 
          // Position to blue bytes and add up
          blueTopRight = blueTopRight+(int)(255&(pixel));
        }
     }
  
    // Average the Colors (Remember we only added every other pixel)
    r = redTopRight/((2680/3)*(440/3)); 
    g = greenTopRight/((2680/3)*(440/3)); 
    b = blueTopRight/((2680/3)*(440/3)); 
  
    if(r <=60){
      r=0;
    }
    if(g<=60){
      g=0;
    }
    if(b<=60){
      b=0;
    }
    
    //b = b/2;
    
    //System.out.println("R = " + r + ", G = " + g + ", B = " + b);
    background(r,g,b);
    
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
  
    //BOTTOM RIGHT
    for(i = 2980; i < 5660; i = i + 3)
    {
        for(j = 590; j < 1030; j = j + 3)
        {
          pixel = screenshot.getRGB(i, j); 
          // Position to red bytes and add up
          redBotRight = redBotRight+(int)(255&(pixel>>16));
          // Position to green bytes and add up
          greenBotRight = greenBotRight+(int)(255&(pixel>>8)); 
          // Position to blue bytes and add up
          blueBotRight = blueBotRight+(int)(255&(pixel));
        }
     }
    
      // Average the Colors (Remember we only added every other pixel)
    r = redBotRight/((2680/3)*(440/3)); 
    g = greenBotRight/((2680/3)*(440/3)); 
    b = blueBotRight/((2680/3)*(440/3)); 
    
    if(r <=60){
      r=0;
    }
    if(g<=60){
      g=0;
    }
    if(b<=60){
      b=0;
    }
  
    //b = b/2;
  
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
  
  
    //BOTTOM LEFT
    for(i = 100; i < 2780; i = i + 3)
    {
        for(j = 590; j < 1030; j = j + 3)
        {
          pixel = screenshot.getRGB(i, j); 
          // Position to red bytes and add up
          redBotLeft = redBotLeft+(int)(255&(pixel>>16));
          // Position to green bytes and add up
          greenBotLeft = greenBotLeft+(int)(255&(pixel>>8)); 
          // Position to blue bytes and add up
          blueBotLeft = blueBotLeft+(int)(255&(pixel));
        }
     }
    
      // Average the Colors (Remember we only added every other pixel)
    r = redBotLeft/((2680/3)*(440/3)); 
    g = greenBotLeft/((2680/3)*(440/3)); 
    b = blueBotLeft/((2680/3)*(440/3)); 
    
    if(r <=60){
      r=0;
    }
    if(g<=60){
      g=0;
    }
    if(b<=60){
      b=0;
    }
    
    //b /= 2;
    
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
  
    
    delay(10); //delay for safety
  }
}

void dayNightCycle()
{
    Date date = new Date();
    SimpleDateFormat simpDate;

    simpDate = new SimpleDateFormat("kk:mm:ss");
    System.out.println(simpDate.format(date));
  
}

void setAll(float r, float g, float b)
{
  for(int i = 0; i < 5; i++)
  {
    port.write(0xff); //write marker (0xff) for synchronization
    port.write((byte)(g)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(b)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
  
    delay(500);
  }
    exit();
}

void ambilightMovie()
{
  
  // Declare Variables hold the 32 bite result - ARGB(Alpha,Red,Green,Blue) - 8 bites each
  int pixel;
  // Initalize RGB variables
  float redTopLeft=0;
  float greenTopLeft=0;
  float blueTopLeft=0;
  float redTopRight=0;
  float greenTopRight = 0;
  float blueTopRight = 0;
  float redBotLeft = 0;  
  float greenBotLeft = 0;
  float blueBotLeft = 0;
  float redBotRight = 0;
  float greenBotRight = 0;
  float blueBotRight = 0;
  float r,g,b;
  
  // Get screenshot 
  BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(5760,1080)));
  int i,j;


  //TOP LEFT
  for(i = 1920; i < 2880; i = i + 2){
    // For 900 pixles down (Height)
    for(j = 0; j < 540; j = j + 2){
      // Get pixel value - returns 32 bytes 
      pixel = screenshot.getRGB(i, j); 
      // Position to red bytes and add up
      redTopLeft = redTopLeft+(int)(255&(pixel>>16));
      // Position to green bytes and add up
      greenTopLeft = greenTopLeft+(int)(255&(pixel>>8)); 
      // Position to blue bytes and add up
      blueTopLeft = blueTopLeft+(int)(255&(pixel));
    }
  }
  
  // Average the Colors (Remember we only added every other pixel)
  r = redTopLeft/((960/2)*(540/2)); 
  g = greenTopLeft/((960/2)*(540/2));
  b = blueTopLeft/((960/2)*(540/2)); 

  if(r <=60){
    r=0;
  }
  if(g<=60){
    g=0;
  }
  if(b<=60){
    b=0;
  }
  
  port.write(0xff); //write marker (0xff) for synchronization
  port.write((byte)(g)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(b)); //write blue value

  
  
  
  //TOP RIGHT
  for(i = 2880; i < 3840; i = i + 2){
    // For 900 pixles down (Height)
    for(j = 0; j < 540; j = j + 2){
      // Get pixel value - returns 32 bytes 
      pixel = screenshot.getRGB(i, j); 
      // Position to red bytes and add up
      redTopRight = redTopRight+(int)(255&(pixel>>16));
      // Position to green bytes and add up
      greenTopRight = greenTopRight+(int)(255&(pixel>>8)); 
      // Position to blue bytes and add up
      blueTopRight = blueTopRight+(int)(255&(pixel));
    }
  }
  
  // Average the Colors (Remember we only added every other pixel)
  r = redTopRight/((960/2)*(540/2)); 
  g = greenTopRight/((960/2)*(540/2)); 
  b = blueTopRight/((960/2)*(540/2)); 

  if(r <=60){
    r=0;
  }
  if(g<=60){
    g=0;
  }
  if(b<=60){
    b=0;
  }
  
  port.write((byte)(b)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(g)); //write blue value



  //BOTTOM RIGHT
  for(i = 2880; i < 3840; i = i + 2){
    // For 900 pixles down (Height)
    for(j = 540; j < 1080; j = j + 2){
      // Get pixel value - returns 32 bytes 
      pixel = screenshot.getRGB(i, j); 
      // Position to red bytes and add up
      redBotRight = redBotRight+(int)(255&(pixel>>16));
      // Position to green bytes and add up
      greenBotRight = greenBotRight+(int)(255&(pixel>>8)); 
      // Position to blue bytes and add up
      blueBotRight = blueBotRight+(int)(255&(pixel));
    }
  }
  
  
  
  // Average the Colors (Remember we only added every other pixel)
  r = redBotRight/((960/2)*(540/2)); 
  g = greenBotRight/((960/2)*(540/2)); 
  b = blueBotRight/((960/2)*(540/2)); 
  
  if(r <=60){
    r=0;
  }
  if(g<=60){
    g=0;
  }
  if(b<=60){
    b=0;
  }

  port.write((byte)(b)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(g)); //write blue value


  //BOTTOM LEFT
  for(i = 1920; i < 2880; i = i + 2){
    // For 900 pixles down (Height)
    for(j = 540; j < 1080; j = j + 2){
      // Get pixel value - returns 32 bytes 
      pixel = screenshot.getRGB(i, j); 
      // Position to red bytes and add up
      redBotLeft = redBotLeft+(int)(255&(pixel>>16));
      // Position to green bytes and add up
      greenBotLeft = greenBotLeft+(int)(255&(pixel>>8)); 
      // Position to blue bytes and add up
      blueBotLeft = blueBotLeft+(int)(255&(pixel));
    }
  }
  
  // Average the Colors (Remember we only added every other pixel)
  r = redBotLeft/((960/2)*(540/2)); 
  g = greenBotLeft/((960/2)*(540/2)); 
  b = blueBotLeft/((960/2)*(540/2));  
  
  if(r <=60){
    r=0;
  }
  if(g<=60){
    g=0;
  }
  if(b<=60){
    b=0;
  }
  
  port.write((byte)(b)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(g)); //write blue value

   
  
  delay(10); //delay for safety
  
}

void rainbowLoop()
{
  float r, g, b;
  int count = 0;
  
  while(true)
  {
    if(count % 4 == 0)
    {
      r = 255;
      g = 0;
      b = 0;
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      
      //TR
      
      r = 0;
      g = 255; 
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BR
      
      r = 0; 
      g = 0; 
      b = 255;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BL
      
      r = 255; 
      g = 255;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    if(count % 4 == 1)
    {
      r = 255; 
      g = 255;
      b = 0;
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      
      //TR
      
      r = 255; 
      g = 0; 
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BR
      
      r = 0;
      g = 255;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BL
      
      r = 0;
      g = 0;
      b = 255;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    if(count % 4 == 2)
    {
      r = 0;
      g = 0;
      b = 255;
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      
      //TR
      
      r = 255;
     g = 255;
     b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BR
      
      r = 255;
      g = 0;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BL
      
      r = 0;
      g = 255;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    if(count % 4 == 3)
    {
      r = 0;
      g = 255;
      b = 0;
      
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      
      //TR
      
      r = 0;
      g = 0;
      b = 255;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BR
      
      r = 255;
      g = 255;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      
      //BL
      
      r = 255;
      g = 0;
      b = 0;
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
  count ++;
  delay(250);
  
  }
}

void rainbowFadeLoop()
{
  
  float tlr = 250, tlg = 0, tlb = 0;       //RED
  float trr = 250, trg = 250, trb = 0;     //YELLOW
  float brr = 0, brg = 250, brb = 0;;      //GREEN
  float blr = 0, blg = 0, blb = 250;     //BLUE
  int count = 0;
  int step = 5;    //Multiple of 250
  
  int del = 1;
  int otherDel = 100;
  while(true)
  {
    
     if(count % 4 == 0)
    {
      for(int i = 0; i < 250; i += step)
      {
        //System.out.println("LOOP 1: TLR = " + blr + ", TLG = " + blg + ", TLB = " + blb);
        delay(del);
        //TL (red >>> yellow)
        tlg += step;
        port.write(0xff); //write marker (0xff) for synchronization
        port.write((byte)(tlg)); //write red value
        port.write((byte)(tlr)); //write green value
        port.write((byte)(tlb)); //write blue value
        
        
        //TR (yellow >>> green)
        trr -= step;
        port.write((byte)(trb)); //write red value
        port.write((byte)(trr)); //write green value
        port.write((byte)(trg)); //write blue value
        
        //BR (green >>> blue)
        brg -= step;
        brb += step;
        port.write((byte)(brb)); //write red value
        port.write((byte)(brr)); //write green value
        port.write((byte)(brg)); //write blue value
        
        //BL (blue >>> red)
        blr += step;
        blb -= step;
        port.write((byte)(blb)); //write red value
        port.write((byte)(blr)); //write green value
        port.write((byte)(blg)); //write blue value
        
        
      }
      
      delay(otherDel);
    }
    
    
    if(count % 4 == 1)
    {
      
      for(int i = 0; i < 250; i += step)
      {
        //System.out.println("LOOP 2: TLR = " + blr + ", TLG = " + blg + ", TLB = " + blb);
        delay(del);
        //TL (yellow >>> green)
        tlr -= step;
        port.write(0xff); //write marker (0xff) for synchronization
        port.write((byte)(tlg)); //write red value
        port.write((byte)(tlr)); //write green value
        port.write((byte)(tlb)); //write blue value
        
        
        //TR (green >>> blue)
        trg -= step;
        trb += step;
        port.write((byte)(trb)); //write red value
        port.write((byte)(trr)); //write green value
        port.write((byte)(trg)); //write blue value
        
        //BR (blue >>> red)
        brr += step;
        brb -= step;
        port.write((byte)(brb)); //write red value
        port.write((byte)(brr)); //write green value
        port.write((byte)(brg)); //write blue value
        
        //BL (red >>> yellow)
        blg += step;
        port.write((byte)(blb)); //write red value
        port.write((byte)(blr)); //write green value
        port.write((byte)(blg)); //write blue value
        
      }
      delay(otherDel);
    }
    
    if(count % 4 == 2)
    {
      for(int i = 0; i < 250; i += step)
      {
        //System.out.println("LOOP 3: TLR = " + blr + ", TLG = " + blg + ", TLB = " + blb);
        delay(del);
        //TL (green >>> blue)
        tlg -= step;
        tlb += step;
        port.write(0xff); //write marker (0xff) for synchronization
        port.write((byte)(tlg)); //write red value
        port.write((byte)(tlr)); //write green value
        port.write((byte)(tlb)); //write blue value
        
        
        //TR (blue >>> red)
        trr += step;
        trb -= step;
        port.write((byte)(trb)); //write red value
        port.write((byte)(trr)); //write green value
        port.write((byte)(trg)); //write blue value
        
        //BR (red >>> yellow)
        brg += step;
        port.write((byte)(brb)); //write red value
        port.write((byte)(brr)); //write green value
        port.write((byte)(brg)); //write blue value
        
        //BL (yellow >>> green)
        blr -= step;
        port.write((byte)(blb)); //write red value
        port.write((byte)(blr)); //write green value
        port.write((byte)(blg)); //write blue value
       
        
      }
      delay(otherDel);
    }
    
    if(count % 4 == 3)
    {
      for(int i = 0; i < 250; i += step)
      {
        //System.out.println("LOOP 4: TLR = " + blr + ", TLG = " + blg + ", TLB = " + blb);
        delay(del);
        //TL (blue >>> red)
        tlr += step;
        tlb -= step;
        port.write(0xff); //write marker (0xff) for synchronization
        port.write((byte)(tlg)); //write red value
        port.write((byte)(tlr)); //write green value
        port.write((byte)(tlb)); //write blue value
        
        
        //TR (red >>> yellow)
        trg += step;
        port.write((byte)(trb)); //write red value
        port.write((byte)(trr)); //write green value
        port.write((byte)(trg)); //write blue value
        
        //BR (yellow >>> green)
        brr -= step;
        port.write((byte)(brb)); //write red value
        port.write((byte)(brr)); //write green value
        port.write((byte)(brg)); //write blue value
        
        //BL (green >>> blue)
        blg -= step;
        blb += step;
        port.write((byte)(blb)); //write red value
        port.write((byte)(blr)); //write green value
        port.write((byte)(blg)); //write blue value
        
      }
      
      delay(otherDel);
    }
    
    count++;
    
  }
  
}

void breathe(float red, float green, float blue)
{
  
  int step1 = 1;
  float r = 0, g = 0, b = 0;
  
   while(true)
  {
    for(int i = 0; i < 250/step1; i++)
    {
      //delay(10);
      if(r <= red && red != 0)
        r += step1;
      if(g <= green && green != 0)
        g += step1;
      if(b <= blue && blue != 0)
        b += step1;
        
        
  
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    for(int i = 0; i < 250/step1; i++)
    {
      //delay(10);
      if(r > 0)
        r -= step1;
      if(g > 0)
        g -= step1;
      if(b > 0)
        b -= step1;
        
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
  }
  
}

void heartbeat(float red, float green, float blue)
{
  int step1 = 25;
  int step2 = 10;
  float r = 0, g = 0, b = 0;
  
  while(true)
  {
    for(int i = 0; i < 250/step1; i++)
    {
      //delay(10);
      if(r <= red && red != 0)
        r += step1;
      if(g <= green && green != 0)
        g += step1;
      if(b <= blue && blue != 0)
        b += step1;
        
        
  
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    for(int i = 0; i < 250/step1; i++)
    {
      //delay(10);
      if(r > 0)
        r -= step1;
      if(g > 0)
        g -= step1;
      if(b > 0)
        b -= step1;
        
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    
    
    
    
    for(int i = 0; i < 250/step2; i++)
    {
      //delay(10);
      if(r <= red && red != 0)
        r += step2;
      if(g <= green && green != 0)
        g += step2;
      if(b <= blue && blue != 0)
        b += step2;
        
        
  
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    for(int i = 0; i < 250/step2; i++)
    {
      //delay(10);
      if(r > 0)
        r -= step2;
      if(g > 0)
        g -= step2;
      if(b > 0)
        b -= step2;
        
      System.out.println("R = " + r + ", G = " + g + ", B = " + b);
      port.write(0xff); //write marker (0xff) for synchronization
      port.write((byte)(g)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(b)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
      port.write((byte)(b)); //write red value
      port.write((byte)(r)); //write green value
      port.write((byte)(g)); //write blue value
    }
    
    delay(800);
    
  }
  
  
}


void bottom(float r, float g, float b)
{
  port.write(0xff); //write marker (0xff) for synchronization
  port.write((byte)(0)); //write red value
  port.write((byte)(0)); //write green value
  port.write((byte)(0)); //write blue value
  port.write((byte)(0)); //write red value
  port.write((byte)(0)); //write green value
  port.write((byte)(0)); //write blue value
  port.write((byte)(b)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(g)); //write blue value
  port.write((byte)(b)); //write red value
  port.write((byte)(r)); //write green value
  port.write((byte)(g)); //write blue value
}

void topBottom(float tr, float tg, float tb, float br, float bg, float bb)
{
  port.write(0xff); //write marker (0xff) for synchronization
  port.write((byte)(tg)); //write red value
  port.write((byte)(tr)); //write green value
  port.write((byte)(tb)); //write blue value
  port.write((byte)(tb)); //write red value
  port.write((byte)(tr)); //write green value
  port.write((byte)(tg)); //write blue value
  port.write((byte)(bb)); //write red value
  port.write((byte)(br)); //write green value
  port.write((byte)(bg)); //write blue value
  port.write((byte)(bb)); //write red value
  port.write((byte)(br)); //write green value
  port.write((byte)(bg)); //write blue value
}

void leftRight(float lr, float lg, float lb, float rr, float rg, float rb)
{
  port.write(0xff); //write marker (0xff) for synchronization
  port.write((byte)(lg)); //write red value
  port.write((byte)(lr)); //write green value
  port.write((byte)(lb)); //write blue value
  port.write((byte)(rb)); //write red value
  port.write((byte)(rr)); //write green value
  port.write((byte)(rg)); //write blue value
  port.write((byte)(rb)); //write red value
  port.write((byte)(rr)); //write green value
  port.write((byte)(rg)); //write blue value
  port.write((byte)(lb)); //write red value
  port.write((byte)(lr)); //write green value
  port.write((byte)(lg)); //write blue value
}


Minim minim;
AudioInput in;

void audioVisualizer()
{
  float r = 0, g = 0, b = 0;
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn(Minim.STEREO, 512); 
  float level;
  
  while(true)
  { 
    level = in.mix.level();
    
    r = level * 450;
    b = level * 450;

    port.write(0xff); //write marker (0xff) for synchronization
    port.write((byte)(g)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(b)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
     
    delay(10);

  }
}

void audioVisualizerRainbow()
{
  float r = 0, g = 0, b = 0;
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn(Minim.STEREO, 512); 
  float level;
  int prev = -1, tLevel, fLevel;
  
  while(true)
  { 
    level = in.mix.level() * 400;
    
    if(level > 100.0)
    {
      level = 100.0;
    }

    tLevel = (int)level;
    
    if(prev == -1)
      prev = tLevel;
      
    System.out.println("FIRST: tLevel = " + tLevel + ", prev = " + prev);
    tLevel = (prev + tLevel)/2;  
    prev = tLevel;
    System.out.println("SECOND: tLevel = " + tLevel + ", prev = " + prev);
    
    r = -1 * pow(.3 * tLevel, 2) + 200;
    g = -1 * pow(.3 * tLevel - 17, 2) + 200;
    b = -1 * pow(.3 * tLevel - 33, 2) + 200;
    
    if(r < 0)
      r = 0;
    if(g < 0)
      g = 0;
    if(b < 0)
      b = 0;
      
   if(r > 200)
      r = 200;
    if(g > 200)
      g = 200;
    if(b > 200)
      b = 200;
    
    /*
    r = r * tLevel/100;
    g = g * tLevel/100;
    b = b * tLevel/100;
    */
    //System.out.println("LEVEL: " + tLevel + ", R = " + r + ", G = " + g + ", B = " + b);

    port.write(0xff); //write marker (0xff) for synchronization
    port.write((byte)(g)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(b)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
     
    //delay(5);

  }
}

void dayCycle()
{
  while(true)
  {
    int time = hour() * 60 + minute();
      
    float r = 50, g = 0, b;
    
    b = -1 * pow(.04 * time - 30, 2) + 250;
    
    if(b < 0)
      b = 0;
    
    
    port.write(0xff); //write marker (0xff) for synchronization
    port.write((byte)(g)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(b)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    port.write((byte)(b)); //write red value
    port.write((byte)(r)); //write green value
    port.write((byte)(g)); //write blue value
    
    delay(1000 * 60);
  }
}




// Draw Loop
void draw(){
  
  //heartbeat(250, 0, 0);
  //breathe(250, 0, 0);
  //rainbowLoop();
  setAll(50, 0, 0);
  //dayCycle();
  //rainbowFadeLoop();
  //ambilight();
  //ambilightMovie();
  //bottom(250, 100, 20);
  //topBottom(250, 0, 0, 240, 240, 240);
  //leftRight(250, 80, 0, 150, 150, 250);
  //audioVisualizer();
  //audioVisualizerRainbow();
  
}

