//
//  ResultViewController.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
/// This is a class created to handle ResultViewController
class ResultViewController: UIViewController {
    /// ResultDataSource instance
    var resultDataSource : ResultDataSource?
    /// Label to display battle count
    @IBOutlet weak var battleCount : UILabel!
    /// UITableView instance to display result
    @IBOutlet weak var tableView : UITableView!
    /// ResultViewController lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        resultDataSource = ResultDataSource(_tableView: tableView)
        battleCount.text = "No. of battle : \(String(describing: resultDataSource!.battleCount))"
    }
    /** Call this function to configure navigationbar */
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: "RESULT")
        NavigationViewController.shared.addCancelButton()
    }
}
