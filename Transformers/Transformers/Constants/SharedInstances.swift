//
//  SharedInstances.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

//---------------------------------------
//MARK:- Shared Instence
//---------------------------------------

/// Applecation Delegate
let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

/// Main Window of the Application
let mainWindow: UIWindow = appDelegate.window!

/// UserDefault shared instence
let userDefault = UserDefaults.standard
