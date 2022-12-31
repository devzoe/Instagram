//
//  UITextField.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit

extension UITextField {
    func setPlaceHolder(_ placeHolder : String, _ color : UIColor) {
        self.placeholder = placeHolder
        //플레이스홀더 글씨 색 정하기
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
