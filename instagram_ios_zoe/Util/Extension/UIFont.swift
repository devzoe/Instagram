//
//  UIFont.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Foundation
import UIKit

extension UIFont {

    static func billabong(size: CGFloat) -> UIFont {
        return UIFont(name: "billabong", size: size)!
    }
    public enum NotoSansType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
    }

    static func NotoSans(_ type: NotoSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-\(type.rawValue)", size: size)!
    }
    
    public enum RobotoType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
    }

    static func Roboto(_ type: RobotoType, size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-\(type.rawValue)", size: size)!
    }
}
