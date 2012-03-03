class Shot extends FlyingObject {
	final float speed = 10;
	final float time = 0.8 * frameRate;
    float start = frameCount;
	
	/**
	 * @param x      Shot point.
	 * @param y      Shot point
	 * @param dx     Ship trajectory.
	 * @param dx     Ship trajectory.
	 * @param angle  Ship angle in degrees.
	 */
	public Shot(float x, float y, float dx, float dy, float angle) {
		super(x, y, 1, 1, 0, 0);
		this.dx = dx + speed * cos(radians(angle));
		this.dy = dy + -speed * sin(radians(angle));
		explodes = false;
		
		sounds.fire();
	}
	
    public void update(ListIterator it) {
    	super.update(it);
    	
    	if (frameCount >= start + time)
    		remove = true;
    }

	public void draw() {
		/*
		stroke(255, 0, 0);
		fill(255, 0, 0);
		rectMode(CENTER);
		rect(x, y, 3, 3);
		*/
		stroke(255);
		point(x, y);
	}
}
