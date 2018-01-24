//
//  StyleGuideManager.swift
//  SpaceIn
//
//  Created by Richard Velazquez on 12/8/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import Foundation
import UIKit


public class StyleGuideManager {
    private init(){}
    
    static let sharedInstance : StyleGuideManager = {
        let instance = StyleGuideManager()
        return instance
    }()
    
    //intro
    static let introBackgroundColor = UIColor.white
    static let introBackgroundRedColor = UIColor(r: 0, g: 204, b: 253)
    
    //Login/Sign
    static let loginBackgroundColor = UIColor.white
    static let loginBackgroundRedColor = UIColor(r: 248, g: 41, b: 80)
    
    //text field
    static let textFieldPlaceHolderColor = UIColor.lightGray
    static let textFieldBorderColor = UIColor.black
    
    //get button tint color
    static let buttonTintColor = UIColor(r: 0, g: 128, b: 255)
    
    //player button tint color
    static let playerButtonBlackColor = UIColor.black
    
    //get sign button color
    static let signButtonBackgroundColor = UIColor(r: 0, g: 128, b: 255)
    static let signButtonTintColor = UIColor.white
    
    //label color
    static let lableTextColor = UIColor.black
    
    //Fonts
    func loginFontLarge() -> UIFont {
        return UIFont(name: "Helvetica Light", size: 30)!

    }
}


