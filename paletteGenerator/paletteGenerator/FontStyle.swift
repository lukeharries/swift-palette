//
//  FontStyle.swift
//  paletteGenerator
//
//  Created by Luke Harries on 5/04/17.
//  Copyright © 2017 Luke Harries. All rights reserved.
//

import Foundation

struct FontStyle {
    var pointSize: Float
    var fontWeight: String
}

extension FontStyle {
    init?(json: [String: Any]) {
        guard let pointSize = json["pointSize"] as? Float,
            let fontWeight = json["fontWeight"] as? String else {
                return nil
        }
        
        self.pointSize = pointSize
        self.fontWeight = fontWeight
    }
}
