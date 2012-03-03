import java.awt.Point;
import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;
import fullscreen.*; 

import oscP5.*;
import netP5.*;

import krister.Ess.*;

// Globals for Debugging
boolean noSound = false;	// Turn off sounds
boolean noHit = false;		// Turn off hit testing 

OscP5 oscP5;


/**
 * TODO
 * o Character Generator for Asteroid Font
 * o High Scores
 */
void setup() {
        FullScreen fs; 
        size(640, 480);
  
        // 5 fps
        frameRate(30);

        // Create the fullscreen object
        fs = new FullScreen(this); 
  
        // enter fullscreen mode
        //fs.enter(); 

	smooth();

	fontA = loadFont("CourierNew36.vlw");
    
	// Start sound
	Ess.start(this); // Start Ess
	sounds = new Sounds();

	game = new Game();
	game.init(true);
	
        oscP5 = new OscP5(this,1234);

	println("Game Started");
	println("Size = (" + width + ", " + height + ")");
}

void draw() {
	try {
		game.draw();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
}

void keyPressed() {
	game.controller.keyPressed();
}

void keyReleased() {
	game.controller.keyReleased();
}

void mousePressed() {
	game.controller.mousePressed();
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message.");
  if (theOscMessage.addrPattern().equals("/steer")) {
    float steer = theOscMessage.get(0).floatValue();
    game.ship.rotateShip(steer);
    //println("steer " + theOscMessage.get(0).floatValue());
  } else if (theOscMessage.addrPattern().equals("/fire")) {
    //println("fire!");
    if (game.game_is_over) {
      game = new Game();
      game.init(false);
    } else {
      game.ship.fire();
    }  
  } else if (theOscMessage.addrPattern().equals("/velocity")) {
    println("velocity");
    float velocity = theOscMessage.get(0).floatValue();
    game.ship.thrust_pedals(velocity);
  }
}

Game game = null;
PFont fontA;
Sounds sounds;

public final int EXPLODE_BIG = 2;
public final int EXPLODE_MEDIUM = 1;
public final int EXPLODE_SMALL = 0;

