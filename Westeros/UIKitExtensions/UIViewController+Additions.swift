//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 14/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func setUpDetailViewController() {
        /*
        guard let svc = self.splitViewController else {
            return
        }
        
        let detailVC = (svc.viewControllers[1] as! UINavigationController).viewControllers.last!
        
        switch svc.displayMode {
        // The split view controller automatically decides the most appropriate
        // display mode based on the device and the current app size.
        case .automatic:
            break
        // The primary view controller is hidden.
        case .primaryHidden:
            if (detailVC.navigationItem.rightBarButtonItems?.last == svc.displayModeButtonItem) {
                return
            }
            
            if (detailVC.navigationItem.rightBarButtonItems == nil) {
                detailVC.navigationItem.rightBarButtonItems = [UIBarButtonItem]()
            }
            
            detailVC.navigationItem.rightBarButtonItems?.append(svc.displayModeButtonItem)
            break
        // The primary view controller is layered on top of the secondary
        // view controller, leaving the secondary view controller partially visible.
        case .primaryOverlay:
            //if (detailVC.navigationItem.rightBarButtonItems?.last == svc.displayModeButtonItem) {
            //    detailVC.navigationItem.rightBarButtonItems?.removeLast()
            //}
            break
        // The primary and secondary view controllers are displayed side-by-side onscreen.
        case .allVisible:
            break
        }
        */
    }
}
