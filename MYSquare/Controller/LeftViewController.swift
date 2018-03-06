//
//  LeftViewController.swift
//  KWDrawerController
//
//  Created by Kawoou on 2017. 2. 10..
//  Copyright © 2017년 Kawoou. All rights reserved.
//

import UIKit

class LeftViewController: BaseController {
    
    @IBOutlet weak var tableviewLeftMenu: UITableView!
    
    var leftMenuArr  : [String] = ["Yanlızca 9.0 ve Üzeri Mekanları Göster","Log Out"]
    public static var comeFormLeftMenu : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewLeftMenu?.register(LeftMenuTableViewCell.nib, forCellReuseIdentifier: LeftMenuTableViewCell.identifier)
        tableviewLeftMenu?.delegate = self
        tableviewLeftMenu?.dataSource = self

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension LeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableviewLeftMenu.frame.height * 0.1
    }
    
    
}

extension LeftViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTableViewCell.identifier, for: indexPath) as? LeftMenuTableViewCell {
            cell.labelCellName.text = self.leftMenuArr[indexPath.section]
           return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return leftMenuArr.count
    
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leftMenuData"), object: nil)
        LeftViewController.comeFormLeftMenu = true
        self.dismiss(animated: true, completion: nil)
        case 1:
        self.performSegue(withIdentifier: "sequeLogOut", sender: nil)
        default:
            break;
        }
        

        
        
    }
    
}
