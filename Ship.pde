class Ship extends FlyingObject {
    boolean showThrust = false;
    private final int MAX_DX = 15;
    private final int MAX_DY = 15;
    private int inHyperspace = -1;
    
    public Ship(int x, int y) {
    	super(x, y, 21, 14, 0, 0);
    	this.dragX = this.dragY = 0.0075;
		angle = 90;
    	applyDrag = false;
    }
    
    public void speedUp() {
    	showThrust = true;
    	this.thrust(0);
    }
    
    // not really used - just for play
    public void slowDown() {
    	this.thrust(180);
    }
    
    public void thrust_pedals(float factor) {
        int direction = 0;
        dx = factor * cos(radians(direction + this.angle));
        dy = factor * -sin(radians(direction + this.angle));

        //println("Slowing down from (" + dx + "," + dy + ") to (" + (boostX + dx) + "," + (boostY + dy) + ")");
        //dx = constrain(dx += boostX, -MAX_DX, MAX_DX);
        //dy = constrain(dy += boostY, -MAX_DY, MAX_DY);
    }
    
     public void rotateShip(float _da) {
        //angle = (angle + _da) % 360;
        this.angle = 90 + 180 * _da;
        if (this.angle < 0) this.angle = (360 + this.angle);
        //println("New angle is " + angle);
    }
 
    
    private void thrust(int direction) {
    	float factor = 0.27;
        float boostX = factor * cos(radians(direction + this.angle));
        float boostY = factor * -sin(radians(direction + this.angle));

        //println("Slowing down from (" + dx + "," + dy + ") to (" + (boostX + dx) + "," + (boostY + dy) + ")");
        //dx = constrain(dx += boostX, -MAX_DX, MAX_DX);
        //dy = constrain(dy += boostY, -MAX_DY, MAX_DY);
    }
    
    public void hyperspace() {
    	if (inHyperspace != -1) return;
    	// find a new point on the screen that's safe for the ship
    	println("--H Y P E R  S P A C E--");
    	inHyperspace = millis();
    }

	/**
	 * Of course we are different, we draw ourself at -w/2, -h/2 to keep rotation about our center.
	 */
    public boolean intersects(FlyingObject other) {
    	if (inHyperspace != -1) return false;
    	Rectangle r1 = new Rectangle((int)x - w/2, (int)y - h/2, max(w, h), max(w, h));
    	Rectangle r2 = new Rectangle((int)other.x, (int)other.y, other.w, other.h);
    	return r1.intersects(r2);
    }
    
    public void collide(FlyingObject other, List add) {
    	super.collide(other, add);
    	
    	game.shipDied();
    	println("Adding exploding ship");
    	add.add(new ExplodingShip(x, y));
    }
    
    public void fire() {
    	if (inHyperspace != -1) return;
    	if (remove) return;

    	// Here's where the tip of the ship is at.
    	float sx = x + (w/2 + 2) * cos(radians(angle));
    	float sy = y - (w/2 + 2) * sin(radians(angle));
    	game.addObject(new Shot(sx, sy, dx, dy, angle));
    }

    public void drawAt(int x, int y) {
    	this.x = x;
    	this.y = y;
    	
    	this.draw();
    }
    
    final Dimension hyperspaceSafeWH = new Dimension((int)(1.5 * this.w), (int)(1.5 * this.h));
    final float hyperspaceWait = 1.0 * 1000;
    
    public void draw() {
    	if (inHyperspace != -1) {
    		// Wait before ship returns
    		if ((inHyperspace + hyperspaceWait) > millis()) {
    			return;
    		}
    		
    		// find a new point on the screen that's safe for the ship
    		Point newCenter = game.findSafeZone(hyperspaceSafeWH);
    		if (newCenter != null) {
    			println("LEAVING HYPERSPACE @ " + newCenter);
    			this.x = newCenter.x;
    			this.y = newCenter.y;
    			this.dx = this.dy = 0;
    			inHyperspace = -1;
    		}
    		else {
    			return;
    		}
    	}

        stroke(255);
        translate(x, y);
        rotate(2*PI-radians(this.angle));
        translate(-w/2, -h/2);
        line(0, 0, w, h/2);
        line(w, h/2, 0, h);
        line(w * 0.1, h * 0.1, w*0.1, h - h*0.1);
        if (showThrust) {
        	sounds.playThrust();
            showThrust = false;
            line(w * 0.1, h * 0.1 + 2, w*0.1 - w*0.2, (h - h*0.1) / 2);
            line(w * 0.1 - w*0.2, (h - h*0.1) / 2, w*0.1, h - h*0.1 - 2);
        }
    }
}
