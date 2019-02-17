//
//  Alert.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
let kAlertTitle = "TRANSFORMERS"
let kAlertButtonTitle = "OK"
class Alert: NSObject {
    static var alertViewController: UIAlertController?
    
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
