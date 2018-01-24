//
//  AudioItem.swift
//  RME
//
//  Created by Hunain Shahid on 14/06/2017.
//  Copyright © 2017 Brainx Technologies. All rights reserved.
//

import Foundation

class SongItem {
    var songImage: String
    var songImageHigh: String
    var songTitle: String
    var songDetailTitle: String
    var songItunesUrl: String
    var songAudioFile: String
    
    init(songImage: String, songImageHigh: String, songTitle: String, songDetailTitle: String, songItunesUrl: String, songAudioFile: String) {
        self.songImage = songImage
        self.songImageHigh = songImageHigh
        self.songTitle = songTitle
        self.songDetailTitle = songDetailTitle
        self.songItunesUrl = songItunesUrl
        self.songAudioFile = songAudioFile
    }
}
