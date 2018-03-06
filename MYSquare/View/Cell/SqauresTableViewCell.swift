//
//  SqauresTableViewCell.swift
//  MYSquare
//
//  Created by akif demirezen on 24/02/2018.
//  Copyright © 2018 demirezenOrganization. All rights reserved.
//

import UIKit

class SqauresTableViewCell: UITableViewCell {
    @IBOutlet weak var labelNameOfSquare: CustomLabel!
    @IBOutlet weak var labelOfAddress: CustomLabel!
    @IBOutlet weak var labelOfPhone: CustomLabel!
    @IBOutlet weak var mageViewOfStar: UIImageView!
    @IBOutlet weak var labelOfRating: CustomLabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    func configureWithItem(item : ResponseModelData, index : Int){
        self.layoutIfNeeded()
        self.labelNameOfSquare.text = item.venues[index].name
        if item.venues[index].address == ""{
        self.labelOfAddress.text = "Adres Bilgisi Yok"
        }
        else{
        self.labelOfAddress.text = item.venues[index].address
        }
        if  item.venues[index].phone == ""{
        self.labelOfPhone.text = "Telefon Bilgisi Yok"
        }
        else{
        self.labelOfPhone.text = item.venues[index].phone
        }
        self.labelOfRating.text = String(item.venues[index].rating)
        if item.venues[index].rating >= 9.0{
            self.labelOfRating.textColor = UIColor(red: 148/255, green: 224/255, blue: 90/255, alpha: 1.0)
            self.mageViewOfStar.image = #imageLiteral(resourceName: "stargreen")
         }
        else if item.venues[index].rating >= 3.5 && item.venues[index].rating <= 8.9{
            self.labelOfRating.textColor = UIColor(red: 232/255, green: 228/255, blue: 82/255, alpha: 1.0)
            self.mageViewOfStar.image = #imageLiteral(resourceName: "staryellow")
        }
        else{
            self.mageViewOfStar.image = #imageLiteral(resourceName: "starred")
            self.labelOfRating.textColor = UIColor.red
        }
        
        
    }

    
}
