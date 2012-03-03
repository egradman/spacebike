public class ExplodingShip extends DisplayObject {
	float endAt = frameCount + (frameRate * 2);
	float x,y;
	
	public ExplodingShip(float x, float y) {
		this.x = x;
		this.y = y;
	}
	
	void update(ListIterator it) {
    	if (frameCount >= endAt) {
    		game.newShip(it);
    		remove = true;
    		return;
    	}
	}	
    public void draw() {
    	float w=20,h=20;
        stroke(255);
        translate(x - 20/2, y - 20/2);
        line(0, 0, w/2, 20);
        line(w/2, 0, 20, h/2);
    }
}