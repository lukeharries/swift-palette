//
//  Palette.swift
//  paletteGenerator
//
//  Created by Luke Harries on 5/04/17.
//  Copyright © 2017 Luke Harries. All rights reserved.
//

import Foundation

struct Palette {
    var colourStyles : [ColourStyle]
    var fontStyles : [FontStyle]
}

extension Palette {
    init?(json: [String: Any]) {
        guard let palette = json["palette"] as? [String: Any] else {
                return nil
        }
        
        guard let colourStyles = palette["colourStyles"] as? [[String: String]],
            let fontStyles = palette["fontStyles"] as? [[String: Any]] else {
            return nil
        }
        
        var colourStyleModels = [ColourStyle]()
        var fontStyleModels = [FontStyle]()
        
        for style in colourStyles {
            guard let styleModel = ColourStyle(json: style) else {
                return nil
            }
            colourStyleModels.append(styleModel)
        }
        
        for style in fontStyles {
            guard let styleModel = FontStyle(json: style) else {
                return nil
            }
            fontStyleModels.append(styleModel)
        }
        
        self.colourStyles = colourStyleModels
        self.fontStyles = fontStyleModels
    }
}
