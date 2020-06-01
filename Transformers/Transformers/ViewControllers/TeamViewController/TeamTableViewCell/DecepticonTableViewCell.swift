//
//  DecepticonTableViewCell.swift
//  Transformers
//
//  Created by Deval Chauhan on 31/05/20.
//  Copyright © 2020 Deval. All rights reserved.
//

import UIKit

class DecepticonTableViewCell: UITableViewCell {

    /// Label to display decepticonName
    @IBOutlet weak var decepticonName : UILabel!
    
    @IBOutlet weak var decepticonDetail : UILabel!
    /// UIImageView to display decepticonImage
    @IBOutlet var decepticonImage : UIImageView!
    /// Button to handle decepticon update event

    var decepticonItem : Transformer? {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.setNeedsLayout()
                self.setNeedsDisplay()
            }
            self.decepticonName.text = self.decepticonItem?.name
            self.decepticonDetail.text = details()
            let decepticonImageURL = self.decepticonItem?.team_icon
            self.decepticonImage.sd_setImage(with: URL(string: decepticonImageURL!), placeholderImage: UIImage(named: "no_image.png"))
    
        }
    }
    func details() -> String {
        return "Strength: \(self.decepticonItem?.strength.toString() ?? ""), " +
        "Intelligence: \(self.decepticonItem?.intelligence.toString() ?? ""), " +
        "Speed: \(self.decepticonItem?.speed.toString() ?? ""), " +
        "Endurance: \(self.decepticonItem?.endurance.toString() ?? ""), " +
        "Rank: \(self.decepticonItem?.rank.toString() ?? ""), " +
        "Courage: \(self.decepticonItem?.courage.toString() ?? ""), " +
        "Firepower: \(self.decepticonItem?.firepower.toString() ?? ""), " +
        "Skill: \(self.decepticonItem?.skill.toString() ?? "")"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.roundedBottomCorner()
        self.contentView.backgroundColor = .cellBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
