//
//  AudioPlayer.swift
//  RME
//
//  Created by Hunain Shahid on 18/06/2017.
//  Copyright © 2017 Brainx Technologies. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

protocol AudioPlayerDelegate: class {
    
    func audioPlayerDidFinish()
    func didClickSkipForward()
    func didClickSkipBackward()
    
}

class AudioPlayer: UIView {
    
    let AudioHeight = DEVICE_HEIGHT - DEVICE_WIDTH - 70
    
    var delegate: AudioPlayerDelegate!
    
    fileprivate var constraintsAdded = false
    fileprivate var audioPlayer: AVAudioPlayer?
    fileprivate var isPlaying = false
    fileprivate var isScrubing = false
    fileprivate var timer = Timer()
    fileprivate var thumbTimer = Timer()
    
    var playPauseButton = UIButton()
    var skipForwardButton = UIButton()
    var skipBackwardButton = UIButton()
    var seekSlider = UISlider()
    var volumeSlider = UISlider()
    var startTime = UILabel()
    var endTime = UILabel()
    var songTitle = UILabel()
    var songDetailTitle = UILabel()
    var indicator = UIActivityIndicatorView()
    var muteImageView = UIImageView()
    var speakerImageView = UIImageView()
    
    var mpVolumeView = MPVolumeView()
    
    var playImage: UIImage?
    var pauseImage: UIImage?
    var sliderThumb: UIImage?
    var skipForward: UIImage?
    var skipBackward: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        playImage = UIImage(named: AssetName.playIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        pauseImage = UIImage(named: AssetName.pauseIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        sliderThumb = UIImage(named: AssetName.thumbIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        skipForward = UIImage(named: AssetName.skipForward.rawValue)?.withRenderingMode(.alwaysTemplate)
        skipBackward = UIImage(named: AssetName.skipBack.rawValue)?.withRenderingMode(.alwaysTemplate)
        let muteImage = UIImage(named: AssetName.muteIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        let speakerImage = UIImage(named: AssetName.speakerIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        
        self.backgroundColor = UIColor.clear
        
        playPauseButton.setImage(playImage, for: .normal)
        playPauseButton.tintColor = .black
        playPauseButton.setTitle("", for: .normal)
        playPauseButton.isHidden = true
        playPauseButton.addTarget(self, action: #selector(playPauseAction(_:)), for: .touchUpInside)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        skipForwardButton.setImage(skipForward, for: .normal)
        skipForwardButton.tintColor = .black
        skipForwardButton.setTitle("", for: .normal)
        skipForwardButton.addTarget(self, action: #selector(didClickSkipForward), for: .touchUpInside)
        skipForwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        skipBackwardButton.setImage(skipBackward, for: .normal)
        skipBackwardButton.tintColor = .black
        skipBackwardButton.setTitle("", for: .normal)
        skipBackwardButton.addTarget(self, action: #selector(didClickSkipBackward), for: .touchUpInside)
        skipBackwardButton.translatesAutoresizingMaskIntoConstraints = false

        startTime.text = "00:00"
        startTime.textAlignment = .left
        startTime.textColor = UIColor.black
        startTime.font = UIFont.systemFont(ofSize: 13)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.sizeToFit()
        
        endTime.text = "00:00"
        endTime.textAlignment = .left
        endTime.textColor = UIColor.black
        endTime.font = UIFont.systemFont(ofSize: 13)
        endTime.sizeToFit()
        endTime.translatesAutoresizingMaskIntoConstraints = false
        
        seekSlider.maximumValue = 100
        seekSlider.minimumValue = 0
        seekSlider.value = 0
        seekSlider.tintColor = StyleGuideManager.buttonTintColor
        seekSlider.isEnabled = false
//        seekSlider.setThumbImage(sliderThumb, for: .normal)
        seekSlider.addTarget(self, action: #selector(userIsScrubbing(_:)), for: .touchDragInside)
        seekSlider.addTarget(self, action: #selector(seekBarValueChanged(_:)), for: .touchUpInside)
        seekSlider.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        indicator.startAnimating()
        
        songTitle.text = "Song"
        songTitle.textColor = StyleGuideManager.lableTextColor
        songTitle.textAlignment = .center
        songTitle.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightHeavy)
        songTitle.sizeToFit()
        songTitle.translatesAutoresizingMaskIntoConstraints = false
        
        songDetailTitle.text = "Song"
        songDetailTitle.textColor = StyleGuideManager.lableTextColor
        songDetailTitle.textAlignment = .center
        songDetailTitle.font = UIFont.systemFont(ofSize: 16)
        songDetailTitle.sizeToFit()
        songDetailTitle.translatesAutoresizingMaskIntoConstraints = false
        
//        volumeSlider.maximumValue = 1
//        volumeSlider.minimumValue = 0
//        volumeSlider.value = 0.5
//        volumeSlider.tintColor = StyleGuideManager.buttonTintColor
//        volumeSlider.isEnabled = true
//        volumeSlider.setThumbImage(sliderThumb, for: .normal)
//        volumeSlider.addTarget(self, action: #selector(volumeSliderValueChanged(sender:)), for: .valueChanged)
//        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
//        volumeSlider = mpVolumeView.subviews.first as! UISlider
//        volumeSlider.maximumValue = 1
//        volumeSlider.minimumValue = 0
//        volumeSlider.value = 0.5
//        volumeSlider.tintColor = StyleGuideManager.buttonTintColor
//        volumeSlider.isEnabled = true
//        volumeSlider.setThumbImage(sliderThumb, for: .normal)
//        volumeSlider.addTarget(self, action: #selector(volumeSliderValueChanged(sender:)), for: .valueChanged)
//        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        mpVolumeView.translatesAutoresizingMaskIntoConstraints = false
        if let view = mpVolumeView.subviews.first as? UISlider {
            view.value = 0.5
            view.tintColor = StyleGuideManager.buttonTintColor
        }
        mpVolumeView.showsRouteButton = false
        
        
        muteImageView.image = muteImage
        muteImageView.tintColor = .lightGray
        muteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        speakerImageView.image = speakerImage
        speakerImageView.tintColor = .lightGray
        speakerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(playPauseButton)
        addSubview(skipForwardButton)
        addSubview(skipBackwardButton)
        addSubview(startTime)
        addSubview(endTime)
        addSubview(seekSlider)
        addSubview(indicator)
        addSubview(songTitle)
        addSubview(songDetailTitle)
//        addSubview(volumeSlider)
        addSubview(mpVolumeView)
        addSubview(muteImageView)
        mpVolumeView.addSubview(speakerImageView)
        
        
        self.setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        
        print("audioHeight", AudioHeight)
        
        seekSlider.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.7).isActive = true
        seekSlider.topAnchor.constraint(equalTo: topAnchor, constant: AudioHeight * 0.08).isActive = true
        seekSlider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        startTime.centerYAnchor.constraint(equalTo: seekSlider.centerYAnchor).isActive = true
        startTime.rightAnchor.constraint(equalTo: seekSlider.leftAnchor, constant: -8).isActive = true
        
        endTime.centerYAnchor.constraint(equalTo: seekSlider.centerYAnchor).isActive = true
        endTime.leftAnchor.constraint(equalTo: seekSlider.rightAnchor, constant: 8).isActive = true
        
        songTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        songTitle.topAnchor.constraint(equalTo: seekSlider.bottomAnchor, constant: AudioHeight * 0.068).isActive = true
        
        songDetailTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        songDetailTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: AudioHeight * 0.04).isActive = true
        
        playPauseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.topAnchor.constraint(equalTo: songDetailTitle.bottomAnchor, constant: AudioHeight * 0.068).isActive = true
        
        skipBackwardButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        skipBackwardButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        skipBackwardButton.rightAnchor.constraint(equalTo: playPauseButton.leftAnchor, constant: -100).isActive = true
        skipBackwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        
        skipForwardButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        skipForwardButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        skipForwardButton.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: 100).isActive = true
        skipForwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        
        mpVolumeView.leftAnchor.constraint(equalTo: seekSlider.leftAnchor).isActive = true
        mpVolumeView.rightAnchor.constraint(equalTo: seekSlider.rightAnchor, constant: 0).isActive = true
        mpVolumeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        mpVolumeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        muteImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        muteImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        muteImageView.centerYAnchor.constraint(equalTo: mpVolumeView.centerYAnchor, constant: -6).isActive = true
        muteImageView.centerXAnchor.constraint(equalTo: startTime.centerXAnchor, constant: 0).isActive = true
        
        speakerImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        speakerImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        speakerImageView.centerYAnchor.constraint(equalTo: mpVolumeView.centerYAnchor, constant: -7).isActive = true
        speakerImageView.centerXAnchor.constraint(equalTo: endTime.centerXAnchor, constant: 0).isActive = true
        
    }
    
//    override func updateConstraints() {
//        if !constraintsAdded {
//            constraintsAdded = true
//            
//            playPauseButton.autoSetDimensions(to: CGSize(width: 40, height: 40))
//            playPauseButton.autoPinEdge(toSuperviewEdge: .leading)
//            playPauseButton.autoAlignAxis(toSuperviewAxis: .horizontal)
//            
//            indicator.autoPinEdge(.leading, to: .leading, of: playPauseButton)
//            indicator.autoPinEdge(.trailing, to: .trailing, of: playPauseButton)
//            indicator.autoPinEdge(.top, to: .top, of: playPauseButton)
//            indicator.autoPinEdge(.bottom, to: .bottom, of: playPauseButton)
//            
//            startTime.autoAlignAxis(toSuperviewAxis: .horizontal)
//            startTime.autoPinEdge(.leading, to: .trailing, of: playPauseButton)
//            
//            endTime.autoAlignAxis(toSuperviewAxis: .horizontal)
//            endTime.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
//            
//            seekSlider.autoPinEdge(.leading, to: .trailing, of: startTime, withOffset: 8)
//            seekSlider.autoPinEdge(.trailing, to: .leading, of: endTime, withOffset: -8)
//            seekSlider.autoAlignAxis(toSuperviewAxis: .horizontal)
//        }
//        super.updateConstraints()
//    }
    
    // MARK: Actions
    func playPauseAction(_ sender: UIButton) {
        timer.invalidate()
        thumbTimer.invalidate()
        if isPlaying {
            audioPlayer?.pause()
            playPauseButton.setImage(playImage, for: .normal)
            isPlaying = false
        }
        else {
            audioPlayer?.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            thumbTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateTimerForThumb), userInfo: nil, repeats: true)
            playPauseButton.setImage(pauseImage, for: .normal)
            isPlaying = true
        }
    }
    
    func didClickSkipForward() {
        delegate.didClickSkipForward()
    }
    
    func didClickSkipBackward() {
        delegate.didClickSkipBackward()
    }
    
    func seekBarValueChanged(_ sender: UISlider) {
        
        if sender == seekSlider {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            thumbTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateTimerForThumb), userInfo: nil, repeats: true)
            audioPlayer?.currentTime = TimeInterval(sender.value)
            isScrubing = false
            if isPlaying {
                audioPlayer?.play()
            }
        } else if sender == volumeSlider {
            
//            audioPlayer?.volume = sender.value
        }
        
        
    }
    
    func userIsScrubbing(_ sender: UISlider) {
        
        if sender == seekSlider {
            timer.invalidate()
            thumbTimer.invalidate()
            startTime.text = timeFormat(sender.value)
            isScrubing = true
            audioPlayer?.pause()
        } else if sender == volumeSlider {
            
//            audioPlayer?.volume = sender.value
            
        }
        
        
    }
    
    func volumeSliderValueChanged(sender: UISlider) {
        
        if sender == volumeSlider {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch let error {
                print(error)
            }
            audioPlayer?.volume = sender.value
        }
        
    }
    
    func updateTimer() {
        if let audioPlayer = audioPlayer {
//            if !isScrubing {
//                seekSlider.value = Float(audioPlayer.currentTime)
//            }
            startTime.text = timeFormat(Float(audioPlayer.currentTime))
            endTime.text = timeFormat(Float(audioPlayer.duration))
        }
    }
    
    func updateTimerForThumb() {
        if let audioPlayer = audioPlayer {
            if !isScrubing {
                seekSlider.value = Float(audioPlayer.currentTime)
            }
//            startTime.text = timeFormat(Float(audioPlayer.currentTime))
//            endTime.text = timeFormat(Float(audioPlayer.duration))
        }
    }
    
    // MARK: Public Method
    func initPlayer(url audio: URL, sontTitle: String, songDetailTitle: String, isLocal: String) -> Void {
        
        if isLocal == "Yes" {
            do {
                
                
                try self.audioPlayer = AVAudioPlayer(contentsOf: audio)
                audioPlayer?.delegate = self
//                audioPlayer?.volume = volumeSlider.value
                self.songTitle.text = sontTitle
                self.songDetailTitle.text = songDetailTitle
                self.setupView()
                
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch let error {
                    print(error)
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.playPauseButton.isHidden = false
                    print ("Exception occured in loading")
                }
            }
        } else {
            let downloadTask = URLSession.shared.downloadTask(with: audio, completionHandler: { (url, response, error)  in
                if error == nil {
                    do {
                        try self.audioPlayer = AVAudioPlayer(contentsOf: url!)
                        self.setupView()
                    }
                    catch {
                        DispatchQueue.main.async {
                            self.indicator.stopAnimating()
                            self.playPauseButton.isHidden = false
                            print ("Exception occured in loading")
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.playPauseButton.isHidden = false
                        print ("Exception occured in loading")
                    }
                }
                
            })
            downloadTask.resume()
        }
        
        
        
        
        
    }
    
    
    
    func pauseAudioPlayer() -> Void {
        if isPlaying {
            timer.invalidate()
            thumbTimer.invalidate()
            audioPlayer?.pause()
            playPauseButton.setImage(playImage, for: .normal)
            isPlaying = false
        }
    }
    
    func playAudioPlayer() -> Void {
        
        if !isPlaying {
            timer.invalidate()
            thumbTimer.invalidate()
            audioPlayer?.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            thumbTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateTimerForThumb), userInfo: nil, repeats: true)
            playPauseButton.setImage(pauseImage, for: .normal)
            isPlaying = true
            
            
//            self.setMPVolumeView()
        }
        
    }
    
    private func setMPVolumeView() {
        let wrapperView = UIView(frame: CGRect(x: DEVICE_WIDTH * 0.15, y: AudioHeight - (AudioHeight * 0.04) - 50, width: DEVICE_WIDTH * 0.7, height: 50))
        wrapperView.backgroundColor = .clear
        addSubview(wrapperView)
        
        let mpVolumeView = MPVolumeView(frame: wrapperView.bounds)
//        if let view = mpVolumeView.subviews.first as? UISlider {
//            wrapperView.addSubview(view)
//            view.value = 0.5
//        }
        wrapperView.addSubview(mpVolumeView)
        
        
    }
    
    // MARK: Private Methods
    fileprivate func setupView() -> Void {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.playPauseButton.isHidden = false
            self.seekSlider.isEnabled = true
        }
        
        startTime.text = "00:00"
        if let audioPlayer = audioPlayer {
            endTime.text = timeFormat(Float(audioPlayer.duration))
            seekSlider.maximumValue = Float(audioPlayer.duration)
        }
    }
    
    fileprivate func timeFormat(_ value: Float) -> String {
        let minutes = lroundf(value) / 60
        let seconds = lroundf(value) - lroundf(Float(minutes * 60))
        
        let roundedSeconds = lroundf(Float(seconds));
        let roundedMinutes = lroundf(Float(minutes));
        
        return String(format:"%02i:%02i", roundedMinutes, roundedSeconds)
    }
    
    
}

//MARK: audioPlayer delegate
extension AudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        print("finished audio player")
        delegate.audioPlayerDidFinish()
    }
    
    
}
