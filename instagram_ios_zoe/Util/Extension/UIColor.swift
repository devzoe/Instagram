//
//  UIColor.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    
    class var buttonIsEnableFalse: UIColor { UIColor(hex: 0xB6D7F4) }
    class var buttonIsEnableTrue: UIColor { UIColor(hex: 0x4295F7)}
    class var labelGray:UIColor {
        UIColor(hex: 0x6F6F6F)
    }
    class var buttonGray: UIColor{
        UIColor(hex: 0xECECEC)
    }
}
