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
    var autobotItem : Transformer? {
        didSet {
            self.autobotName.text = self.autobotItem?.name
            let autobotImageURL = self.autobotItem?.team_icon
            self.autobotImage.sd_setImage(with: URL(string: autobotImageURL!), placeholderImage: UIImage(named: "no_image.png"))
        }
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
