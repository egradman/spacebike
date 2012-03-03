public class GameOver extends DisplayObject {
	void draw() {
		// Set the font and its size (in units of pixels)
		textFont(fontA, 48);
		textAlign(CENTER);
		
		stroke(255);
		fill(255);
		text("SYYN ASTEROIDS", width/2, height * .4);

		stroke(255);
		fill(255);
		textFont(fontA, 24);
		text("Hit the red FIRE button to play", width/2, height * .6);

		//textFont(fontA, 16);
		//text("A T&T Production", width/2, height - 20);
	}
}
