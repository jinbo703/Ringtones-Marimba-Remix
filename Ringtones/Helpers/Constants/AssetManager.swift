//
//  AssetManager.swift
//  SpaceIn
//
//  Created by Richard Velazquez on 12/8/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import Foundation
import UIKit

enum AssetName: String {
    case backIcon = "backicon"
    case settingIcon = "settings"
    case logoutIcon = "logout"
    case statusIcon = "statusIcon"
    case skipBack = "skip_back"
    case skipForward = "skip_forward"
    case playIcon = "i_play"
    case pauseIcon = "i_pause"
    case thumbIcon = "i_slider_thumb"
    case informationIcon = "information"
    case uploadIcon = "upload"
    case muteIcon = "mute"
    case speakerIcon = "speaker"
    
    //intor images
    case page1 = "page1"
    case page2 = "page2"
    case page3 = "page3"
    case page4 = "page4"
    
    //slide image
    case popImage = "pop"
    case hiphopImage = "hiphop"
    case rnbImage = "rnb"
    case danceImage = "dance"
    
    //song image
    case attentionapp = "attentionapp"
    case bankaccountapp = "bankaccountapp"
    case bodakapp = "bodakapp"
    case feelsapp = "feelsapp"
    case migentreapp = "migentreapp"
    case unforgettableapp = "unforgettableapp"
    case alone = "alone"
    case eyou = "eyou"
    case cheapthrills = "cheapthrills"
    case closer = "closer"
    case despacito = "despacito"
    case ispy = "ispy"
    case letmeloveyou = "letmeloveyou"
    case mip = "mip"
    case panda = "panda"
    case regae = "regae"
    case rockstar = "rockstar"
    case shapeofyou = "shapeofyou"
    case starboy = "starboy"
    case wedonttalkanymore = "wedonttalkanymore"
    
    
    case attentionappHigh = "attentionapp_high"
    case bankaccountappHigh = "bankaccountapp_high"
    case bodakappHigh = "bodakapp_high"
    case feelsappHigh = "feelsapp_high"
    case migentreappHigh = "migentreapp_high"
    case unforgettableappHigh = "unforgettableapp_high"
    case aloneHigh = "alone_high"
    case eyouHigh = "eyou_high"
    case cheapthrillsHigh = "cheapthrills_high"
    case closerHigh = "closer_high"
    case despacitoHigh = "despacito_high"
    case ispyHigh = "ispy_high"
    case letmeloveyouHigh = "letmeloveyou_high"
    case mipHigh = "mip_high"
    case pandaHigh = "panda_high"
    case regaeHigh = "regae_high"
    case rockstarHigh = "rockstar_high"
    case shapeofyouHigh = "shapeofyou_high"
    case starboyHigh = "starboy_high"
    case wedonttalkanymoreHigh = "wedonttalkanymore_high"
}

class AssetManager {
    static let sharedInstance = AssetManager()
    
    static var assetDict = [String : UIImage]()
    
    class func imageForAssetName(name: AssetName) -> UIImage {
        let image = assetDict[name.rawValue] ?? UIImage(named: name.rawValue)
        assetDict[name.rawValue] = image
        return image!
    }
    
}
