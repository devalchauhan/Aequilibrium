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
    
    var endGame : Bool = false
    
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
                if checkTransformerName(source: item, destination: destination[index]) {
                    if checkCourageAndStrength(sourceTranformer: item, destinationTransformer: destination[index]) {
                        if checkSkill(sourceTranformer: item, destinationTransformer: destination[index]) {
                            checkOverAllRating(sourceTranformer: item, destinationTransformer: destination[index])
                        }
                    }
                }
                else {
                    if endGame {
                        autobots.append(contentsOf: decepticons)
                        destroyTransformers(allTransformers: autobots, goBack: true)
                        break
                    }
                }
            }
        }
    }
    
    func checkTransformerName(source : Transformer, destination : Transformer) -> Bool {
        let array = [kOptimusPrime,kPredaking]
        let sourceName = source.name?.transformerName() ?? ""
        let destinationName = destination.name?.transformerName() ?? ""
        
        if array.contains(sourceName) && array.contains(destinationName) {
            endGame = true
            return false
        } else if !(array.contains(sourceName)) && !(array.contains(destinationName)) {
            return true
        } else if array.contains(sourceName) && !(array.contains(destinationName)) {
            winner.append(source)
            return false
        } else {
            winner.append(destination)
            return false
        }
    }
    
    func checkCourageAndStrength(sourceTranformer : Transformer, destinationTransformer : Transformer) -> Bool {
        
        if (sourceTranformer.courage - destinationTransformer.courage >= 4) &&
            (sourceTranformer.strength - destinationTransformer.strength) >= 3 {
            winner.append(sourceTranformer)
            return false
        }
        else if (destinationTransformer.courage - sourceTranformer.courage >= 4) &&
            (destinationTransformer.strength - sourceTranformer.strength) >= 3 {
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
        let sourceOverAllRating = sourceTranformer.strength +
            sourceTranformer.intelligence +
            sourceTranformer.speed +
            sourceTranformer.endurance +
            sourceTranformer.firepower
        
        let destinationOverAllRating = destinationTransformer.strength +
            destinationTransformer.intelligence +
            destinationTransformer.speed +
            destinationTransformer.endurance +
            destinationTransformer.firepower
        
        if sourceOverAllRating > destinationOverAllRating {
            winner.append(sourceTranformer)
        }
        else if destinationOverAllRating > sourceOverAllRating {
            winner.append(destinationTransformer)
        }
        else {
            destroyTransformers(allTransformers: [sourceTranformer,destinationTransformer], goBack: false)
        }
    }
    
    func destroyTransformers(allTransformers : [Transformer], goBack : Bool) {
        let dispatchGroup = DispatchGroup()
        for item in allTransformers {
            dispatchGroup.enter()
            APIServiceClient.shared.deleteTransformer(path: (URLPath.Transformers + "/" + item.id!), success: { (data, response, error) in
                dispatchGroup.leave()
            }) { (error) -> (Void) in
            }
        }
        dispatchGroup.notify(queue: .main) {
            if goBack {
                NavigationViewController.shared.popViewController(animated: true)
            }
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

extension String {
    func transformerName() -> String {
        return self.uppercased().replacingOccurrences(of: " ", with: "")
    }
}
