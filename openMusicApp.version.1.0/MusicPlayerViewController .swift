/*import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    private let playPauseButton = UIButton()
    private let repeatButton = UIButton()
    private let skipButton = UIButton()
    private let backButton = UIButton()
    private let tabBar = UIView()
    private let navigationBar = UINavigationBar()
    private let volumeSlider = UISlider()
    private let muteSwitch = UISwitch()
    private var isPlaying = false
    private var isRepeatOn = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupNavigationBar()
        setupUI()
        AudioPlayerManager.shared.loadAudioFile(trackName: "Boombox-Полина")
    }
    
    private func setupNavigationBar() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.isTranslucent = false
        
        let navItem = UINavigationItem(title: "Music Player")
        
        // Add mute switch to left side
        let muteSwitchItem = UIBarButtonItem(customView: muteSwitch)
        navItem.leftBarButtonItem = muteSwitchItem
        muteSwitch.onTintColor = UIColor.purple
        muteSwitch.addTarget(self, action: #selector(muteSwitchToggled(_:)), for: .valueChanged)
        
        // Add song list button to right side
        let songListButton = UIBarButtonItem(image: UIImage(systemName: "music.note.list"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(showSongList))
        songListButton.tintColor = UIColor.purple
        navItem.rightBarButtonItem = songListButton
        
        navigationBar.items = [navItem]
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupUI() {
        setupTabBar()
        setupVolumeSlider()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = UIColor.black
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        setupPlayPauseButton()
        setupRepeatButton()
        setupSkipButton()
        setupBackButton()
    }
    
    private func setupPlayPauseButton() {
        playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playPauseButton.tintColor = UIColor.purple
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(playPauseButton)
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 40),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupRepeatButton() {
        repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        repeatButton.tintColor = UIColor.purple
        repeatButton.addTarget(self, action: #selector(repeatTapped), for: .touchUpInside)
        
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            repeatButton.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 20),
            repeatButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            repeatButton.widthAnchor.constraint(equalToConstant: 30),
            repeatButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSkipButton() {
        skipButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        skipButton.tintColor = UIColor.purple
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -20),
            skipButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 30),
            skipButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        backButton.tintColor = UIColor.purple
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 60),
            backButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupVolumeSlider() {
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.value = 0.5
        volumeSlider.tintColor = UIColor.purple
        volumeSlider.addTarget(self, action: #selector(volumeChanged(_:)), for: .valueChanged)
        
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
        
        NSLayoutConstraint.activate([
            volumeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            volumeSlider.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20)
        ])
    }
    
    @objc private func playPauseTapped() {
        AudioPlayerManager.shared.togglePlayPause()
        let playImage = AudioPlayerManager.shared.isPlaying ? "pause.circle" : "play.circle"
        playPauseButton.setImage(UIImage(systemName: playImage), for: .normal)
    }
    
    @objc private func repeatTapped() {
        isRepeatOn.toggle()
        let repeatImage = isRepeatOn ? "repeat.1" : "repeat"
        repeatButton.setImage(UIImage(systemName: repeatImage), for: .normal)
    }
    
    @objc private func skipTapped() {
        AudioPlayerManager.shared.skipToNextTrack()
    }
    @objc private func backTapped() {
        AudioPlayerManager.shared.skipToPriviasTrack()
    }
    
    @objc private func volumeChanged(_ sender: UISlider) {
        AudioPlayerManager.shared.setVolume(sender.value)
    }
    
    @objc private func muteSwitchToggled(_ sender: UISwitch) {
        AudioPlayerManager.shared.setMute(sender.isOn)
    }
    
    @objc private func showSongList() {
        
        
    }
}


*/
import UIKit
import AVFoundation

  class MusicPlayerViewController: UIViewController {
    private let playPauseButton = UIButton()
    private let repeatButton = UIButton()
    private let skipButton = UIButton()
    private let backButton = UIButton()
    private let tabBar = UIView()
    private let navigationBar = UINavigationBar()
    private let volumeSlider = UISlider()
    private let muteSwitch = UISwitch()
    private var albumImageView = UIImageView()
    private var isRepeatOn = false

    private let songImages: [String: String] = [
        "Boombox-Полина": "1",
        "bumboks_-_hottabych": "2",
        "bumboks_-_vahteram": "3",
        "Volodymyr Dantes - Оля": "4"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupNavigationBar()
        setupUI()
        setupAlbumImageView()
       
    }

    private func setupNavigationBar() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.isTranslucent = false
        
        let navItem = UINavigationItem(title: "Music Player")
        let muteSwitchItem = UIBarButtonItem(customView: muteSwitch)
        navItem.leftBarButtonItem = muteSwitchItem
        muteSwitch.onTintColor = UIColor.purple
        muteSwitch.addTarget(self, action: #selector(muteSwitchToggled(_:)), for: .valueChanged)
        
        let songListButton = UIBarButtonItem(image: UIImage(systemName: "music.note.list"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(showSongList))
        songListButton.tintColor = UIColor.purple
        navItem.rightBarButtonItem = songListButton
        
        navigationBar.items = [navItem]
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupUI() {
        setupTabBar()
        setupVolumeSlider()
    }

    private func setupTabBar() {
        tabBar.backgroundColor = UIColor.black
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        setupPlayPauseButton()
        setupRepeatButton()
        setupSkipButton()
        setupBackButton()
    }

    private func setupPlayPauseButton() {
        playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playPauseButton.tintColor = UIColor.purple
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(playPauseButton)
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 40),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupRepeatButton() {
        repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        repeatButton.tintColor = UIColor.purple
        repeatButton.addTarget(self, action: #selector(repeatTapped), for: .touchUpInside)
        
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(repeatButton)
        
        NSLayoutConstraint.activate([
            repeatButton.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 20),
            repeatButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            repeatButton.widthAnchor.constraint(equalToConstant: 30),
            repeatButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupSkipButton() {
        skipButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        skipButton.tintColor = UIColor.purple
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -20),
            skipButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 30),
            skipButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        backButton.tintColor = UIColor.purple
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: repeatButton.trailingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupVolumeSlider() {
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.value = 0.5
        volumeSlider.tintColor = UIColor.purple
        volumeSlider.addTarget(self, action: #selector(volumeChanged(_:)), for: .valueChanged)
        
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
        
        NSLayoutConstraint.activate([
            volumeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            volumeSlider.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20)
        ])
    }

    private func setupAlbumImageView() {
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.image = UIImage(named: "defaultAlbumArt")
        
        view.addSubview(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            albumImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }

   

    @objc private func playPauseTapped() {
        AudioPlayerManager.shared.togglePlayPause()
        let playImage = AudioPlayerManager.shared.isPlaying ? "pause.circle" : "play.circle"
        playPauseButton.setImage(UIImage(systemName: playImage), for: .normal)
        updateAlbumImage(trackName: AudioPlayerManager.shared.getCurrentTrackName())
    }

    @objc private func repeatTapped() {
        isRepeatOn.toggle()
        let repeatImage = isRepeatOn ? "repeat.1" : "repeat"
        repeatButton.setImage(UIImage(systemName: repeatImage), for: .normal)
    }

    @objc private func skipTapped() {
        AudioPlayerManager.shared.skipToNextTrack()
        updateAlbumImage(trackName: AudioPlayerManager.shared.getCurrentTrackName())
    }

    @objc private func backTapped() {
        AudioPlayerManager.shared.skipToPriviasTrack()
        updateAlbumImage(trackName: AudioPlayerManager.shared.getCurrentTrackName())
    }

    @objc private func volumeChanged(_ sender: UISlider) {
        AudioPlayerManager.shared.setVolume(sender.value)
    }

    @objc private func muteSwitchToggled(_ sender: UISwitch) {
        AudioPlayerManager.shared.setMute(sender.isOn)
    }

    private func updateAlbumImage(trackName: String) {
        if let imageName = songImages[trackName] {
            albumImageView.image = UIImage(named: imageName)
        } else {
            albumImageView.image = UIImage(named: "defaultAlbumArt")
        }
    }

    @objc  func showSongList() {
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    }


