//
//  ResultViewController.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var resultDataSource = ResultDataSource()
    
    @IBOutlet weak var winner : UILabel!
    @IBOutlet weak var survivors : UILabel!
    @IBOutlet weak var battleCount : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        winner.text = String(describing: resultDataSource.winner.count)
        survivors.text = String(describing: resultDataSource.survivors.count)
        battleCount.text = String(describing: resultDataSource.battleCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: "RESULT")
        NavigationViewController.shared.addCancelButton()
    }

}
