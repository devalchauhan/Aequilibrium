//
//  TeamTableViewCell.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var autobotName : UILabel!
    @IBOutlet var autobotImage : UIImageView!
    @IBOutlet weak var autobotButton : UIButton!
    @IBOutlet weak var decepticonName : UILabel!
    @IBOutlet var decepticonImage : UIImageView!
    @IBOutlet weak var decepticonButton : UIButton!
    
    var autobotUpdateClosure: (() -> Void)?
    var decepticonUpdateClosure: (() -> Void)?
    
    // Configure the cell here
    func autobotUpdateConfigure(transformer:Transformer, autobotUpdateClosure: (() -> Void)?) {
        self.autobotUpdateClosure = autobotUpdateClosure
    }
    
    func decepticonUpdateConfigure(transformer:Transformer, decepticonUpdateClosure: (() -> Void)?) {
        self.decepticonUpdateClosure = decepticonUpdateClosure
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
