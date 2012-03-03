class SoundLoop {
	private AudioChannel channel;
	private int loops = Ess.FOREVER;
	
	public SoundLoop(String filename) {
		this.init(filename, Ess.FOREVER);
	}
	
	public SoundLoop(String filename, int loops) {
		this.init(filename, loops);
	}
	
	private void init(String filename, int loops) {
		channel = new AudioChannel(filename);
		channel.smoothPan = true;
		this.loops = loops;
	}

	public void play() {
		if (noSound) return;

		if (channel.state == Ess.PLAYING) {
			if (loops != Ess.FOREVER)
				channel.loop = channel.loop + 1;
			return;
		}
		channel.play();
		channel.loop(loops);
	}
	
	public void stop() {
		if (loops != Ess.FOREVER) return;
		channel.stop();
	}
}