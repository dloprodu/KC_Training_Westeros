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
}
