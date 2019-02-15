//
//  CreateTransformerViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class CreateTransformerViewController: UIViewController {
    let kTitle = "CREATE TRANSFROMER"
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: kTitle)
        NavigationViewController.shared.addCancelButton()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
