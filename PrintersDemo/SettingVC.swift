//
//  SettingVC.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/15/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import UIKit
import Hero

class SettingVC: UIViewController {
    
    var printerSettingVC: PrinterSettingVC = PrinterSettingVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Setting"
    }

}
