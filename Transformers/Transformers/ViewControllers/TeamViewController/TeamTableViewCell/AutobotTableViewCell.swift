//
//  AutobotTableViewCell.swift
//  Transformers
//
//  Created by Deval Chauhan on 31/05/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import UIKit

class AutobotTableViewCell: UITableViewCell {

    /// Label to display autobotName
    @IBOutlet weak var autobotName : UILabel!
    /// UIImageView to display autobotImage
    @IBOutlet var autobotImage : UIImageView!
    /// Button to handle autobot update event
    @IBOutlet weak var autobotButton : UIButton!
    /// autobotUpdate event handler
    var autobotUpdateClosure: (() -> Void)?
    var autobotItem : Transformer? {
        didSet {
            self.autobotName.text = self.autobotItem?.name
            let autobotImageURL = self.autobotItem?.team_icon
            self.autobotImage.sd_setImage(with: URL(string: autobotImageURL!), placeholderImage: UIImage(named: "no_image.png"))
            self.autobotUpdateConfigure(transformer: self.autobotItem ?? Transformer()) {
                Transformer.shared = self.autobotItem ?? Transformer()
                NavigationViewController.shared.gotoCreateTransformer(isUpdate: true)
            }
        }
    }
    func autobotUpdateConfigure(transformer:Transformer, autobotUpdateClosure: (() -> Void)?) {
           self.autobotUpdateClosure = autobotUpdateClosure
    }
    @IBAction func autobotUpdatePressed(_ sender: Any) {
        guard let closure = autobotUpdateClosure else { return }
        closure()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .lightGray
        self.contentView.roundedTopCorner()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
