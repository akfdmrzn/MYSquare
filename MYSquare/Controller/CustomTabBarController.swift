//
//  CustomTabBarController.swift
//  TabbarDemo
//
//  Created by KO on 1.08.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit
import SideMenu

class CustomTabBarController : UITabBarController {
   
    @IBAction func leftMenuButton(_ sender: Any) {
         present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
        
    }
    var color = UIColor(red: 48.0/255.0, green: 158.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tabBar.isHidden = true
        
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
       
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuShadowOpacity = 1.0
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuAnimationFadeStrength = 0.6
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
}

