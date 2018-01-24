//
//  ChartNamesCell.swift
//  CT
//
//  Created by PAC on 8/23/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    var song: SongItem? {
        
        didSet {
            
            if let songImage = song?.songImage {
                self.songImageView.image = UIImage(named: songImage)
            }
            
            self.textLabel?.text = song?.songTitle
            self.detailTextLabel?.text = song?.songDetailTitle
            
        }
        
    }
    
    let statusImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: AssetName.statusIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = StyleGuideManager.buttonTintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let songImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: AssetName.attentionapp.rawValue)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    lazy var getSongButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(StyleGuideManager.buttonTintColor, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = StyleGuideManager.buttonTintColor.cgColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleGetSong), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleGetSong() {
        if let url = self.song?.songItunesUrl {
            MusicMethods.goingBrowser(urlString: url)
        }
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 70, y: textLabel!.frame.origin.y - 2, width: DEVICE_WIDTH - 118, height: (textLabel?.frame.height)!)
        
        detailTextLabel?.frame = CGRect(x: 70, y: detailTextLabel!.frame.origin.y + 2, width: DEVICE_WIDTH - 118, height: detailTextLabel!.frame.height)

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(statusImageView)
        addSubview(songImageView)
        addSubview(getSongButton)
        
        statusImageView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        statusImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        
        songImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        songImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        songImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        songImageView.leftAnchor.constraint(equalTo: statusImageView.rightAnchor, constant: 5).isActive = true
        
        getSongButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        getSongButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        getSongButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        getSongButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
