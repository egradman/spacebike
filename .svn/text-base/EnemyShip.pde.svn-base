/** 
 * Base class for enemy ships.
 *
 * 200 for big
 * 1000 for small
 */
public class EnemyShip extends FlyingObject {
	Polygon vertices;
	Shot shot = null;
	int radius;
	float savedDY = 0;
	int lastShot = 0;
	float shotDelay = 1;
	int lastDirChange = 0;
	float dirChangeDelay = 1.5;
	boolean big = false;
	int targetHero = 0;
	int targetHeroEvery = 3;
	
	public EnemyShip(boolean big) {
		super(0, 0, 0, 0, 0, 0);
	
		this.big = big;
			
		int left = 0;
		int right = width - left;
		int top = height/10;
		int bottom = height - top;
		float speed = big ? 1.5 : 2;
		
		switch ((int)random(1, 4)) {
			case 1: x = left;  y = top;    dx =  1; break;
			case 2: x = left;  y = bottom; dx =  1; break;
			case 3: x = right; y = top;    dx = -1; break;
			case 4: x = right; y = bottom; dx = -1; break;
		}
		
		dx = dx * speed;
		dy = 0;
		
		savedDY = speed;
		
		shotDelay = big ? 1 : 0;
		lastShot = frameCount;

		dirChangeDelay = big ? 2.5 : 2;
		lastDirChange = frameCount;
		
		// This looks crummy for small ones, redo, the multiple just isn't good
		// Also make this into a factory - too costly to redo each time.
		vertices = game.asteroidFactory.createPolygon(new int[][] { 
			{40, 0}, {60, 0}, {70, 20}, {100, 40}, {70, 60}, {30, 60}, {0, 40}, {30, 20} });
		
		if (big) {
			points = 200;
			vertices = game.asteroidFactory.scaleAsteroid(vertices, 40);
		}
		else {
			points = 1000;
			vertices = game.asteroidFactory.scaleAsteroid(vertices, 20);
		}
		
		w = vertices.getBounds().width;
		h = vertices.getBounds().height;
		radius = (int)(sqrt(h * h + w * w) / 2) + 1;

		startSounds();
	}

	public void startSounds() {
		if (this.big)
			sounds.bigShip.play();
		else
			sounds.smallShip.play();
	}
	
	public void stopSounds() {
		if (this.big)
			sounds.bigShip.stop();
		else
			sounds.smallShip.stop();
	}
	
    public void collide(FlyingObject other, List add) {
    	super.collide(other, add);
    	sounds.explode(EXPLODE_MEDIUM);
    	stopSounds();
    	
    	game.enemy = null;
    	
    	println("Enemy exploded!");
    	
    	// HACK : Remove after testing
		//game.enemy = new EnemyShip(true);
		//game.addObject(game.enemy);
	}
    
    void update(ListIterator it) {
    	// If ship is off screen yank it.
    	if ( ((x + dx) > width) || ((x + dx) < -w) ) {
    		println("Enemy off screen");
    		stopSounds();
    		remove = true;
    		game.enemy = null;
    		return;
    	}
    	
    	// Move the ship up, down, or keep it level every x% of the screen.
   		if (frameCount > (lastDirChange + dirChangeDelay * frameRate)) {
   			lastDirChange = frameCount;
   			//println("frameCount=" + frameCount + "," + lastDirChange + "," + dirChangeDelay + "," + frameRate);
   			switch((int)random(0, 100) % 3) {
   				case 0: dy = savedDY; break;
   				case 1: dy = 0; break;
   				case 2: dy = -savedDY; break;
   			}
   		}
    	
    	// Update it
    	super.update(it);
    	
    	if (shot == null || shot.remove) {
    		shot = null;
    		
    		// Wait a bit before firing
    		if (frameCount > (lastShot + shotDelay * frameRate)) {
    			fire(it);
    		}
    	}
    }
    
    private void fire(ListIterator it) {
		lastShot = frameCount;
    	//println("Enemy shot fired!");
    	
    	// small ship shoots right at our hero every 3rd shot
    	if (!this.big) {
    		targetHero = (targetHero + 1) % targetHeroEvery;
    	}
    	
    	float l = x, t = y, a = 135;

    	if (!this.big && targetHero == 0) {
			Rectangle r = game.ship.rect();
	   		Rectangle d = this.rect();
	   		//println("ship is  at " + r.toString() + ", enemy at " + d.toString());
	   		d.translate((int)-r.x, (int)-r.y);
	   		//println("ship is  NOW at " + r.toString() + ", enemy at " + d.toString());
	   		translate(r.x, r.y);
			a = degrees(atan2(d.y, -d.x));
	   		translate(-r.x, -r.y);
    	}
    	else {
			a = (int)random(0, 360);
    	}
		
		l = x + w/2 + radius * cos(radians(a));
		t = y + h/2 - radius * sin(radians(a));

		println("Shot = " + a + " @ " + l + ", " + t);

		shot = new Shot(l, t, dx, dy, a);
    	it.add(shot);
    }
		
	void draw() {
        stroke(255);
        noFill();
        translate(x, y);

        beginShape();
		for (int i = 0 ; i < vertices.npoints ; i++)
			vertex(vertices.xpoints[i], vertices.ypoints[i]);
		endShape(CLOSE);
		
		line(vertices.xpoints[2], vertices.ypoints[2], vertices.xpoints[7], vertices.ypoints[7]);
		line(vertices.xpoints[3], vertices.ypoints[3], vertices.xpoints[6], vertices.ypoints[6]);

	}
}