//
//  Sizes.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

//---------------------------------------
//MARK:- Screen Sizes
//---------------------------------------
struct ScreenSize {
    static let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_CENTER_X: CGFloat = UIScreen.main.bounds.size.width/2
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
    static let STANDARD_SCREEN_HEIGHT: CGFloat = 667.0
    static let STANDARD_SCREEN_WIDTH: CGFloat = 375.0
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEM_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
