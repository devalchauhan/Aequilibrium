//
//  TeamViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

let kNavigationTitle = "TRANFORMERS"

class TeamViewController: UIViewController {
    
    var teamDataSource : TeamViewModelDataSource?
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationViewController.shared.setTitle(title: kNavigationTitle)
        NavigationViewController.shared.addPlusButton()
        teamDataSource = TeamViewModelDataSource(_tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        teamDataSource?.getAllTransformerFromWS()
    }
    
    @IBAction func warClicked () {
        let resultViewController = ViewControllerInstence.fromStoryboard(Storyboard.main, identifire: Storyboard.Identifier.ResultViewController) as! ResultViewController
        NavigationViewController.shared.pushViewController(resultViewController, animated: true)
    }

}

