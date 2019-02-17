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

let transformerCategory : Array = ["Winning Team","Survivors from loosing team"]

class ResultDataSource: NSObject {
    
    var winner : [Transformer] = []
    var survivors : [Transformer] = []
    var winningTeam : [Transformer] = []
    
    var battleCount : Int = 0
    var winningTeamName : String = ""
    var survivorTeamName : String = ""
    
    var tableView : UITableView?
    let cellReuseIdentifier = "cell"
    
    init(_tableView: UITableView) {
        super.init()
        configureTableView(_tableview: _tableView)
    
        self.getResult()
        calclutaeWinningTeam()
        reloadTableView(_tableView: tableView!)
    }
    
    func calclutaeWinningTeam() {
        let autobots : [Transformer] = winner.filter() { $0.team == "A" }
        let decepticons : [Transformer] = winner.filter() { $0.team == "D" }
        switch autobots.count - decepticons.count {
        case Int.min..<0:
            winningTeam = decepticons
            break
        case 0:
            break
        default:
            winningTeam = autobots
        }
        if winningTeam.count>0 {
            winningTeamName = winningTeam[0].team == "A" ? "Autobots" : "Decepticons"
        }
        if survivors.count>0 {
            survivorTeamName = survivors[0].team == "A" ? "Autobots" : "Decepticons"
        }
    }
    func configureTableView(_tableview: UITableView) {
        tableView = _tableview
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 60.0
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.separatorColor = UIColor.darkGray
        tableView?.tableFooterView = UIView()
    }
    
    func reloadTableView(_tableView : UITableView) {
        _tableView.reloadData()
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
        let sourceTranformerName = sourceTranformer.name!.uppercased().replacingOccurrences(of: " ", with: "")
        let destinationTransformerName = destinationTransformer.name!.uppercased().replacingOccurrences(of: " ", with: "")
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

extension ResultDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return transformerCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? winningTeam.count : survivors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        cell!.separatorInset = UIEdgeInsets.zero
        cell!.textLabel?.text = indexPath.section == 0 ? winningTeam[indexPath.row].name : survivors[indexPath.row].name
    
        return cell!
    }
}

extension ResultDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let teamName : String = section == 0 ? winningTeamName : survivorTeamName
        return "\(transformerCategory[section]) : \(String(describing: teamName))"
    }
}
