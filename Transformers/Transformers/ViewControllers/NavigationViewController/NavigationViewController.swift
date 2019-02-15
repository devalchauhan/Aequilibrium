//
//  NavigationViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

class NavigationViewController: UINavigationController {
    static var shared =  NavigationViewController()
    
    func setRootViewControllerWithDefaultProperties(_ viewController: UIViewController) {
        NavigationViewController.shared = NavigationViewController(rootViewController: viewController)
    }
}

