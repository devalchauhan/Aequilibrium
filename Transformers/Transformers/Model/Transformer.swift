//
//  Transformer.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
/// This class is created as a model of Transformer
class Transformer: NSObject {
    
    /// Shared instance of Transformer model
    static var shared =  Transformer()
    /// Transformer model initializer
    override init() {}
    /// Uniquely generated ID
    var id: String?
    /// Transformer name.
    var name: String?
    /// Transformer team, either “A” or “D” (Autobot or Decepticon).
    var team: String?
    /// Strength value, must be between 1 and 10.
    var strength: Int = 0
    /// Intelligence value, must be between 1 and 10.
    var intelligence: Int = 0
    /// Speed value, must be between 1 and 10.
    var speed : Int = 0
    /// Endurance value, must be between 1 and 10.
    var endurance : Int = 0
    /// Rank value, must be between 1 and 10.
    var rank : Int = 0
    /// Courage value, must be between 1 and 10.
    var courage : Int = 0
    /// Firepower value, must be between 1 and 10.
    var firepower : Int = 0
    /// Skill value, must be between 1 and 10.
    var skill : Int = 0
    /// An image URL that represents what team the Transformer is on.
    var team_icon : String?
    
    
    /**
     Call this function to create Transformer model from JSON Dictionary.
     - Parameters:
        - JSON : JSON Dictionary if form of [AnyHashable : Any].
     
     ### Usage Example: ###
     ````
     Transformer.shared.configure(JSON: transformerJson as! [AnyHashable : Any])
     ````
     */
    
    func configure(JSON: [AnyHashable : Any]) {
        let transformerInfo: Dictionary = JSON
        id = transformerInfo["id"] as? String
        name = transformerInfo["name"] as? String
        team = transformerInfo["team"] as? String
        strength =  transformerInfo["strength"] as! Int
        intelligence = transformerInfo["intelligence"] as! Int
        speed = transformerInfo["speed"] as! Int
        endurance = transformerInfo["endurance"] as! Int
        rank = transformerInfo["rank"] as! Int
        courage = transformerInfo["courage"] as! Int
        firepower = transformerInfo["firepower"] as! Int
        skill = transformerInfo["skill"] as! Int
        team_icon = transformerInfo["team_icon"] as? String
    }
}
