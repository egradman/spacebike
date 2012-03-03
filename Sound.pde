class Sound {
	private AudioChannel[] channels = new AudioChannel[6];
	private final int DEFAULT_CHANNELS = 6;
		
	public Sound(String filename) {
		init(filename, DEFAULT_CHANNELS);
	}

	public Sound(String filename, int channelCount) {
		if (channelCount == -1)
			channelCount = DEFAULT_CHANNELS;

		init(filename, channelCount);
	}

	public void init(String filename, int channelCount) {
		channels = new AudioChannel[channelCount];
		
		for (int i = 0 ; i < channels.length ; i++) {
			channels[i] = new AudioChannel(filename);
			channels[i].smoothPan = true;
		}
	}
	
	public void play() {
		if (noSound) return;
		
		int which = -1;
		
		for (int i = 0; i < channels.length; i++) {
			if (channels[i].state == Ess.STOPPED) {
				which = i; // Find a free voice
			}
		}
		
		// If a voice is available and selected, play it
		if (which != -1) {
			channels[which].sampleRate(44100, false);
			channels[which].play();
		}
	}
	
	public void stop() { };
}