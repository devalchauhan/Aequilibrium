//
//  TeamViewModelDataSource.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
import SDWebImage

var autobots = [Transformer]()
var decepticons = [Transformer]()

class TeamViewModelDataSource: NSObject {    
    
    var tableView : UITableView?
    
    init(_tableView: UITableView) {
        super.init()
        configureTableView(_tableview: _tableView)
        if let token = userDefault.value(forKey: "BearerToken") {
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(token)")
        }
        else {
            getAllSpark()
        }
        getAllTransformerFromWS()
    }
    
    func configureTableView(_tableview: UITableView) {
        tableView = _tableview
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 120.0
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.separatorColor = UIColor.darkGray
        tableView?.tableFooterView = UIView()
        tableView?.register(UINib(nibName: "TeamTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TeamTableViewCell")
    }
    
    func reloadTableView(_tableView : UITableView) {
        _tableView.reloadData()
    }
    
    func getAllSpark() {
        APIServiceClient.shared.getAllSpark(path: URLPath.AllSpark, success: { (data, response, error) in
            let bearerToken : String = String(data: data!, encoding: String.Encoding.utf8) ?? ""
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(bearerToken)")
            userDefault.set(bearerToken, forKey: "BearerToken")
            userDefault.synchronize()
        }) { (error) -> (Void) in
            print(error)
        }
    }
    
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
            print(error)
        }
    }
}

extension TeamViewModelDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autobots.count > decepticons.count ? autobots.count : decepticons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell

        cell.separatorInset = UIEdgeInsets.zero
        
        if indexPath.row <= autobots.count - 1 {
            cell.autobotName.text = autobots[indexPath.row].name
            let autobotImageURL = autobots[indexPath.row].team_icon
            cell.autobotImage.sd_setImage(with: URL(string: autobotImageURL!), placeholderImage: UIImage(named: "no_image.png"))
            cell.autobotButton.tag = indexPath.row
            cell.autobotUpdateConfigure(transformer: autobots[indexPath.row]) {
                Transformer.shared = autobots[indexPath.row]
                NavigationViewController.shared.gotoCreateTransformer(isUpdate: true)
            }
        }
        else {
            cell.autobotName.text = ""
            cell.autobotImage.image = UIImage(named: "not_available.png")
        }
        
        if indexPath.row <= decepticons.count - 1 {
            cell.decepticonName.text = decepticons[indexPath.row].name
            let decepticonImageURL = decepticons[indexPath.row].team_icon
            cell.decepticonImage.sd_setImage(with: URL(string: decepticonImageURL!), placeholderImage: UIImage(named: "no_image.png"))
            cell.decepticonButton.tag = indexPath.row
            cell.decepticonUpdateConfigure(transformer: decepticons[indexPath.row]) {
                Transformer.shared = decepticons[indexPath.row]
                NavigationViewController.shared.gotoCreateTransformer(isUpdate: true)
            }
        }
        else {
            cell.decepticonName.text = ""
            cell.decepticonImage.image = UIImage(named: "not_available.png")
        }
        return cell
    }
}

extension TeamViewModelDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
