//
//  Colour.swift
//  paletteGenerator
//
//  Created by Luke Harries on 5/04/17.
//  Copyright © 2017 Luke Harries. All rights reserved.
//

import Foundation

struct ColourStyle {
    var darkHex: String
    var lightHex: String
}

extension ColourStyle {
    init?(json: [String: String]) {
        guard let darkHex = json["darkHex"],
            let lightHex = json["lightHex"] else {
                return nil
        }
        self.darkHex = darkHex
        self.lightHex = lightHex
    }
}
