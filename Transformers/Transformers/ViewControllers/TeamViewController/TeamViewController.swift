//
//  TeamViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

let kNavigationTitle = "TRANFORMERS"
/// This is a class created for TeamViewController
class TeamViewController: UIViewController {
    /// TeamViewModelDataSource instance
    var teamDataSource : TeamViewModelDataSource?
    /// UITableView instance to display Transformers
    @IBOutlet weak var tableView : UITableView!
    /// TeamViewController lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationViewController.shared.setTitle(title: kNavigationTitle)
        NavigationViewController.shared.addPlusButton()
        teamDataSource = TeamViewModelDataSource(_tableView: tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchTransformers(notification:)), name: Notification.Name(Strings.kFeatchTranformersNotification), object: nil)

    }
    @objc func fetchTransformers(notification: Notification) {
        teamDataSource?.getAllTransformerFromWS()
    }
    /// begin war by calling this function
    @IBAction func warClicked () {
        if autobots.count <= 0 && decepticons.count <= 0 {
            let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
            Alert.displayAlert(message: "Create Transformers to begin WAR", withTitle: kAlertTitle, withActions: [okAction])
            return
        }
        let resultViewController = ViewControllerInstence.fromStoryboard(Storyboard.main, identifire: Storyboard.Identifier.ResultViewController) as! ResultViewController
        NavigationViewController.shared.pushViewController(resultViewController, animated: true)
    }
}

