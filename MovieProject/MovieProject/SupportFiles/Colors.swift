//
//  Colors.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import Foundation
import UIKit

//MARK: - Color for work
enum Color {
    static let tabbarBackgroundColor = hexStringToUIColor(hex: "D43E4E")
    static let selectItemsTabbar = hexStringToUIColor(hex: "FFFFDD")
    static let thremeColor = hexStringToUIColor(hex: "2E2836")
}

//MARK: - Functions for work
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
