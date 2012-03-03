class DisplayList {
	List objects = new LinkedList();

	public void add(DisplayObject o) {
		objects.add(o);
	}
	
	public void update() {
		ListIterator it = objects.listIterator();
	    
	    while (it.hasNext()) {
	    	DisplayObject fo = (DisplayObject)it.next();
	    	fo.update(it);
	    }
	}
	
	public void hitTest() {
		// Compare all pairs
		ListIterator lit = objects.listIterator(0);
	    ArrayList newObjects = new ArrayList();
	    FlyingObject l, r = null;
	    Object x;
	    
		if (!noHit) {
		    while (lit.hasNext()) {
		    	x = lit.next(); 
		    	if (!(x instanceof FlyingObject)) continue;
		    	
				l = (FlyingObject)x;
				if (l.remove) continue;
				
				ListIterator rit = objects.listIterator(lit.nextIndex());
	
				while (rit.hasNext()) {
			    	x = rit.next(); 
			    	if (!(x instanceof FlyingObject)) continue;
	
					r = (FlyingObject)x;
					if (r.remove) continue;
					
					if (l.intersects(r)) {
						l.collide(r, newObjects);
						r.collide(l, newObjects);
						break;
					}
				}
			}
		}
		
		// Remove dead objects.
		Iterator it = objects.iterator();
		
		while (it.hasNext()) {
			DisplayObject fo = (DisplayObject)it.next();
			
	    	if (fo.remove) {
	    		//println("yanking " + fo.getClass().getName());
	    		it.remove();
	    	}
		}
		
		// Add new objects.
		it = newObjects.iterator();
		
		while (it.hasNext())
			objects.add(it.next());
	}
	
	public Iterator iterator() {
		return objects.iterator();
	}
}
