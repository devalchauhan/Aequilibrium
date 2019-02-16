//
//  ServerConfiguration.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation

struct ServerURL {
    static let BaseURL = "https://transformers-api.firebaseapp.com/"
}

struct URLPath {
    static let AllSpark = "\(ServerURL.BaseURL)allspark"
    static let Transformers = "\(ServerURL.BaseURL)transformers"
}
