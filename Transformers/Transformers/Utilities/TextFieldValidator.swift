//
//  TextFieldValidator.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class TextFieldValidator: NSObject {
    func isContainsIncorrectEntry(textFields : [UITextField]) -> (String,Bool,Bool) {
        for item in textFields {
            if (item.text?.isEmpty)! {
                return (item.placeholder!, true,false)
            } else if item.placeholder != "Name", let value = item.text, Int(value)!<0 || Int(value)!>10 {
                return (item.placeholder!, false,true)
            }
        }
        return ("",false,false)
    }
}
