//
//  WesterosMenuViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 03/03/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import Foundation
import UIKit

final class WesterosMenuViewController : UITabBarController {
    
    let houseListView: HouseListViewController
    let houseDetailView: HouseDetailViewController
    let houseListNavigation: UINavigationController
    let houseDetailNavigation: UINavigationController
    
    let seasonListView: SeasonListViewController
    let seasonDetailView: SeasonDetailViewController
    let seasonListNavigation: UINavigationController
    let seasonDetailNavigation: UINavigationController
    
    init() {
        houseListView = HouseListViewController(model: Repository.local.houses)
        houseDetailView = HouseDetailViewController(model: houseListView.lastSelectedHouse())
        
        houseListNavigation = houseListView.wrappedInNavigation()
        houseDetailNavigation = houseDetailView.wrappedInNavigation()
        
        seasonListView = SeasonListViewController(model: Repository.local.seasons)
        seasonDetailView = SeasonDetailViewController(model: seasonListView.lastSelectedSeason())
        
        seasonListNavigation = seasonListView.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailView.wrappedInNavigation()
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        self.viewControllers = [
            seasonListNavigation,
            houseListNavigation
        ]
        
        // Set delegates
        seasonListView.delegate = seasonDetailView
        houseListView.delegate = houseDetailView
        
        title = "Westeros Menu"
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WesterosMenuViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let collapsed = splitViewController?.isCollapsed ?? true
        
        if (collapsed) {
            return
        }
        
        if (viewController == houseListNavigation) {
            splitViewController?.viewControllers[1] = houseDetailNavigation
        } else {
            splitViewController?.viewControllers[1] = seasonDetailNavigation
        }
    }
}

extension WesterosMenuViewController : UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        self.setUpDetailViewController()
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        
        // sync views
        // moves stact views from master to detail
        self.viewControllers?.forEach { masterNavigation in
            var index = 0;
            var views = [UIViewController]()
            (masterNavigation as! UINavigationController).viewControllers.forEach { view in
                if (index > 1) {
                    views.append(view)
                }
                
                index += 1
            }
            (masterNavigation as! UINavigationController).popToRootViewController(animated: false)
            
            let detailNavigation = masterNavigation == houseListNavigation
                ? houseDetailNavigation
                : seasonDetailNavigation
            
            detailNavigation.popToRootViewController(animated: false)
            
            views.forEach { view in
                detailNavigation.pushViewController(view, animated: false)
            }
        }
        
        // sync models
        houseDetailView.model = houseListView.lastSelectedHouse()
        seasonDetailView.model = seasonListView.lastSelectedSeason()
        
        if (selectedViewController == houseListNavigation) {
            return houseDetailNavigation
        } else {
            return seasonDetailNavigation
        }
    }
}
