class InPlayController extends InputController {
	boolean[] keyPressed = new boolean[256];
	
	public void keyPressed() {
	    if (keyCode == KEY_SPACE && !keyPressed[keyCode])
	        game.ship.fire();
	    if (keyCode == KEY_CTRL && !keyPressed[keyCode])
	        game.ship.hyperspace();

	    if (keyCode < keyPressed.length) {
	        //println("Key pressed == " + keyCode);
	        keyPressed[keyCode] = true;
	    }
	}
	
	public void keyReleased() {
	    if (keyCode < keyPressed.length) {
	        //println("Key released == " + keyCode);
	        keyPressed[keyCode] = false;
	    }
	}
	
	public void checkKeyboard() {
	    if (keyPressed[KEY_LEFT])
	        game.ship.rotateLeft();
	
	    if (keyPressed[KEY_RIGHT])
	        game.ship.rotateRight();
	    if (keyPressed[KEY_UP])
	        game.ship.speedUp();
	    //if (keyPressed[KEY_DOWN])
	    //    game.ship.slowDown();
	}
}
