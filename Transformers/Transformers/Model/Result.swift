//
//  Result.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation

class Result: NSObject {
    
    static var shared =  Result()
    
    var winner : String?
    var survivors : Array<Any>?
    var battles : Array<Any>?
    
    override init() {}
}
