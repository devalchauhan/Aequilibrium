//
//  AppDelegateExtension.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    func setWindowProperties() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        window?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setRootViewController(_ viewController: UIViewController)  {
        mainWindow.rootViewController = viewController
    }
    
    func initializeFirstViewController() {
        let teamViewController = ViewControllerInstence.fromStoryboard(Storyboard.main, identifire: Storyboard.Identifier.TeamViewController) as! TeamViewController
        NavigationViewController.shared.setRootViewControllerWithDefaultProperties(teamViewController)
        setRootViewController(NavigationViewController.shared)
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
