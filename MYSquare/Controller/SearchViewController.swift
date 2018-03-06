//
//  ViewController.swift
//  MYSquare
//
//  Created by akif demirezen on 23/02/2018.
//  Copyright © 2018 demirezenOrganization. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var imageViewOfBackground: UIImageView!
    @IBOutlet weak var textFieldOfCity: CustomTextField!
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let gradientOne = UIColor(red: 102/255, green: 102/255, blue: 170/255, alpha: 1).cgColor
    let gradientTwo = UIColor(red: 205/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
    let gradientThree = UIColor(red: 102/255, green: 215/255, blue: 170/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldOfCity.attributedPlaceholder = NSAttributedString(string: "Şehir Giriniz", attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
        self.navigationController?.navigationBar.isHidden = true
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.imageViewOfBackground.layer.addSublayer(gradient)
        
        animateGradient()
    
    }
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 3.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    @IBAction func btnSearch(_ sender: Any) {
        LeftViewController.comeFormLeftMenu = false
        if self.textFieldOfCity.text == ""{
        DisplaySquareViewController.willSearchCity = "istanbul"
        }
        else{
        DisplaySquareViewController.willSearchCity = self.textFieldOfCity.text!
        }
        
        self.performSegue(withIdentifier: "segueGoToDisplayVC", sender: nil)
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let displayVC = segue.destination as? DisplaySquareViewController {
//            displayVC.willSearchCity = self.textFieldOfCity.text!
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}


