//
//  TutorialController.swift
//  Music
//
//  Created by PAC on 10/4/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit
import NDParallaxIntroView

protocol TutorialDelegate {
    func tutorialFinished(tutorialVC: TutorialController)
}

class TutorialController: UIViewController {
    
    var delegate: TutorialDelegate?
    
    var introView = NDIntroView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.setupIntroView()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

//MARK: setup NDintroview

extension TutorialController: NDIntroViewDelegate {
    fileprivate func setupIntroView() {
        
        let pageContents = [[kNDIntroPageTitle: "", kNDIntroPageDescription: "", kNDIntroPageImageName: AssetName.page1.rawValue], [kNDIntroPageTitle: "", kNDIntroPageDescription: "", kNDIntroPageImageName: AssetName.page2.rawValue], [kNDIntroPageTitle: "", kNDIntroPageDescription: "", kNDIntroPageImageName: AssetName.page3.rawValue], [kNDIntroPageTitle: "", kNDIntroPageDescription: "", kNDIntroPageImageName: AssetName.page4.rawValue]]
        self.introView = NDIntroView(frame: self.view.frame, parallaxImage: UIImage(named: ""), andData: pageContents)
        self.introView.delegate = self
        
        self.view.addSubview(introView)
        
    }
    
    func launchAppButtonPressed() {
        
        
        delegate?.tutorialFinished(tutorialVC: self)
        NotificationCenter.default.post(name: .SetupOneSignal, object: nil)
    }
}
