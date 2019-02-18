//
//  NavigationViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit
/// This is a class to handle NavigationViewController
class NavigationViewController: UINavigationController {
    /// Shared object for NavigationViewController
    static var shared =  NavigationViewController()
    
    /**
     Call this function to set RootViewController of NavigationViewController.
     - Parameters:
        - viewController : Pass UIViewController object.
     
     ### Usage Example: ###
     ````
     NavigationViewController.shared.setRootViewControllerWithDefaultProperties(teamViewController)
     ````
     */
    
    func setRootViewControllerWithDefaultProperties(_ viewController: UIViewController) {
        NavigationViewController.shared = NavigationViewController(rootViewController: viewController)
    }
}

