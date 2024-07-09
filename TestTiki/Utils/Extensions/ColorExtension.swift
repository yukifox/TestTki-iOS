//
//  ColorExtension.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//

import UIKit

struct Color {
    static let white = Color.appColor(.white)
    static let black = Color.appColor(.black)
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue)!
    }
}

extension Color {
    enum AssetsColor: String {
        case white = "White"
        case black = "Black"
    }
}


