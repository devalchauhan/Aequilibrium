//
//  ResultDataSource.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

let kOptimusPrime = "OPTIMUSPRIME"
let kPredaking = "PREDAKING"

class ResultDataSource: NSObject {
    
    var winner : [Transformer] = []
    var survivors : [Transformer] = []
    var battleCount : Int = 0
    
    override init() {
        super.init()
        self.getResult()
    }
    
    func getResult()  {
        var source : [Transformer] = decepticons // 1
        var destination : [Transformer] = autobots // 2
        func decideSourceDestination() {
            switch autobots.count - decepticons.count {
            case Int.min..<0:
                source = decepticons;destination = autobots
                break
            case 0:
                break
            default:
                source = autobots;destination = decepticons
                break
            }
        }
        decideSourceDestination()
        
        for (index,item) in source.enumerated() {
            if destination.count <= index {
                survivors.append(item)
                continue
            }
            else {
                battleCount = battleCount+1
                if checkTransformerName(sourceTranformer: item, destinationTransformer: destination[index]) {
                    if checkCourageAndStrength(sourceTranformer: item, destinationTransformer: destination[index]) {
                        if checkSkill(sourceTranformer: item, destinationTransformer: destination[index]) {
                            checkOverAllRating(sourceTranformer: item, destinationTransformer: destination[index])
                        }
                        else { // skill
                            continue
                        }
                    }
                    else { // courage
                        continue
                    }
                }
                else { // check name
                    continue
                }
            }
        }
    }
    
    func checkTransformerName(sourceTranformer : Transformer, destinationTransformer : Transformer) -> Bool {
        let sourceTranformerName = sourceTranformer.name!.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let destinationTransformerName = destinationTransformer.name!.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let array = [kOptimusPrime,kPredaking]
        
        if (array.contains(sourceTranformerName)) {
            if (array.contains(destinationTransformerName)) {
                return false
            }
            else {
                winner.append(sourceTranformer)
                return false
            }
        }
        else {
            if (array.contains(destinationTransformerName)) {
                winner.append(destinationTransformer)
                return false
            }
            else {
                return true
            }
        }
    }
    
    func checkCourageAndStrength(sourceTranformer : Transformer, destinationTransformer : Transformer) -> Bool {
        
        if (sourceTranformer.courage - destinationTransformer.courage >= 4) {
            
        }
        if (sourceTranformer.courage - destinationTransformer.courage >= 4) && (sourceTranformer.strength - destinationTransformer.strength) >= 3 {
            winner.append(sourceTranformer)
            return false
        }
        else if (destinationTransformer.courage - sourceTranformer.courage >= 4) && (destinationTransformer.strength - sourceTranformer.strength) >= 3 {
            winner.append(destinationTransformer)
            return false
        }
        return true
    }
    
    func checkSkill(sourceTranformer : Transformer, destinationTransformer : Transformer) -> Bool {
        if sourceTranformer.skill - destinationTransformer.skill >= 3 {
            winner.append(sourceTranformer)
            return false
        }
        else if destinationTransformer.skill - sourceTranformer.skill >= 3 {
            winner.append(destinationTransformer)
            return false
        }
        return true
    }
    
    func checkOverAllRating(sourceTranformer : Transformer, destinationTransformer : Transformer) {
        let sourceOverAllRating = sourceTranformer.strength + sourceTranformer.intelligence + sourceTranformer.speed + sourceTranformer.endurance + sourceTranformer.firepower
        let destinationOverAllRating = destinationTransformer.strength + destinationTransformer.intelligence + destinationTransformer.speed + destinationTransformer.endurance + destinationTransformer.firepower
        if sourceOverAllRating > destinationOverAllRating {
            winner.append(sourceTranformer)
        }
        else if destinationOverAllRating > sourceOverAllRating {
            winner.append(destinationTransformer)
        }
        else {
            // destoy both call delete WS
        }
        
    }
}
