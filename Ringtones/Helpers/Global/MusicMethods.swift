//
//  MusicMethods.swift
//  Music
//
//  Created by PAC on 9/27/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import Foundation
import UIKit

class MusicMethods {
    
    static func getSongs() -> [SongItem] {
        var songs = [SongItem]()
        
        for i in 0..<SongArrays.songDetailTitles.count {
            
            let songAudioFile = Bundle.main.path(forResource: SongArrays.songAudioFileNames[i], ofType: ".mp3") ?? ""
            
            let songItem = SongItem(
                songImage: SongArrays.songImageNames[i],
                songImageHigh: SongArrays.songImageHighNames[i],
                songTitle: SongArrays.songTitles[i],
                songDetailTitle: SongArrays.songDetailTitles[i],
                songItunesUrl: SongArrays.songItunsUrls[i],
                songAudioFile: songAudioFile)
            
            songs.append(songItem)
            
        }
        
        return songs
    }
    
    static func goingBrowser(urlString: String) {
        let destinationUrl = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(destinationUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(destinationUrl)
        }
    }

    
}
