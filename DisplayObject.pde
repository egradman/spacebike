public abstract class DisplayObject {
	public boolean remove = false;
	
    public void update(ListIterator it) { }
    protected abstract void draw();
}