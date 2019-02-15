//
//  CreateTransformerViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
let kTitle = "CREATE TRANSFROMER"
let kStandardPickerRowHeight = CGFloat(40)

class CreateTransformerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var teamTextField : UITextField!
    @IBOutlet weak var strengthTextField : UITextField!
    @IBOutlet weak var intelligenceTextField : UITextField!
    @IBOutlet weak var speedTextField : UITextField!
    @IBOutlet weak var enduranceTextField : UITextField!
    @IBOutlet weak var rankTextField : UITextField!
    @IBOutlet weak var courageTextField : UITextField!
    @IBOutlet weak var firepowerTextField : UITextField!
    @IBOutlet weak var skillTextField : UITextField!
    
    let teamArray : Array = ["Autobots","Decepticons"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configurePickerView()
    }
    
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: kTitle)
        NavigationViewController.shared.addCancelButton()
    }
    
    func configurePickerView() {
        let teamPickerView: UIPickerView
        teamPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        teamPickerView.backgroundColor = .white
        teamPickerView.showsSelectionIndicator = true
        teamPickerView.delegate = self
        teamPickerView.dataSource = self
        teamTextField.inputView = teamPickerView
    }
}

extension CreateTransformerViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

extension CreateTransformerViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teamArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teamTextField.text = teamArray[row]
    }
}

extension CreateTransformerViewController : UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let pickerRowHeight = (kStandardPickerRowHeight * ScreenSize.SCREEN_HEIGHT )/ScreenSize.STANDARD_SCREEN_HEIGHT
        return pickerRowHeight
    }
}
