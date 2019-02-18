//
//  NavigationViewControllerTests.swift
//  TransformersTests
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import XCTest
@testable import Transformers

class NavigationViewControllerTests: XCTestCase {

    override func setUp() {
        NavigationViewController.shared.setRootViewControllerWithDefaultProperties(TeamViewController())
    }

    func testSettingRootViewController() {
        guard NavigationViewController.shared.viewControllers.first != nil else {
            XCTAssert(false, "unable to find root view controller")
            return
        }
    }
}
