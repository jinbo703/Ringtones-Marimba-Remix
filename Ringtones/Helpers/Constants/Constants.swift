//
//  Constants.swift
//  SpaceIn
//
//  Created by Richard Velazquez on 12/19/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import Foundation
import UIKit

let DEVICE_WIDTH = UIScreen.main.bounds.size.width
let DEVICE_HEIGHT = UIScreen.main.bounds.size.height


extension Notification.Name {
    
    static let SetupOneSignal = Notification.Name("setup-onesignal")
}


enum SpaceinCopy: String {
    case forgotPasswordTitle = "Trouble logging in?"
    case forgotPasswordSubtitle = "Enter your email and we'll send you a link to get back into your account."
    case forgotPasswordPageButtonCopy = "Send login link"
    case spaceInFloatingLabelText = "Spacein"
    case locationPermissionViewBottomText = "Please give us access to your location so that you can enjoy more of our features"
    
}

enum RingtoneString: String {
    case whereMyRingtoneQuestion = "Where Are My Ringtones?"
    case whereMyRingtoneAnswer = "You can find your downloaded ringtones by going to Settings > Sounds > Ringtone."
    case downloadRingtoneQuestion = "How To Download A Ringtone"
    case downloadRingtoneAnswer = "Begin by selecting your favorite tone from our library. After previewing the ringtone, press \"Get\" to be redirected to the iTunes Store. From there you can set the ringtone as your default, or for a special contact"
}

enum UserDefaultKeys : String {
    case hasSeenTutorial = "Has seen tutorial" // we can never change this
    case lastKnownSpaceInLattitude = "lastKnownLattitude" // we can never change this
    case lastKnownSpaceInLongitude = "lastKnownLongitude" // we can never change this
    case hasSeenMapBefore = "hasSeenMapBefore" // we can never change this
}



