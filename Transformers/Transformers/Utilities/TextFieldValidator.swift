//
//  TextFieldValidator.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
/// This is a class created for textField validations
class TextFieldValidator: NSObject {
    
    /**
     Call this function for validating empty and incorrect textfield entries in CreateViewController class.
     - Parameters:
        - textFields : Array of textfields which you want to validate.
     - Returns:
        - it will return tuple (textField.placeholder, isEmpty, isInvalid) in form of (String,Bool,Bool)
     
     ### Usage Example: ###
     ````
     let (textField.placeholder,isEmpty,isInvalid) = TextFieldValidator().isContainsIncorrectEntry(textFields: [UITextField])
     ````
     */
    
    func isContainsIncorrectEntry(textFields : [UITextField]) -> (String,Bool,Bool) {
        for item in textFields {
            if (item.text?.isEmpty)! {
                return (item.placeholder!, true,false)
            } else if item.placeholder != "Name", let value = item.text, Int(value)!<=0 || Int(value)!>10 {
                return (item.placeholder!, false,true)
            }
        }
        return ("",false,false)
    }
}
