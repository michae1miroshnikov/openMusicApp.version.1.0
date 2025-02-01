import AVFoundation

class AudioPlayerManager {
    static let shared = AudioPlayerManager()
    private var audioPlayer: AVAudioPlayer?
    private(set) var isPlaying: Bool = false
    private var currentTrackIndex = 0
    private let trackList = ["Boombox-Полина","bumboks_-_hottabych","bumboks_-_vahteram","Volodymyr Dantes - Оля"] // Add more tracks as needed
    
    private init() {}
    
    func loadAudioFile(trackName: String) {
        guard let url = Bundle.main.url(forResource: trackName, withExtension: "mp3") else {
            print("Track \(trackName) not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    func togglePlayPause() {
        guard let player = audioPlayer else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
    }
    
    func skipToNextTrack() {
        currentTrackIndex = (currentTrackIndex + 1) % trackList.count
        loadAudioFile(trackName: trackList[currentTrackIndex])
        if isPlaying {
            audioPlayer?.play()
        }
    }
    func skipToPriviasTrack() {
        currentTrackIndex = (currentTrackIndex - 1) % trackList.count
        loadAudioFile(trackName: trackList[currentTrackIndex])
        if isPlaying {
            audioPlayer?.play()
        }
    }
    
    func setVolume(_ value: Float) {
        audioPlayer?.volume = value
    }
    
    func setMute(_ isMuted: Bool) {
        audioPlayer?.volume = isMuted ? 0 : 1
    }
    
    func getCurrentTrackName() -> String {
        return trackList[currentTrackIndex]
    }
}
