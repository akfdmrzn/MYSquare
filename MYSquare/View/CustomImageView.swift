//
//  CustomImageView.swift
//  KonusarakOgren
//
//  Created by KO on 21.07.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
