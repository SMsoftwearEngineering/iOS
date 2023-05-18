//
//  UIColor + Extension.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

extension UIColor {
    /// hex sting -> UIColor
    static func makeColor(from hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >>  8) & 0xFF) / 255.0
        let blue = Double((rgb >>  0) & 0xFF) / 255.0
        
        return .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    static let SMPurple = UIColor.makeColor(from: "#9C89B8")
    static let SMRed = UIColor.makeColor(from: "#FF9494")
    static let SMGreen = UIColor.makeColor(from: "#CEEDC7")
    static let SMOrange = UIColor.makeColor(from: "#FFD4B2")
    static let SMYellow = UIColor.makeColor(from: "#FFF6BD")
    static let SMBlue = UIColor.makeColor(from: "#D7E3FC")
    static let SMPink = UIColor.makeColor(from: "#FFC8DD")
}
