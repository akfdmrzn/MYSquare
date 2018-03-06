//
//  LeftMenuTableViewCell.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 31/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCellName: CustomLabel!

    
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
