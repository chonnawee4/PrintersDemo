//
//  MainVC.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/15/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import UIKit


class MainVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addBtn.layer.cornerRadius = addBtn.bounds.width/2
        addBtn.backgroundColor = UIColor.red
        addBtn.addTarget(self, action: #selector(addTransaction), for: UIControlEvents.touchUpInside)
        
        let heightDiff = addBtn.frame.size.height - self.tabBar.frame.size.height
        if heightDiff < 0 {
            addBtn.center = self.tabBar.center
        } else {
            var center = self.tabBar.center
            center.y = center.y - heightDiff/2
            addBtn.center = center
        }
        
        self.view.addSubview(addBtn)
    }
    
    @IBAction func addTransaction() {
        print("tset")
    }
    
}
