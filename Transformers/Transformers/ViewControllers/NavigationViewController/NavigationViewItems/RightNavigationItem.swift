//
//  RightNavigationItem.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

extension NavigationViewController {
    
    func addPlusButton() {
        self.topViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onPlusButtonClick(sender:)))
    }

    @objc func onPlusButtonClick(sender: AnyObject?) {
        
    }
    
}

