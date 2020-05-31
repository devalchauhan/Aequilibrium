//
//  TeamViewModelDataSource.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
import SDWebImage

typealias Completion = () -> Void

var autobots = [Transformer]()
var decepticons = [Transformer]()

/// This class is created for getting data for Transformer by calling API, and provide that to UITableView dataSource
class TeamViewModelDataSource: NSObject {    
    /// UITableView instance
    var tableView : UITableView?
    
    /// TeamViewModelDataSource initializer
    init(_tableView: UITableView) {
        super.init()
        configureTableView(_tableview: _tableView)
        if let token = userDefault.value(forKey: "BearerToken") {
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(token)")
        }
        else {
            getAllSpark {
                self.getAllTransformerFromWS()
            }
        }
        getAllTransformerFromWS()
    }
    
    /**
     Call this function for UITableView setup by providing delegate,datasource, few basic properties and UITableViewCell nib registration.
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
        //tableView?.rowHeight = UITableView.automaticDimension
        tableView?.separatorColor = UIColor.darkGray
        tableView?.tableFooterView = UIView()
        tableView?.register(UINib(nibName: "AutobotTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AutobotTableViewCell")
        tableView?.register(UINib(nibName: "DecepticonTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "DecepticonTableViewCell")
        tableView?.register(UINib(nibName: "VsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "VsTableViewCell")
        
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
     Call this function for getting Authorization Bearer token by calling allspark API call.
     
     ### Usage Example: ###
     ````
     getAllSpark()
     ````
     */
    func getAllSpark(success: @escaping Completion) {
        APIServiceClient.shared.getAllSpark(path: URLPath.AllSpark, success: { (data, response, error) in
            let bearerToken : String = String(data: data!, encoding: String.Encoding.utf8) ?? ""
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(bearerToken)")
            userDefault.set(bearerToken, forKey: "BearerToken")
            userDefault.synchronize()
            success()
        }) { (error) -> (Void) in
            let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
            Alert.displayAlert(message: "Something went wrong, while authorization.", withTitle: kAlertTitle, withActions: [okAction])
            return
        }
    }
    
    /**
     Call this function for getting All Transformers by calling transformers API call.
     
     ### Usage Example: ###
     ````
     getAllTransformerFromWS()
     ````
     */
    func getAllTransformerFromWS(){
        var transformers : [Transformer] = []
        APIServiceClient.shared.getAllTransformer(path: URLPath.Transformers, success: { (data, response, error) in
            do {
                if let transformerJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let array : [AnyObject] = transformerJson["transformers"] as! [AnyObject]
                    for item in array {
                        let transformer = Transformer()
                        transformer.id = (item["id"] as! String)
                        transformer.name = (item["name"] as! String)
                        transformer.team = (item["team"] as! String)
                        transformer.strength = (item["strength"] as! Int)
                        transformer.intelligence = (item["intelligence"] as! Int)
                        transformer.speed = (item["speed"] as! Int)
                        transformer.endurance = (item["endurance"] as! Int)
                        transformer.rank = (item["rank"] as! Int)
                        transformer.courage = (item["courage"] as! Int)
                        transformer.firepower = (item["firepower"] as! Int)
                        transformer.skill = (item["skill"] as! Int)
                        transformer.team_icon = (item["team_icon"] as! String)
                        transformers.append(transformer)
                    }
                }
            } catch { }
            autobots = (transformers.filter() { $0.team == "A" }.sorted(by: { $0.rank > $1.rank }))
            decepticons = (transformers.filter() { $0.team == "D" }.sorted(by: { $0.rank > $1.rank }))
            self.reloadTableView(_tableView: self.tableView!)
        }) { (error) -> (Void) in
            let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
            Alert.displayAlert(message: "Something went wrong, while getting all the transformers.", withTitle: kAlertTitle, withActions: [okAction])
            return
        }
    }
}

extension TeamViewModelDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return autobots.count > decepticons.count ? autobots.count : decepticons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section <= autobots.count && section <= decepticons.count) {
            return 3
        } else {
            return 1
        }
        //return section <= autobots.count && section <= decepticons.count ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: AutobotTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AutobotTableViewCell", for: indexPath) as! AutobotTableViewCell
            cell.separatorInset = UIEdgeInsets.zero
            cell.selectionStyle = .none
            if indexPath.section <= autobots.count - 1 {
                if autobots.count > decepticons.count && autobots.count-1 == indexPath.section {
                    cell.contentView.roundedAllCorner()
                }
                cell.autobotItem = autobots[indexPath.section]
                cell.autobotButton.tag = indexPath.section
            }
            return cell
        case 2:
            let cell: DecepticonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DecepticonTableViewCell", for: indexPath) as! DecepticonTableViewCell
            cell.separatorInset = UIEdgeInsets.zero
            cell.selectionStyle = .none
            if indexPath.section <= decepticons.count - 1 {
                if autobots.count < decepticons.count && decepticons.count-1 == indexPath.section {
                    cell.contentView.roundedAllCorner()
                }
                cell.decepticonItem = decepticons[indexPath.section]
                cell.decepticonButton.tag = indexPath.section
            }
            return cell
        default:
            let cell: VsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VsTableViewCell", for: indexPath) as! VsTableViewCell
            cell.separatorInset = UIEdgeInsets.zero
            cell.selectionStyle = .none
            return cell
        }
        
//
//        if indexPath.section <= autobots.count - 1 {
//            cell.autobotItem = autobots[indexPath.row]
//            cell.autobotButton.tag = indexPath.row
//        } else {
//            /*cell.autobotViewHeightContraint.constant = 0
//            cell.vsImageViewHeightContraint.constant = 0
//            UIView.animate(withDuration: 0.5) {
//                cell.setNeedsLayout()
//            }*/
//        }
//
//        if indexPath.section <= decepticons.count - 1 {
//            cell.decepticonItem = decepticons[indexPath.row]
//            cell.decepticonButton.tag = indexPath.row
//        } else {
//            /*cell.decepticonViewHeightContraint.constant = 0
//            cell.vsImageViewHeightContraint.constant = 0
//            UIView.animate(withDuration: 0.5) {
//                cell.setNeedsLayout()
//            }*/
//        }

    }
}

extension TeamViewModelDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section <= autobots.count-1 && indexPath.section <= decepticons.count-1) {
            return UITableView.automaticDimension
        } else {
            switch indexPath.row {
            case 0:
                if indexPath.section >= autobots.count {
                   return 0
                }
            case 2:
                if indexPath.section >= decepticons.count {
                   return 0
                }
            default:
                return 0
            }
            return UITableView.automaticDimension
        }
    }
}
