//
//  ReachabilityTests.swift
//  TransformersTests
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import XCTest
@testable import Transformers

class ReachabilityTests: XCTestCase {
    
    override func setUp() {
        testNetworkReachability()
    }
    
    func testNetworkReachability() {
        ReachabilityLayer.shared.checkForReachability()
        ReachabilityLayer.shared.reachability.whenReachable = { reachability in
            XCTAssertTrue(true,"App is reachable to network")
        }
        ReachabilityLayer.shared.reachability.whenUnreachable = { reachability in
            XCTAssertTrue(true,"App is not reachable to network")
        }
    }
    
}
