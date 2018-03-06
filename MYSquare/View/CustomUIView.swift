//
//  CustomTextView.swift
//  KonusarakOgren
//
//  Created by akif demirezen on 19/07/2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {
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

extension UIView {
    func addGradientLayer (direction: GradientDirection,color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.5 , 1.0]
        gradient.startPoint = getGradPoint(direction: direction, type: .start)
        gradient.endPoint = getGradPoint(direction: direction, type: .end)
        gradient.frame = self.layer.bounds
        //gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width , height: self.frame.size.height)
        //self.layer.addSublayer(gradient)
        self.layer.insertSublayer(gradient, at: 0)
    }
    func getGradPoint (direction : GradientDirection, type: GPType) -> CGPoint {
        switch  type {
        case .start :
            switch direction {
            case .left:
                return CGPoint(x: 1.0, y: 1.0)
            case .right:
                return CGPoint(x: 0.0, y: 1.0)
            case .up:
                return CGPoint(x:1.0, y: 0.0)
            case .down:
                return CGPoint(x:1.0, y: 1.0)
            }
        case .end :
            switch direction {
            case .left:
                return CGPoint(x: 0.0, y: 1.0)
            case .right:
                return CGPoint(x:1.0, y: 1.0)
            case .up:
                return CGPoint(x:1.0, y: 1.0)
            case .down:
                return CGPoint(x:1.0, y: 0.0)
            }
            
            
        }
    }
    public enum GradientDirection : String {
        
        case left // Visually left aligned
        
        case up // Visually centered
        
        case right // Visually right aligned
        
        case down // Fully-justified. The last line in a paragraph is natural-aligned.
        
    }
    public enum GPType : String {
        case start
        case end
    }
    
}
extension UIView {
    func dropShadow(scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 20.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

