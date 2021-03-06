//
//  UILable+LineHeight.swift
//  Boozehound
//
//  Created by Mital Solanki on 25/02/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    func setLineHeight(lineHeight: CGFloat)
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}