//
//  Alert.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit


/// This is a class created for handling Alerts in Project
class Alert: NSObject {
    /// UIAlertController object
    static var alertViewController: UIAlertController?
    
    /**
     Call this function for showing alert with given button in your View Controller class.
     - Parameters:
        - message: Pass your alert message in String.
        - title: Pass your alert title in String.
        - withActions: Pass your alert action in array
     
     ### Usage Example: ###
     ````
     Alert.displayAlert(message: "message", withTitle: "title", withActions: [UIAlertAction,UIAlertAction])
     ````
     */
    
    class func displayAlert(message: String, withTitle title: String, withActions actions: NSArray?) {
        alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions as? [UIAlertAction]{
            for action in actions{
                alertViewController?.addAction(action)
            }
        }
        NavigationViewController.shared.present(alertViewController!, animated: true, completion: nil)
    }
}
