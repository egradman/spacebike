abstract class FlyingObject extends DisplayObject {
    protected float dx = 0, dy = 0, da = 7.5;
    protected float x = 0, y = 0;
    protected int w = 0, h = 0;
    protected float angle = 0;
    protected float dragX, dragY;
    protected boolean applyDrag = false;
    private final float DRAG_X = 0.02;
    private final float DRAG_Y = 0.02;
	protected int points = 0;
	protected boolean explodes = true;
	
    protected FlyingObject() {
    }
        
    protected FlyingObject(float x, float y, int w, int h, float dx, float dy) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.dx = dx;
        this.dy = dy;
	    this.dragX = DRAG_X;
	    this.dragY = DRAG_Y;
    }
    
    /**
     * Update the object by moving it along it's vector.
     */
    public void update(ListIterator it) {
        x += dx;
        
        if (x > width)
            x = -w;
        else if (x < -w)
            x = width;

        y += dy;
        
        if (y > height)
            y = -h;
        else if (y < -h)
            y = height;
            
        // Put some drag on the ship.
        //if (applyDrag) {
	//        dx = drag(dx, dragX);
	//        dy = drag(dy, dragY);
        //}
    }
    
    public boolean intersects(FlyingObject other) {
    	Rectangle r1 = new Rectangle((int)x, (int)y, w, h);
    	Rectangle r2 = new Rectangle((int)other.x, (int)other.y, other.w, other.h);
    	return r1.intersects(r2);
    }
    
    public void collide(FlyingObject other, List add) {
    	//println(this.getClass().getName() + " collided with a " + other.getClass().getName());
    	remove = true;
    	
    	int oldScore = game.getScore();
    	int newScore = game.addPoints(points);
    	
    	// Give a new ship at 10K, then every 25K aftewards.
    	
    	if ((oldScore < 10000 && newScore >= 10000)) {
    		println("NEW SHIP 10,000");
    		game.ships++;
    	}
    	else if ( (newScore > 10000 && ((oldScore % 25000) > (newScore % 25000))) ) {
    		println("NEW SHIP 25,000");
    		game.ships++;
    	}

    	if (explodes)
    		add.add(new Explosion(x, y));
    }
    
    private float drag(float d, float drag) {
        if (d == 0) return d;

        // Bleed off a percent
        float reduceBy = abs(drag * d);
        
        float result = (d > 0) ? constrain(d - reduceBy, 0, d) : constrain(d + reduceBy, d, 0);
        if (abs(frameRate * result) < 1) result = 0;
        //println("Slowing " + d + " to " + result + " == " + frameRate * result);
        return result;
    }
    
    public void rotateLeft() {
        angle = (angle + da) % 360;
        //println("New angle is " + angle);
    }
    public void rotateRight() {
        this.angle -= da;
        if (this.angle < 0) this.angle = (360 + this.angle);
        //println("New angle is " + angle);
    }
    
    public int width() { return w; }
    
    public Rectangle rect() {
		return new Rectangle((int)x, (int)y, w, h);
    }

    protected abstract void draw();
}
