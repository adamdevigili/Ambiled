/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

int r = 0, g = 0, b = 0;

public void redSlider_change1(GSlider source, GEvent event) { //_CODE_:redSlider:421674:
  r = source.getValueI();
  setAll(r, g, b);
} //_CODE_:redSlider:421674:

public void greenSlider_change1(GSlider source, GEvent event) { //_CODE_:greenSlider:413763:
  g = source.getValueI();
  setAll(r, g, b);
} //_CODE_:greenSlider:413763:

public void blueSlider_change1(GSlider source, GEvent event) { //_CODE_:blueSlider:765498:
  b = source.getValueI();
  setAll(r, g, b);
} //_CODE_:blueSlider:765498:

public void rainbowFadeButton_click1(GButton source, GEvent event) { //_CODE_:rainbowFadeButton:835400:
  thread("rainbowFadeLoop");
} //_CODE_:rainbowFadeButton:835400:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.PURPLE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  redSlider = new GSlider(this, 20, 40, 331, 28, 10.0);
  redSlider.setLimits(0.0, 0.0, 250.0);
  redSlider.setNbrTicks(240);
  redSlider.setEasing(2.0);
  redSlider.setNumberFormat(G4P.DECIMAL, 2);
  redSlider.setLocalColorScheme(GCScheme.RED_SCHEME);
  redSlider.setOpaque(false);
  redSlider.addEventHandler(this, "redSlider_change1");
  greenSlider = new GSlider(this, 20, 100, 330, 26, 10.0);
  greenSlider.setLimits(0.0, 0.0, 250.0);
  greenSlider.setNbrTicks(240);
  greenSlider.setEasing(2.0);
  greenSlider.setNumberFormat(G4P.DECIMAL, 2);
  greenSlider.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  greenSlider.setOpaque(false);
  greenSlider.addEventHandler(this, "greenSlider_change1");
  blueSlider = new GSlider(this, 20, 160, 332, 26, 10.0);
  blueSlider.setLimits(0.0, 0.0, 250.0);
  blueSlider.setNbrTicks(240);
  blueSlider.setEasing(2.0);
  blueSlider.setNumberFormat(G4P.DECIMAL, 2);
  blueSlider.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  blueSlider.setOpaque(false);
  blueSlider.addEventHandler(this, "blueSlider_change1");
  rainbowFadeButton = new GButton(this, 20, 200, 80, 30);
  rainbowFadeButton.setText("Rainbow Fade");
  rainbowFadeButton.addEventHandler(this, "rainbowFadeButton_click1");
}

// Variable declarations 
// autogenerated do not edit
GSlider redSlider; 
GSlider greenSlider; 
GSlider blueSlider; 
GButton rainbowFadeButton; 

