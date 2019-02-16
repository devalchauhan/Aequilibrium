//
//  RightNavigationItem.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

let cancelButtonFontAwesome : String = "f057"
let addButtonFontAwesome : String = "f0fe"

extension NavigationViewController {
    
    func addPlusButton() {
        
        let unicodeIcon = Character(UnicodeScalar(UInt32(hexString: addButtonFontAwesome)!)!)
        self.topViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(unicodeIcon)", style: .plain, target: self, action: #selector(onPlusButtonClick(sender:)))
        let fontSize = 25
        self.topViewController!.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontsNames.fontAwesome.rawValue, size: CGFloat(fontSize))!,NSAttributedString.Key.foregroundColor: UIColor.cancelButton], for: .normal)
        self.topViewController!.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontsNames.fontAwesome.rawValue, size: CGFloat(fontSize))!,NSAttributedString.Key.foregroundColor: UIColor.cancelButton], for: .highlighted)
        self.topViewController!.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func addCancelButton() {
        
        let unicodeIcon = Character(UnicodeScalar(UInt32(hexString: cancelButtonFontAwesome)!)!)
        self.topViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(unicodeIcon)", style: .plain, target: self, action: #selector(onCancelButtonClick(sender:)))
        let fontSize = 25
        self.topViewController!.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontsNames.fontAwesome.rawValue, size: CGFloat(fontSize))!,NSAttributedString.Key.foregroundColor: UIColor.cancelButton], for: .normal)
        self.topViewController!.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontsNames.fontAwesome.rawValue, size: CGFloat(fontSize))!,NSAttributedString.Key.foregroundColor: UIColor.cancelButton], for: .highlighted)
        self.topViewController!.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    func gotoCreateTransformer(isUpdate : Bool) {
        let createTransformerViewController = ViewControllerInstence.fromStoryboard(Storyboard.main, identifire: Storyboard.Identifier.CreateTransformerViewController) as! CreateTransformerViewController
        createTransformerViewController.isUpdate = isUpdate
        NavigationViewController.shared.pushViewController(createTransformerViewController, animated: true)
    }
    
    @objc func onPlusButtonClick(sender: AnyObject?) {
        gotoCreateTransformer(isUpdate: false)
    }
    
    @objc func onCancelButtonClick(sender: AnyObject?) {
        NavigationViewController.shared.popViewController(animated: true)
    }
}

