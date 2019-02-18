//
//  ResultDataSourceTests.swift
//  TransformersTests
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import XCTest
@testable import Transformers

class ResultDataSourceTests: XCTestCase {
    
    let source : Transformer = Transformer()
    let destination : Transformer = Transformer()
    override func setUp() {
        source.name = "optimus prime"; source.team = "A"; source.strength = 1;source.intelligence = 1;source.speed = 1;source.endurance = 1;source.rank = 1;source.courage = 1;source.firepower = 1;source.skill = 1;
        destination.name = "optimus prime"; destination.team = "A"; destination.strength = 1;destination.intelligence = 1;destination.speed = 1;destination.endurance = 1;destination.rank = 1;destination.courage = 1;destination.firepower = 1;destination.skill = 1;
    }

    func testCheckTransformerName() {
        let name = ResultDataSource(_tableView: UITableView()).checkTransformerName(source: source, destination: destination)
        XCTAssertTrue(!name, "one of the opponent has name optimus prime or predaking")
    }

    func testCompareCourageAndStrength()  {
        source.strength = 8;source.courage = 8
        destination.strength = 4;destination.courage = 4
        let result = ResultDataSource(_tableView: UITableView()).checkCourageAndStrength(sourceTranformer: source, destinationTransformer: destination)
        XCTAssertTrue(!result, "one of the opponent wins by strength and courage")
    }
    
    func testCompareSkill() {
        source.skill = 4;
        let result = ResultDataSource(_tableView: UITableView()).checkSkill(sourceTranformer: source, destinationTransformer: destination)
        XCTAssertTrue(!result, "one of the opponent wins by skill")
    }
}
