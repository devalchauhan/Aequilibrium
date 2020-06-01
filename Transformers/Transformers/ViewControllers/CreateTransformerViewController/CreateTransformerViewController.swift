//
//  CreateTransformerViewController.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
let kCreateTitle = "CREATE TRANSFROMER"
let kUpdateTitle = "UPDATE TRANSFROMER"
/// This is a class created for CreateUpdateTransformerViewController
class CreateTransformerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField : UnderlineTextField!
    @IBOutlet weak var teamSegment : UISegmentedControl!
    @IBOutlet weak var strengthTextField : UnderlineTextField!
    @IBOutlet weak var intelligenceTextField : UnderlineTextField!
    @IBOutlet weak var speedTextField : UnderlineTextField!
    @IBOutlet weak var enduranceTextField : UnderlineTextField!
    @IBOutlet weak var rankTextField : UnderlineTextField!
    @IBOutlet weak var courageTextField : UnderlineTextField!
    @IBOutlet weak var firepowerTextField : UnderlineTextField!
    @IBOutlet weak var skillTextField : UnderlineTextField!
    @IBOutlet weak var createButton : UIButton!
    @IBOutlet weak var clearButton : UIButton!
    
    var isUpdate : Bool = false
    
    var tranformer = Transformer()
    /// CreateTransformerViewController lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    /// CreateTransformerViewController lifecycle method
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        configureTextFields()
    }
    /** Call this function to configure navigationbar */
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: (isUpdate ? kUpdateTitle : kCreateTitle))
        NavigationViewController.shared.addCancelButton()
    }
    /** Call this function to configure UI according to create/update */
    func configureUI() {
        createButton.setTitle((isUpdate ? "Update" : "Create"), for: .normal)
        createButton.roundedButtonAllCorner()
        clearButton.setTitle("Clear", for: .normal)
        clearButton.roundedButtonAllCorner()
        if isUpdate {
            tranformer = Transformer.shared
            nameTextField.text = tranformer.name
            switch (tranformer.team) {
            case "A" :
                teamSegment.selectedSegmentIndex = 0
                break
            default :
                teamSegment.selectedSegmentIndex = 1
                break
            }
            strengthTextField.text = String(describing: tranformer.strength)
            intelligenceTextField.text = String(describing: tranformer.intelligence)
            speedTextField.text = String(describing: tranformer.speed)
            rankTextField.text = String(describing: tranformer.rank)
            enduranceTextField.text = String(describing: tranformer.endurance)
            courageTextField.text = String(describing: tranformer.courage)
            firepowerTextField.text = String(describing: tranformer.firepower)
            skillTextField.text = String(describing: tranformer.skill)
        }
    }
    
    func configureTextFields() {
        self.nameTextField.underlineColor = .white
        self.nameTextField.underlineEditingColor = .white
        self.strengthTextField.underlineColor = .textFieldColor1
        self.strengthTextField.underlineEditingColor = .textFieldColor1
        self.intelligenceTextField.underlineColor = .textFieldColor2
        self.intelligenceTextField.underlineEditingColor = .textFieldColor2
        self.speedTextField.underlineColor = .textFieldColor3
        self.speedTextField.underlineEditingColor = .textFieldColor3
        self.enduranceTextField.underlineColor = .textFieldColor4
        self.enduranceTextField.underlineEditingColor = .textFieldColor4
        self.rankTextField.underlineColor = .textFieldColor5
        self.rankTextField.underlineEditingColor = .textFieldColor5
        self.courageTextField.underlineColor = .textFieldColor6
        self.courageTextField.underlineEditingColor = .textFieldColor6
        self.firepowerTextField.underlineColor = .textFieldColor7
        self.firepowerTextField.underlineEditingColor = .textFieldColor7
        self.skillTextField.underlineColor = .textFieldColor8
        self.skillTextField.underlineEditingColor = .textFieldColor8
    }
    
    /// This IBAction function is used to create or update transformer
    @IBAction func createOrUpdateTransformer () {
        let textFields : [UITextField] = [nameTextField,strengthTextField,intelligenceTextField,speedTextField,enduranceTextField,rankTextField,courageTextField,firepowerTextField,skillTextField]
        let (textField,isEmpty,isInvalid) = TextFieldValidator().isContainsIncorrectEntry(textFields: textFields)
        if isEmpty {
            let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
            Alert.displayAlert(message: "Please enter \(textField)", withTitle: kAlertTitle, withActions: [okAction])
        } else if isInvalid {
            let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
            Alert.displayAlert(message: "Please enter valid \(textField) between 1 to 10", withTitle: kAlertTitle, withActions: [okAction])
        } else {
            APIServiceClient.shared.createOrUpdateTransformer(path: URLPath.Transformers,isUpdate: isUpdate, tranformerJson: (isUpdate ? configureJsonToUpdateTransformer(_id: tranformer.id!) : configureJsonToCreateTransformer() ), success: { (data, response, error) in
                do {
                    let transformerJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    Transformer.shared.configure(JSON: transformerJson as! [AnyHashable : Any])
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(Strings.kFeatchTranformersNotification), object: nil)
                        NavigationViewController.shared.popViewController(animated: true)
                    }
                } catch  { }
            }) { (error) -> (Void) in
                let okAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel)
                let type : String = self.isUpdate ? "updating" : "creating"
                Alert.displayAlert(message: "Something went wrong, while \(type) tranformer.", withTitle: kAlertTitle, withActions: [okAction])
                return
            }
        }
    }
    /// This fuction is used to create dictionary which needs to be pass in CreateTransformer API Call
    func configureJsonToCreateTransformer() -> Dictionary<String, Any> {
        var transformer = Dictionary<String, Any>()
        let strength : Int  = Int(strengthTextField.text!)!
        let intelligence : Int  = Int(intelligenceTextField.text!)!
        let speed : Int  = Int(speedTextField.text!)!
        let endurance : Int  = Int(enduranceTextField.text!)!
        let rank : Int  = Int(rankTextField.text!)!
        let courage : Int  = Int(courageTextField.text!)!
        let firepower : Int  = Int(firepowerTextField.text!)!
        let skill : Int  = Int(skillTextField.text!)!
        transformer = ["name" :nameTextField.text! , "team" : (teamSegment.selectedSegmentIndex == 0 ? "A" : "D"), "strength" :strength,"intelligence" : intelligence, "speed" :speed, "endurance" :endurance, "rank" : rank, "courage" : courage, "firepower" : firepower, "skill" : skill]
        return transformer
    }
    /// This fuction is used to create dictionary which needs to be pass in UpdateTransformer API Call
    func configureJsonToUpdateTransformer(_id : String) -> Dictionary<String, Any> {
        var transformer = Dictionary<String, Any>()
        let strength : Int  = Int(strengthTextField.text!)!
        let intelligence : Int  = Int(intelligenceTextField.text!)!
        let speed : Int  = Int(speedTextField.text!)!
        let endurance : Int  = Int(enduranceTextField.text!)!
        let rank : Int  = Int(rankTextField.text!)!
        let courage : Int  = Int(courageTextField.text!)!
        let firepower : Int  = Int(firepowerTextField.text!)!
        let skill : Int  = Int(skillTextField.text!)!
        transformer = ["id" : _id,"name" :nameTextField.text! , "team" :(teamSegment.selectedSegmentIndex == 0 ? "A" : "D"), "strength" :strength,"intelligence" : intelligence, "speed" :speed, "endurance" :endurance, "rank" : rank, "courage" : courage, "firepower" : firepower, "skill" : skill]
        return transformer
    }
    /// This IBAction function is used to clear all textfield or delete transformer based on condition
    @IBAction func clearFields () {
        nameTextField.text = ""; strengthTextField.text = ""; intelligenceTextField.text = ""; speedTextField.text = ""; enduranceTextField.text = ""; rankTextField.text = ""; courageTextField.text = ""; firepowerTextField.text = ""; skillTextField.text = "";
    }
}

extension CreateTransformerViewController : UITextFieldDelegate {
    /// UITextField delegate to restrict user entry
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nameTextField {
            return true
        }
        else  {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if ((textField.text! + string).toInt() ?? 0 >= 11 && range.length == 0) {
                textField.shake()
                return false
            }
            return string == numberFiltered
        }
    }
    
}
