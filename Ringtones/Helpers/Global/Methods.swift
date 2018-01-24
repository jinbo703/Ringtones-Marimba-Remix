//
//  Methods.swift
//  Music
//
//  Created by PAC on 9/26/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

//MARK: find top Controller
func findBestViewController(vc: UIViewController) -> UIViewController {
    
    if (vc.presentedViewController != nil) {
        return findBestViewController(vc: vc.presentedViewController!)
    } else if vc.isKind(of: UISplitViewController.self) {
        
        let svc = UISplitViewController()
        if svc.viewControllers.count > 0 {
            return findBestViewController(vc: svc.viewControllers.last!)
        } else {
            return vc
        }
        
    } else if vc.isKind(of: UINavigationController.self) {
        let nvc = UINavigationController()
        if nvc.viewControllers.count > 0 {
            return findBestViewController(vc: nvc.topViewController!)
        } else {
            return vc
        }
        
    } else if vc.isKind(of: UITabBarController.self) {
        let tvc = UITabBarController()
        if (tvc.viewControllers?.count)! > 0 {
            return findBestViewController(vc: tvc.selectedViewController!)
        } else {
            return vc
        }
    } else {
        return vc
    }
    
    
}

func currentViewController() -> UIViewController? {
    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
        let returnController = findBestViewController(vc: viewController)
        return returnController
    } else {
        return nil
    }
    
}
