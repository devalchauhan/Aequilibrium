//
//  Int.swift
//  BPI
//

import Foundation

extension UInt32 {
    
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

extension Int
{
    func toString() -> String
    {
        let string = String(self)
        return string
    }
}
