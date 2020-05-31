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
    /// UIImageView to display decepticonImage
    @IBOutlet var decepticonImage : UIImageView!
    /// Button to handle decepticon update event
    @IBOutlet weak var decepticonButton : UIButton!
    /// decepticonUpdate event handler
    var decepticonUpdateClosure: (() -> Void)?
    var decepticonItem : Transformer? {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.setNeedsLayout()
                self.setNeedsDisplay()
            }
            self.decepticonName.text = self.decepticonItem?.name
            let decepticonImageURL = self.decepticonItem?.team_icon
            self.decepticonImage.sd_setImage(with: URL(string: decepticonImageURL!), placeholderImage: UIImage(named: "no_image.png"))
            self.decepticonUpdateConfigure(transformer: self.decepticonItem ?? Transformer()) {
                Transformer.shared = self.decepticonItem ?? Transformer()
                NavigationViewController.shared.gotoCreateTransformer(isUpdate: true)
            }
        }
    }
    func decepticonUpdateConfigure(transformer:Transformer, decepticonUpdateClosure: (() -> Void)?) {
        self.decepticonUpdateClosure = decepticonUpdateClosure
    }
    @IBAction func decepticonUpdatePressed(_ sender: Any) {
        guard let closure = decepticonUpdateClosure else { return }
        closure()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.roundedBottomCorner()
        self.contentView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
