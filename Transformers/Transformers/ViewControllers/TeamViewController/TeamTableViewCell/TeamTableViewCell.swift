//
//  TeamTableViewCell.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var transformerName : UILabel!
    @IBOutlet var transformerImage : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
