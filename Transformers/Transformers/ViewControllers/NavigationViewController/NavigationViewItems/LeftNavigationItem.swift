//
//  LeftNavigationItem.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

extension NavigationViewController {
    func removeBackButton() {
        self.topViewController?.navigationItem.setHidesBackButton(true, animated:true);
    }
}
