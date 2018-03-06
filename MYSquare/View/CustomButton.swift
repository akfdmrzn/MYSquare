//
//  CustomButton.swift
//  KonusarakOgren
//
//  Created by akif demirezen on 19/07/2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    
    
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
    @IBInspectable var buttonTextFontSize: CGFloat = 0 {
        didSet {
            overrideButtonFontSize(fontSize: buttonTextFontSize)
        }
    }
    @IBInspectable var isBold: Bool = false {
        didSet {
            overrideButtonFontSize(fontSize: buttonTextFontSize)
        }
    }
           func returnTextFont()->String{
        
        if isBold == true{
            return "HelveticaNeue"
        }
        else{
            return "HelveticaNeue"
        }
        
    }
    
    func overrideButtonFontSize(fontSize:CGFloat){
        
        let currentFontName =  returnTextFont()
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.6)
            self.titleLabel?.font = calculatedFont
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont(name:currentFontName, size: fontSize * 0.7)
            self.titleLabel?.font = calculatedFont
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont = UIFont(name:  currentFontName, size: fontSize * 0.8)
            self.titleLabel?.font = calculatedFont
            break
        case 667.0: //iphone 7 =>
            calculatedFont = UIFont(name:  currentFontName, size: fontSize*0.9)
            self.titleLabel?.font = calculatedFont
            break
        case 736.0: //iphone 7+plus => 5.5 inch
            calculatedFont = UIFont(name:  currentFontName, size: fontSize*1.0)
            self.titleLabel?.font = calculatedFont
            break
        case 1024.0: //ipad for 9.7 inch
            calculatedFont = UIFont(name:  currentFontName, size: fontSize*2.0)
            self.titleLabel?.font = calculatedFont
            break
        case 1112.0: //ipad for 10.5 inch
            calculatedFont = UIFont(name:  currentFontName, size: fontSize*2.5)
            self.titleLabel?.font = calculatedFont
            break
        case 1366.0: //ipad for 12.9 inch
            calculatedFont = UIFont(name:  currentFontName, size: fontSize*3.0)
            self.titleLabel?.font = calculatedFont
            break
        default:
            print("not an iPhone")
            break
        }
        
    }
    
    
    
}



