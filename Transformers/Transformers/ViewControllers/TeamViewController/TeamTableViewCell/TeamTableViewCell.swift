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
    
    var callbackClosure: (() -> Void)?
    
    // Configure the cell here
    func configure(callbackClosure: (() -> Void)?) {
        self.callbackClosure = callbackClosure
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func autobotButtonClicked(sender: AnyObject?) {
    
    }
    
    @IBAction func decepticonButtonClicked(sender: AnyObject?) {
        
    }
    
}
extension TeamTableViewCell {
    @IBAction func actionPressed(_ sender: Any) {
        guard let closure = callbackClosure else { return }
        closure()
    }
}
