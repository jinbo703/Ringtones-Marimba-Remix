
//
//  SongPlayController.swift
//  Music
//
//  Created by PAC on 9/28/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

class SongPlayController: UIViewController {
    
    var songs: [SongItem]?
    var currentSongIndex = 0
    
    var song: SongItem? {
        
        didSet {
            
            if previous == nil || song?.songImage != previous?.songImage {
                
                if let song = song {
                    
                    self.songImageView.image = UIImage(named: song.songImageHigh)
//                    self.songTitle.text = song.songTitle
//                    self.songDetailTitle.text = song.songDetailTitle
                    
                    if let url = URL(string: song.songAudioFile) {
                        audioPlayer.initPlayer(url: url, sontTitle: song.songTitle, songDetailTitle: song.songDetailTitle, isLocal: "Yes")
                        audioPlayer.playAudioPlayer()
                    } else {
                        audioPlayer.isHidden = true
                    }
                    
                }
                
                previous = song
            }
            
        }
        
    }
    
    var previous: SongItem? = nil
    
    let audioPlayer: AudioPlayer = {
        
        let audioPlayer = AudioPlayer()
        audioPlayer.translatesAutoresizingMaskIntoConstraints = false
        
        return audioPlayer
        
    }()
    
    let songImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: AssetName.attentionapp.rawValue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.text = "Song"
        label.textColor = StyleGuideManager.lableTextColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightHeavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songDetailTitle: UILabel = {
        let label = UILabel()
        label.text = "Song"
        label.textColor = StyleGuideManager.lableTextColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var skipBackButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: AssetName.skipBack.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = StyleGuideManager.playerButtonBlackColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSkipBack), for: .touchUpInside)
        return button
    }()
    
    lazy var skipForwardButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: AssetName.skipForward.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = StyleGuideManager.playerButtonBlackColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSkipForward), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupViews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.pauseAudioPlayer()
    }

}

//MARK: handle get song
extension SongPlayController {
    @objc fileprivate func handleGetSong() {
        if let url = self.song?.songItunesUrl {
            MusicMethods.goingBrowser(urlString: url)
        }
    }
}

//MARK: handle skip back/forward
extension SongPlayController: AudioPlayerDelegate {
    
    @objc fileprivate func handleSkipForward() {
        audioPlayer.pauseAudioPlayer()
        currentSongIndex += 1
        if currentSongIndex == (songs?.count)! {
            currentSongIndex = 0
        }
        self.song = songs?[currentSongIndex]
        
    }
    
    @objc fileprivate func handleSkipBack() {
        audioPlayer.pauseAudioPlayer()
        currentSongIndex -= 1
        if currentSongIndex == -1 {
            currentSongIndex = (songs?.count)! - 1
        }
        self.song = songs?[currentSongIndex]
    }
    
    func audioPlayerDidFinish() {
        
        print("playfinished in songplaycontroller")
        self.handleSkipForward()
        
    }
    
    func didClickSkipForward() {
        self.handleSkipForward()
    }
    
    func didClickSkipBackward() {
        self.handleSkipBack()
    }
    
}


//MARK: handle dismiss controller 
extension SongPlayController {
    
    @objc fileprivate func handleDismissController() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: handle setup views
extension SongPlayController {
    
    fileprivate func setupViews() {
        self.setupBackground()
        self.setupNavBar()
        self.setupImageView()
        self.setupAudioPlayer()
        self.setupLabels()
        self.setupButtons()
    }
    
    private func setupButtons() {
//        audioPlayer.addSubview(skipBackButton)
//        audioPlayer.addSubview(skipForwardButton)
//        
//        skipForwardButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        skipForwardButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        skipForwardButton.rightAnchor.constraint(equalTo: audioPlayer.rightAnchor, constant: -80).isActive = true
//        skipForwardButton.topAnchor.constraint(equalTo: audioPlayer.topAnchor, constant: 0).isActive = true
//        
//        skipBackButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        skipBackButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        skipBackButton.leftAnchor.constraint(equalTo: audioPlayer.leftAnchor, constant: 80).isActive = true
//        skipBackButton.topAnchor.constraint(equalTo: audioPlayer.topAnchor, constant: 0).isActive = true
    }
    
    private func setupLabels() {
//        view.addSubview(songTitle)
//        view.addSubview(songDetailTitle)
//        
//        songTitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        songTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        songTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        songTitle.topAnchor.constraint(equalTo: audioPlayer.bottomAnchor, constant: 0).isActive = true
//        
//        songDetailTitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        songDetailTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        songDetailTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        songDetailTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupAudioPlayer() {
        audioPlayer.delegate = self
        view.addSubview(audioPlayer)
        
        audioPlayer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        audioPlayer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        audioPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        audioPlayer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audioPlayer.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 0).isActive = true
        
        print("height", audioPlayer.frame.size.height)
    }
    
    private func setupImageView() {
        view.addSubview(songImageView)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            songImageView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
            songImageView.heightAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
        } else if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            songImageView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
            songImageView.heightAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
        }
        
        
        songImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        songImageView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupBackground() {
        
        view.backgroundColor = StyleGuideManager.loginBackgroundColor
        
    }
    
    private func setupNavBar() {
        
        let backImage = UIImage(named: AssetName.backIcon.rawValue)
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(handleDismissController))
        backButton.tintColor = StyleGuideManager.buttonTintColor
        
        navigationItem.leftBarButtonItem = backButton
        
        
        let getButton = UIButton(type: .system)
        getButton.setTitle("Get", for: .normal)
        getButton.setTitleColor(StyleGuideManager.buttonTintColor, for: .normal)
        getButton.layer.cornerRadius = 5
        getButton.layer.borderWidth = 2
        getButton.layer.borderColor = StyleGuideManager.buttonTintColor.cgColor
        getButton.layer.masksToBounds = true
        getButton.addTarget(self, action: #selector(handleGetSong), for: .touchUpInside)
        getButton.frame = CGRect(x: 0, y: 0, width: 45, height: 20)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: getButton)
    }
    
    
    
}
