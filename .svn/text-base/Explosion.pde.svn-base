/**
 * All explosions look like a little puff of dust extending out from the center of what
 * exploded.  You can choose a size from small to large.
 */
public class Explosion extends DisplayObject {
	float x, y;
	final int lifetime = 1;  // Lifetime in seconds
	private int end;
	private int[][] pts = { { 0, 1, 0 }, { 90, 2, 0 }, { 180, 1, 0 }, { 250, 2, 0 } };
	
	public Explosion(float x, float y) {
		this.x = x;
		this.y = y;
		end = (int)(frameCount + frameRate * lifetime);

		// Generate particles velocities.
	}
	
	void update(ListIterator it) {
		for (int i = 0 ; i < pts.length ; i++)
			pts[i][2] += pts[i][1];
					
		if (frameCount >= end) {
			this.remove = true;
		}
	}
	
	void draw() {
		translate(x, y);
		stroke(255);
		
		for (int i = 0 ; i < pts.length ; i++) {
			rotate(radians(pts[i][0]));
			point(pts[i][2], 0);
		}
	}
}