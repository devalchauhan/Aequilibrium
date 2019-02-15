//
//  ViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kTitle = "TRANFORMERS"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationViewController.shared.setTitle(title: kTitle)
        NavigationViewController.shared.addPlusButton()
    }


}

