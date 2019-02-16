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
let kStandardPickerRowHeight = CGFloat(40)
let transformerCategory : Array = ["Autobots","Decepticons"]

class CreateTransformerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var teamSegment : UISegmentedControl!
    @IBOutlet weak var strengthTextField : UITextField!
    @IBOutlet weak var intelligenceTextField : UITextField!
    @IBOutlet weak var speedTextField : UITextField!
    @IBOutlet weak var enduranceTextField : UITextField!
    @IBOutlet weak var rankTextField : UITextField!
    @IBOutlet weak var courageTextField : UITextField!
    @IBOutlet weak var firepowerTextField : UITextField!
    @IBOutlet weak var skillTextField : UITextField!
    @IBOutlet weak var createButton : UIButton!
    @IBOutlet weak var clearButton : UIButton!
    
    var isUpdate : Bool = false
    
    var tranformer = Transformer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    func configureNavigationBar() {
        NavigationViewController.shared.removeBackButton()
        NavigationViewController.shared.setTitle(title: (isUpdate ? kUpdateTitle : kCreateTitle))
        NavigationViewController.shared.addCancelButton()
    }
    
    func configureUI() {
        createButton.setTitle((isUpdate ? "UPDATE" : "CREATE"), for: .normal)
        clearButton.setTitle((isUpdate ? "DELETE" : "CLEAR"), for: .normal)
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
    
    @IBAction func createOrUpdateTransformer () {
        APIServiceClient.shared.createOrUpdateTransformer(path: URLPath.Transformers,isUpdate: isUpdate, tranformerJson: (isUpdate ? configureJsonToUpdateTransformer(_id: tranformer.id!) : configureJsonToCreateTransformer() ), success: { (data, response, error) in
            do {
                let transformerJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                Transformer.shared.configure(JSON: transformerJson as! [AnyHashable : Any])
//                if self.isUpdate {
//                    TransformerCoreData.updateTransformerFromCoreData(transformer: Transformer.shared)
//                }
//                else {
//                    TransformerCoreData.saveTransformerToCoredata(transformer: Transformer.shared)
//                }
                DispatchQueue.main.async {
                    NavigationViewController.shared.popViewController(animated: true)
                }
            } catch  { }
        }) { (error) -> (Void) in
            print(error)
        }
    }
    
    
    
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
    
    @IBAction func clearFields () {
        if isUpdate {
            APIServiceClient.shared.deleteTransformer(path: (URLPath.Transformers + "/" + tranformer.id!), success: { (data, response, error) in
                NavigationViewController.shared.popViewController(animated: true)
            }) { (error) -> (Void) in
                
            }
        } else {
            nameTextField.text = ""; strengthTextField.text = ""; intelligenceTextField.text = ""; speedTextField.text = ""; enduranceTextField.text = ""; rankTextField.text = ""; courageTextField.text = ""; firepowerTextField.text = ""; skillTextField.text = "";
        }
    }
}

extension CreateTransformerViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
