//
//  Storyboard.swift
//  Transformers
//
//  Created by Deval on 15/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK:- Segue identifires
    struct Identifier {
        static let TeamViewController = "TeamViewController"
        static let CreateTransformerViewController = "CreateTransformerViewController"
        static let ResultViewController = "ResultViewController"
    }
    
}

struct ViewControllerInstence {
    static func fromStoryboard(_ storyboard: UIStoryboard, identifire: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifire)
    }
}

