/**
 * A display object with a fixed lifetime.
 */
public class NewGame extends DisplayObject {
	int end;
	final int seconds = 1;
		
	public NewGame() {
		end = (int)(frameCount + seconds * frameRate);
	}
		
	void update(ListIterator it) {
		if (frameCount >= end && !remove) {
			remove = true;
			game.startNewLevel(it);
		}
	}
	
	void draw() {
	}
}