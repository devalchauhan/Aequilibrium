//
//  ResultDataSource.swift
//  Transformers
//
//  Created by Deval on 17/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

let kOptimusPrime = "Optimus Prime"
let kPredaking = "Predaking"

let transformerCategory : Array = ["Winning Team","Survivors from"]

/// This class is created for calculating result for winning team, survivors and battle count.
class ResultDataSource: NSObject {
    /// winner list of individual battle
    var winner : [Transformer] = []
    /// survivor list who haven't participated in battle
    var survivors : [Transformer] = []
    /// winning team list
    var winningTeam : [Transformer] = []
    /// endGame flag to withdraw game immediately
    var endGame : Bool = false
    /// battle count
    var battleCount : Int = 0
    /// winning team name
    var winningTeamName : String = ""
    /// survivor team name
    var survivorTeamName : String = ""
    /// UITableView object
    var tableView : UITableView?
    /// Reusablecell indetifier
    let cellReuseIdentifier = "cell"
    
    /// ResultDataSource initializer
    init(_tableView: UITableView) {
        super.init()
        configureTableView(_tableview: _tableView)
        
        self.getResult()
        calclutaeWinningTeam()
        reloadTableView(_tableView: tableView!)
    }
    
    /**
     Call this function for calculating result after war.
     
     ### Usage Example: ###
     ````
     calclutaeWinningTeam()
     ````
     */
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
    /**
     Call this function for UITableView setup by providing delegate,datasource, few basic properties.
     - Parameters:
     - _tableview : Pass UITableView object.
     
     ### Usage Example: ###
     ````
     configureTableView(_tableview: _tableView)
     ````
     */
    func configureTableView(_tableview: UITableView) {
        tableView = _tableview
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 60.0
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.separatorColor = UIColor.darkGray
        tableView?.tableFooterView = UIView()
    }
    /**
     Call this function for reloading UITableView.
     - Parameters:
     - _tableview : Pass UITableView object.
     
     ### Usage Example: ###
     ````
     reloadTableView(_tableView: tableView!)
     ````
     */
    func reloadTableView(_tableView : UITableView) {
        _tableView.reloadData()
    }
    /**
     Call this function to initiate war between transformers.
     
     ### Usage Example: ###
     ````
     self.getResult()
     ````
     */
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
    /**
     Call this function to check winner by TranformerName.
     - Parameters:
     - source : Transfer model of one team.
     - destination : Transfer model of another(opponent) team.
     - Returns:
     - Bool : it will return Bool
     ### Usage Example: ###
     ````
     checkTransformerName(source: Transformer, destination: Transformer)
     ````
     */
    func checkTransformerName(source : Transformer, destination : Transformer) -> Bool {
        let array = [kOptimusPrime,kPredaking]
        let sourceName: String = source.name ?? ""
        let destinationName: String = destination.name ?? ""
    
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
    
    /**
     Call this function to check winner by Transformer courage and strength.
     - Parameters:
     - sourceTranformer : Transfer model of one team.
     - destinationTransformer : Transfer model of another(opponent) team.
     - Returns:
     - Bool : it will return Bool
     ### Usage Example: ###
     ````
     checkCourageAndStrength(sourceTranformer: Transformer, destinationTransformer: Transformer)
     ````
     */
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
    
    /**
     Call this function to check winner by Transformer skill.
     - Parameters:
     - sourceTranformer : Transfer model of one team.
     - destinationTransformer : Transfer model of another(opponent) team.
     - Returns:
     - Bool : it will return Bool
     ### Usage Example: ###
     ````
     checkSkill(sourceTranformer: Transformer, destinationTransformer: Transformer)
     ````
     */
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
    
    /**
     Call this function to check winner by Transformer overall rating.
     - Parameters:
     - sourceTranformer : Transfer model of one team.
     - destinationTransformer : Transfer model of another(opponent) team.
     - Returns:
     - Bool : it will return Bool
     ### Usage Example: ###
     ````
     checkOverAllRating(sourceTranformer: Transformer, destinationTransformer: Transformer)
     ````
     */
    func checkOverAllRating(sourceTranformer : Transformer, destinationTransformer : Transformer) {
        if sourceTranformer.overAllRatings > destinationTransformer.overAllRatings {
            winner.append(sourceTranformer)
        }
        else if destinationTransformer.overAllRatings > sourceTranformer.overAllRatings {
            winner.append(destinationTransformer)
        }
        else {
            destroyTransformers(allTransformers: [sourceTranformer,destinationTransformer], goBack: false)
        }
    }
    
    /**
     Call this function to destroy all Transformers by calling API.
     - Parameters:
     - allTransformers : Array of Transformer model
     - goBack : Bool to decide pop operation after completion
     ### Usage Example: ###
     ````
     destroyTransformers(allTransformers: autobots, goBack: true)
     ````
     */
    func destroyTransformers(allTransformers : [Transformer], goBack : Bool) {
        let dispatchGroup = DispatchGroup()
        for item in allTransformers {
            dispatchGroup.enter()
            APIServiceClient.shared.deleteTransformer(path: (URLPath.Transformers + "/" + item.id!), success: { (data, response, error) in
                NotificationCenter.default.post(name: Notification.Name(Strings.kFeatchTranformersNotification), object: nil)
                dispatchGroup.leave()
            }) { (error) -> (Void) in
                let okAction = UIAlertAction(title: AlertMessages.kAlertButtonTitle, style: .cancel)
                Alert.displayAlert(message: AlertMessages.kDestroyTransformerFailed, withTitle: AlertMessages.kAlertTitle, withActions: [okAction])
                return
            }
        }
        dispatchGroup.notify(queue: .main) {
            if goBack {
                NotificationCenter.default.post(name: Notification.Name(Strings.kFeatchTranformersNotification), object: nil)
                
                let okAction = UIAlertAction(title: AlertMessages.kAlertButtonTitle, style: .cancel) { action -> Void in
                    NavigationViewController.shared.popViewController(animated: true)
                }
                Alert.displayAlert(message: AlertMessages.kGameOver, withTitle: AlertMessages.kAlertTitle, withActions: [okAction])
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
