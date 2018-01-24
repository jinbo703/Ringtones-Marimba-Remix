//
//  InfoController.swift
//  Music
//
//  Created by PAC on 9/30/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    
    let whereLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = RingtoneString.whereMyRingtoneQuestion.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = RingtoneString.downloadRingtoneQuestion.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let whereTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.text = RingtoneString.whereMyRingtoneAnswer.rawValue
//        textView.backgroundColor = .red
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.sizeToFit()
        return textView
    }()
    
    let downloadTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
//        textView.backgroundColor = .red
        textView.text = RingtoneString.downloadRingtoneAnswer.rawValue
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.sizeToFit()
        return textView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: handle dismiss controller
extension InfoController {
    
    @objc fileprivate func handleDismissController() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: setup views
extension InfoController {
    fileprivate func setupViews() {
        self.setupNavBar()
        self.setupLabels()
    }
    
    private func setupLabels() {
        view.addSubview(whereLabel)
        view.addSubview(whereTextView)
        view.addSubview(downloadLabel)
        view.addSubview(downloadTextView)
        
        whereLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whereLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        
        whereTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whereTextView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        whereTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        whereTextView.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 30).isActive = true
        
        downloadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadLabel.topAnchor.constraint(equalTo: whereTextView.bottomAnchor, constant: 40).isActive = true
    
        downloadTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadTextView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        downloadTextView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        downloadTextView.topAnchor.constraint(equalTo: downloadLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    private func setupNavBar() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Info"
        
        let backImage = UIImage(named: AssetName.backIcon.rawValue)
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(handleDismissController))
        backButton.tintColor = StyleGuideManager.buttonTintColor
        
        navigationItem.leftBarButtonItem = backButton
    }
}
