//
//  testTextFieldValidations.swift
//  TransformersTests
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import XCTest
@testable import Transformers

class testTextFieldValidations: XCTestCase {
    
    override func setUp() {
        testEmptyTextValidations()
        testIncorrectTextValidation()
    }
    
    func testEmptyTextValidations() {
        let textField = UITextField(); textField.text = ""; textField.placeholder = "textField"
        let (_, isEmpty, _) = TextFieldValidator().isContainsIncorrectEntry(textFields: [textField])
        XCTAssertTrue(isEmpty, "Text Field is empty")
    }
    
    func testIncorrectTextValidation() {
        let textField = UITextField(); textField.text = "0"; textField.placeholder = "textField"
        let (_, _, isIncorrect) = TextFieldValidator().isContainsIncorrectEntry(textFields: [textField])
        XCTAssertTrue(isIncorrect, "Text Field is Incorrect")
    }
}
