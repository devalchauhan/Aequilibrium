//
//  TeamTableViewCell.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
/// This is a class created for TeamTableViewCell
class TeamTableViewCell: UITableViewCell {
    /// Label to display autobotName
    @IBOutlet weak var autobotName : UILabel!
    /// UIImageView to display autobotImage
    @IBOutlet var autobotImage : UIImageView!
    /// Button to handle autobot update event
    @IBOutlet weak var autobotButton : UIButton!
    /// Label to display decepticonName
    @IBOutlet weak var decepticonName : UILabel!
    /// UIImageView to display decepticonImage
    @IBOutlet var decepticonImage : UIImageView!
    /// Button to handle decepticon update event
    @IBOutlet weak var decepticonButton : UIButton!
    /// autobotUpdate event handler
    var autobotUpdateClosure: (() -> Void)?
    /// decepticonUpdate event handler
    var decepticonUpdateClosure: (() -> Void)?
    
    func autobotUpdateConfigure(transformer:Transformer, autobotUpdateClosure: (() -> Void)?) {
        self.autobotUpdateClosure = autobotUpdateClosure
    }
    
    func decepticonUpdateConfigure(transformer:Transformer, decepticonUpdateClosure: (() -> Void)?) {
        self.decepticonUpdateClosure = decepticonUpdateClosure
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension TeamTableViewCell {
    @IBAction func autobotUpdatePressed(_ sender: Any) {
        guard let closure = autobotUpdateClosure else { return }
        closure()
    }
    
    @IBAction func decepticonUpdatePressed(_ sender: Any) {
        guard let closure = decepticonUpdateClosure else { return }
        closure()
    }
}
