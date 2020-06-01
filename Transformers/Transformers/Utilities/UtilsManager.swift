//
//  UtilsManager.swift
//  Transformers
//
//  Created by Deval Chauhan on 01/06/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import UIKit
import MBProgressHUD

class UtilsManager: NSObject {
    
    static let shared = UtilsManager()
    var hud: MBProgressHUD!
    
    func hideMBProgressHUD(_ inView: UIView?) {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: inView!, animated: true)
        })
    }
    
    func showMBProgressHUD(_ inView: UIView?) {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.showAdded(to: inView!, animated: true)
        })
    }
}
