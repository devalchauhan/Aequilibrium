//
//  APIServiceClientTests.swift
//  TransformersTests
//
//  Created by Deval on 18/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import XCTest
@testable import Transformers

class APIServiceClientTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Loading API")
    var httpUrlResponse : HTTPURLResponse = HTTPURLResponse()
    var dataResponse : Data = Data()
    var httpError : Error?
    let timeout : TimeInterval = 10
    let source : Transformer = Transformer()
    override func setUp() {
        source.name = "optimus prime"; source.team = "A"; source.strength = 1;source.intelligence = 1;source.speed = 1;source.endurance = 1;source.rank = 1;source.courage = 1;source.firepower = 1;source.skill = 1;
    }
    
    func testGetAllSparkSuccess() {
        APIServiceClient.shared.getAllSpark(path: URLPath.AllSpark, success: { (data, response, error) in
            let bearerToken : String = String(data: data!, encoding: String.Encoding.utf8) ?? ""
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(bearerToken)")
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 200)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    func testGetAllSparkFail() {
        APIServiceClient.shared.getAllSpark(path: "\(URLPath.AllSpark)/1", success: { (data, response, error) in
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 404)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    func testGetAllTranformersSuccess() {
        APIServiceClient.shared.getAllTransformer(path: URLPath.Transformers, success: { (data, response, error) in
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 200)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    func testGetAllTranformersFail() {
        APIServiceClient.shared.getAllTransformer(path: "\(URLPath.Transformers)/1", success: { (data, response, error) in
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 404)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    func testCreateTransformerSuccess() {
        APIServiceClient.shared.createOrUpdateTransformer(path: URLPath.Transformers, isUpdate: false, tranformerJson: configureTranformerJson(source: source), success: { (data, response, error) in
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 201)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    func testCreateTransformerFail() {
        source.courage = 0
        APIServiceClient.shared.createOrUpdateTransformer(path: URLPath.Transformers, isUpdate: false, tranformerJson: configureTranformerJson(source: source), success: { (data, response, error) in
            self.httpUrlResponse = response!
            self.dataResponse = data!
            self.httpError = error ?? nil
            self.expectation.fulfill()
        }) { (error) -> (Void) in }
        wait(for: [expectation], timeout: self.timeout)
        XCTAssertEqual(self.httpUrlResponse.statusCode, 400)
        XCTAssertNotNil(self.httpUrlResponse.allHeaderFields)
        XCTAssertNotNil(self.dataResponse)
        XCTAssertNil(self.httpError)
    }
    
    
    func configureTranformerJson(source : Transformer) -> Dictionary<String, Any> {
        var transformer = Dictionary<String, Any>()
        transformer = ["name" :source.name! , "team" : "A", "strength" :source.strength,"intelligence" : source.intelligence, "speed" :source.speed, "endurance" :source.endurance, "rank" : source.rank, "courage" : source.courage, "firepower" : source.firepower, "skill" : source.skill]
        return transformer
    }
}
