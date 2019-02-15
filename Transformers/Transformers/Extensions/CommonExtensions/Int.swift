//
//  Int.swift
//  BPI
//

import Foundation

extension UInt32 {
    
    // MARK:- String to unicode method
    init?(hexString: String) {
        let scanner = Scanner(string: hexString)
        var hexInt = UInt32.min
        let success = scanner.scanHexInt32(&hexInt)
        
        if success {
            self = hexInt
        } else {            
            return nil
        }
    }
}
