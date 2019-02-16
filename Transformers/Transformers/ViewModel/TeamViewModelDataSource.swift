//
//  TeamViewModelDataSource.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
import SDWebImage

class TeamViewModelDataSource: NSObject {
    
    var autobots = [Transformer]()
    var decepticons = [Transformer]()
    
    var tableView : UITableView?
    
    init(_tableView: UITableView) {
        super.init()
        configureTableView(_tableview: _tableView)
        if let token = userDefault.value(forKey: "BearerToken") {
            APISessionService.shared.setAdditionalRequestHeaders(key: "Authorization", value: "Bearer \(token)")
            
            func getAllTransformer1() {
                APIServiceClient.shared.getAllTransformer(path: URLPath.Transformers, success: { (data, response, error) in
                    let bearerToken : String = String(data: data!, encoding: String.Encoding.utf8) ?? ""
                    print(bearerToken)
                }) { (error) -> (Void) in
                    print(error)
                }
            }
            getAllTransformer1()
        }
        else {
            getAllSpark()
        }
        getTransformers()
    }
    
    func configureTableView(_tableview: UITableView) {
        tableView = _tableview
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 140.0
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
    
    func getTransformers()  {
        let transformers = TransformerCoreData.fetchTransformersFromCoreData()
//        let autobotsPredicate = NSPredicate.init(format: "team == A")
//        let decepticonsPredicate = NSPredicate.init(format: "team == D")
        autobots = transformers.filter() { $0.team == "A" }
        decepticons = transformers.filter() { $0.team == "D" }
        reloadTableView(_tableView: tableView!)
    }
}

extension TeamViewModelDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ? autobots.count : decepticons.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.transformerName.text = indexPath.section == 0 ? autobots[indexPath.row].name : decepticons[indexPath.row].name
        let imageURL : String = (indexPath.section == 0 ? autobots[indexPath.row].team_icon : decepticons[indexPath.row].team_icon)!
        cell.transformerImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NavigationViewController.shared.gotoCreateTransformer(isUpdate: true, transformer: (indexPath.section == 0 ? autobots[indexPath.row] : decepticons[indexPath.row]))
    }
    
}

extension TeamViewModelDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return transformerCategory[section]
    }
}
