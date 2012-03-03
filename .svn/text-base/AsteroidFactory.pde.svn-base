class AsteroidFactory {
	public int quadrant = 0;
	
	public Polygon createPolygon(int[][] points) {
		int[] x = new int[points.length], y = new int[points.length];
		
		for (int i = 0 ; i < points.length ; i++) {
			x[i] = points[i][0];
			y[i] = points[i][1];
		}
		
		return new Polygon(x, y, points.length);
	}
	
	public Polygon scaleAsteroid(Polygon points, int scale) {
		Polygon result = new Polygon();
		
		for (int i = 0 ; i < points.npoints ; i++){
			result.addPoint((int)(points.xpoints[i] * (scale/100.0)), (int)(points.ypoints[i] * (scale/100.0)));
		}
		
		return result;
	}
	
	final private Polygon[] Shapes = {
		createPolygon(new int[][] { 
		{20, 0}, {80, 0}, {100, 20}, {100, 50}, {60, 100}, {40, 100}, {50, 70}, {25, 90}, {0, 70}, {20, 40}, {0, 20} }),
		
		createPolygon(new int[][] { 
		{20, 0}, {50, 0}, {100, 20}, {100, 30}, {50, 50}, {100, 60}, {75, 100}, {50, 80}, {20, 100}, {0, 60}, {0, 30} }),

		createPolygon(new int[][] { 
		{25, 0}, {50, 10}, {75, 0}, {100, 20}, {70, 45}, {100, 60}, {65, 100}, {30, 90}, {20, 100}, {0, 75}, {10, 50}, {0, 20} }),

		createPolygon(new int[][] { 
		{30, 0}, {50, 20}, {75, 0}, {100, 20}, {80, 50}, {100, 70}, {75, 100}, {30, 100}, {0, 70}, {0, 20} })
		};

	int roid = 0;
	Polygon nextAsteroid() {
		roid = ++roid % Shapes.length;
		//println("roid is " + roid);
		return Shapes[roid];
	}

	public class InitParams {
		public float x;
		public float y;
		public float dx;
		public float dy;
		private final int theta = 15;
		private final float border = 20.0;

		public InitParams(int quadrant) {
			int xBorder = (int)(width * border);
			int yBorder = (int)(height * border);
			
			switch (quadrant % 4) {
				case 0:
					this.x = width - xBorder + (int)random(0, xBorder);
					this.y = (int)random(height);
					break;
				case 1:
					this.x = (int)random(0, width);
					this.y = (int)random(0, yBorder);
					break;
				case 2:
					this.x = (int)random(0, xBorder);
					this.y = (int)random(height);
					break;
				case 3:
					this.x = (int)random(0, width);
					this.y = height - yBorder + (int)random(0, yBorder);
					break;
			}
			
			int angle = (int)(random(theta, 90 - theta) + (quadrant % 4) * 90);
			this.dx = cos(radians(angle));
			this.dy = sin(radians(angle));
		}
	}
	public void createSmall()  { 
		game.addObject(createSmallEx(null));
		}
	public void createMedium() { 
		game.addObject(createMediumEx(null));
		}
	public void createLarge()  { 
		game.addObject(createLargeEx(null));
		}
	
	public Asteroid createSmallEx(InitParams ip)  {
		return create(ip, nextAsteroid(), 15, 100, null, EXPLODE_SMALL);
		}
	public Asteroid createMediumEx(InitParams ip) { 
		return create(ip, nextAsteroid(), 40, 50, nextMedium, EXPLODE_MEDIUM);
		}
	public Asteroid createLargeEx(InitParams ip)  {
		return create(ip, nextAsteroid(), 60, 20, nextLarge, EXPLODE_BIG);
		}

	private Asteroid create(InitParams ip, Polygon polygon, int scale, int points, Next next, int explode) {
		InitParams init = ip == null ? new InitParams(quadrant++) : ip;
		polygon = scaleAsteroid(polygon, scale);
	   	return new Asteroid(init, polygon, points, next, explode);
	}
	
	abstract class Creator {
		abstract Asteroid create(InitParams ip);
	}
	

	/**
	 * Strategy for what happens when an asteroid explodes.  Use the asteroid that
	 * is breaking up as a reference point for position & velocity.
	 */
	class Next {
		Creator creator;
		
		public Next(Creator creator) {
			this.creator = creator;
		}
		
		void go(Asteroid a, List add) {
			InitParams[] ips = initParams(a);
			
			for (int i = 0 ; i < ips.length ; i++)
				add.add(creator.create(ips[i]));
		}
		
		InitParams[] initParams(Asteroid a) {
			final float delta = 1;
			InitParams[] result = new InitParams[2];
			result[0] = new InitParams(0);
			result[1] = new InitParams(0);
			
			float dx = random(-delta, delta);
			float dy = random(-delta, delta);
			
			result[0].x = result[1].x = a.x;
			result[0].y = result[1].y = a.y;
			
			result[0].dx = a.dx + dx;
			result[0].dy = a.dy + dy;
			
			result[1].dx = a.dx - dx;
			result[1].dy = a.dy - dy;

			return result;
		}
	}
	
	final Next nextLarge = new Next(new Creator(){
		Asteroid create(InitParams ip) { return createMediumEx(ip); }
	});
	
	final Next nextMedium = new Next(new Creator(){
		Asteroid create(InitParams ip) { return createSmallEx(ip); }
	});
}
