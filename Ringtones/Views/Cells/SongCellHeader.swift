//
//  HomeCellHeader.swift
//  LESSABOVE
//
//  Created by PAC on 9/8/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit
import ImageSlideshow

class SongCellHeader: UITableViewHeaderFooterView {
    
    var imageSlideShow: ImageSlideshow!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        
        setupViews()
    }
    
    private func setupViews() {
//        let frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: 300)
        imageSlideShow = ImageSlideshow(frame: self.frame)
        
        let localSource = [ImageSource(imageString: AssetName.popImage.rawValue)!, ImageSource(imageString: AssetName.danceImage.rawValue)!, ImageSource(imageString: AssetName.hiphopImage.rawValue)!, ImageSource(imageString: AssetName.rnbImage.rawValue)!]
        
        imageSlideShow.backgroundColor = UIColor.white
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.pageControlPosition = PageControlPosition.underScrollView
        imageSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        imageSlideShow.pageControl.pageIndicatorTintColor = UIColor.black
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageSlideShow.setImageInputs(localSource)
        
        addSubview(imageSlideShow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
