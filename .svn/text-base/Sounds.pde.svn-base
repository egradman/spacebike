class Sounds {
	public Sound[] boops = new Sound[] { new Sound ("low.wav", 1), new Sound("high.wav", 1) };
	public Sound shot = new Sound("shot.wav");
	public SoundLoop thrust = new SoundLoop("thrust.wav", 1);
	public SoundLoop smallShip = new SoundLoop("smallship.wav");
	public SoundLoop bigShip = new SoundLoop("bigship.wav");
	public Sound explodeLow = new Sound("explode_low.wav");
	public Sound explodeMedium = new Sound("explode_medium.wav");
	public Sound explodeHigh = new Sound("explode_high.wav");
	
	public void killAllSounds() {
		boops[0].stop();
		boops[1].stop();
		shot.stop();
		thrust.stop();
		smallShip.stop();
		bigShip.stop();
		explodeLow.stop();
		explodeMedium.stop();
		explodeHigh.stop();
	}
	
	public Sounds() {
		dR = (dS - dE) / N;
		println("Sounds Start Level @" + wait + " wait");
	}
	
	public void fire() { shot.play(); }
	
	public void explode(int size) {
		switch (size) {
			case EXPLODE_SMALL:
				explodeSmall();
				break;
			case EXPLODE_MEDIUM:
				explodeMedium();
				break;
			case EXPLODE_BIG:
			default:
				explodeBig();
		}
	}
	
	public void explodeSmall()  { explodeHigh.play(); }
	public void explodeMedium() { explodeMedium.play(); }
	public void explodeBig()    { explodeLow.play(); }
	
	int dS = 1000;
	int dE = 250;
	int N = 80;
	int dR, wait, start;
	int sound = 0;
	boolean inPlay = false;
	
	public void startLevel() {
		inPlay = true;
		wait = dS;
		start = millis();
		println("dS = " + dS);
		println("Sounds Start Level @" + wait + " wait, dS = " + dS);
	}

	public void playBoop() {
		if (!inPlay) return;
		
		int now = millis();
		
		//println("playBoop - interval=" + (now-start) + ", wait = " + wait);

		if (now - start > wait) {
			start = now;
			wait = max(wait - dR, dE);
			boops[sound].play();
			sound = (sound + 1) % 2;
		}
	}

	public void stopGame() {
		inPlay = false;
	}
	
	public void playThrust() { thrust.play(); }
	public void stopThrust() { thrust.stop(); }
}
