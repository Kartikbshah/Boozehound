//
//  CALayer+BorderUIColor.swift
//  Boozehound
//
//  Created by Mital Solanki on 24/02/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import Foundation
import UIKit

extension CALayer
{
    func setBorderUIColor(color: UIColor)
    {
        self.borderColor = color.CGColor
    }
    
    func BorderUIColor() -> UIColor
    {
        return UIColor(CGColor: self.borderColor!)
    }
}