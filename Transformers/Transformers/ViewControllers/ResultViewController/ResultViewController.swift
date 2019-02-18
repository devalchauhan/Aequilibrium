//
//  ResultViewController.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var resultDataSource : ResultDataSource?
    
    @IBOutlet weak var battleCount : UILabel!
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        resultDataSource = ResultDataSource(_tableView: tableView)
        battleCount.text = "No. of battle : \(String(describing: resultDataSource!.battleCount))"
    }
    
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: "RESULT")
        NavigationViewController.shared.addCancelButton()
    }
}
